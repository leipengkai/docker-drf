import random,string
from datetime import datetime
from urllib.parse import quote
import base64
import hmac
import requests
from hashlib import sha1
import pytz



AccessKeyId = ""
AccessSecret = ""
sms_send_url = "http://dysmsapi.aliyuncs.com/"


class SMS():

    def sms_send(self,phone,msg):
        # 时区对象
        tz = pytz.timezone(pytz.country_timezones('cn')[0])
        param = {
            # 公共参数 https://help.aliyun.com/document_detail/101341.html?spm=a2c4g.11186623.6.608.23436ed1M5KxtK
            "AccessKeyId":AccessKeyId,
            "Action":"SendSms",
            "Format":"json",
            "RegionId":"cn-hangzhou", # 短信API的值
            "SignatureMethod":"HMAC-SHA1", # 签名方式
            "SignatureNonce":''.join(random.choice(string.ascii_letters + string.digits) for _ in range(32)), # 签名唯一随机数
            "SignatureVersion":"1.0", # 签名算法版本
            "Timestamp":datetime.now(pytz.utc).strftime('%Y-%m-%dT%H:%M:%SZ'), # bug:签名失败 必须为GMT时区 请求的时间戳 eg:2018-01-01T12:00:00Z
            "Version":"2017-05-25",
            # 业务参数 https://help.aliyun.com/document_detail/101414.html
            "PhoneNumbers": phone,
            "SignName": "快乐生活", # bug 短信签名名称
            "TemplateCode": "SMS_166777256",  # 短信模板ID
            # "TemplateParam": "{\"code\":\"5201\"}", # 短信模板变量对应的实际值，JSON格式
            # "TemplateParam": '{"code":"1111"}', # 短信模板变量对应的实际值，JSON格式
            }
        # 参数排序
        url_param = ""
        for k, v in sorted(param.items(),key=lambda x:x[0]):
            url_param += k + "=" +v +"&"
        url_param = url_param[:-1]

        # 在进行签名之前 对参数进行url编码
        # sign_str = quote(url_param,'utf-8')
        # s = str(s)
        s = quote(url_param.encode('utf-8'), 'utf-8')
        # print(s)
        s = s.replace('+', '%20')
        s = s.replace('*', '%2A')
        s = s.replace('%7E', '~')

        # print(s)
        self.str_to_sign = "GET&%2F&"+s

        try:
            # POST
            # headers = {
            #     'Content-Type': 'application/x-www-form-urlencoded',
            # }
            # param['Signature'] = self.hash_hmac(AccessSecret,sha1)
            # r = requests.post(sms_send_url, data=param, headers=headers)

            # GET
            url = sms_send_url+"?Signature="+self.hash_hmac(AccessSecret,sha1)+"&"+url_param
            r = requests.get(url)
            print(r.text)
        except Exception as e:
            print('EXCEPT:', e)


    def hash_hmac(self,AccessSecret , sha1):
        # HmacSHA1算法 + Base64 签名

        # AccessSecret  = AccessSecret + "&"
        # print(self.str_to_sign)
        hmac_code = hmac.new(self.str_to_sign.encode("utf-8"), AccessSecret.encode(), sha1).digest()

        return quote(base64.b64encode(hmac_code).decode(),"utf-8")

if __name__ == '__main__':
    sms = SMS()
    sms.sms_send("13925848599","test")
# 本地拼接的:
# AccessKeyId%3DLTAI0CZnH6J6FHSX%26Action%3DSendSms%26Format%3Djson%26PhoneNumbers%3D13925848599%26RegionId%3Dcn-hangzhou%26SignName%3D%25E5%25BF%25AB%25E4%25B9%2590%25E7%2594%259F%25E6%25B4%25BB%26SignatureMethod%3DHMAC-SHA1%26SignatureNonce%3DjMUd97rCgncF7yY3a9swjvR3tHYgwtMm%26SignatureVersion%3D1.0%26TemplateCode%3DSMS_166777256%26TemplateParam%3D%257B%2522code%2522%253A%25221111%2522%257D%26Timestamp%3D2019-05-31T06%253A53%253A25Z%26Version%3D2017-05-25
# 正确的:
# AccessKeyId%3DLTAI0CZnH6J6FHSX%26Action%3DSendSms%26Format%3Djson%26PhoneNumbers%3D13925848599%26RegionId%3Dcn-hangzhou%26SignName%3D%E5%BF%AB%E4%B9%90%E7%94%9F%E6%B4%BB%26                        SignatureMethod%3DHMAC-SHA1%26SignatureNonce%3DjMUd97rCgncF7yY3a9swjvR3tHYgwtMm%26SignatureVersion%3D1.0%26TemplateCode%3DSMS_166777256%26TemplateParam%3D%7B%22code%22%3A%221111%22%7D%26              Timestamp%3D2019-05-31T06%3A53%3A25Z%26    Version%3D2017-05-25

# SignName  TemplateParam  Timestamp

