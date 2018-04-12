# -*- coding: utf-8 -*-

# pip install pycryptodome
__author__ = 'bobby'

from datetime import datetime
from Crypto.PublicKey import RSA
from Crypto.Signature import PKCS1_v1_5
from Crypto.Hash import SHA256
from base64 import b64encode, b64decode
from urllib.parse import quote_plus
from urllib.parse import urlparse, parse_qs
from urllib.request import urlopen
from base64 import decodebytes, encodebytes
from utils.payConfig import APPID,PRIVATE_KEY ,ALI_PUBILE_KEY

import json

import cProfile
import pstats
import os
# 性能分析装饰器定义
def do_cprofile(filename):
    """
    Decorator for function profiling.
    """
    def wrapper(func):
        def profiled_func(*args, **kwargs):
            # Flag for do profiling or not.
            DO_PROF = os.getenv("PROFILING")
            if DO_PROF:
                profile = cProfile.Profile()
                profile.enable()
                result = func(*args, **kwargs)
                profile.disable()
                profile.print_stats(sort='time')
                # Sort stat by internal time.
                sortby = "tottime"
                ps = pstats.Stats(profile).sort_stats(sortby)
                ps.dump_stats(filename)
            else:
                result = func(*args, **kwargs)
            return result
        return profiled_func
    return wrapper


class AliPay(object):
    """
    支付宝支付接口
    """
    def __init__(self, appid, app_notify_url, app_private_key,
                 alipay_public_key, return_url, debug=False):
        self.appid = appid
        self.app_notify_url = app_notify_url
        self.return_url = return_url
        self.app_private_key = RSA.importKey(app_private_key)
        self.alipay_public_key = RSA.import_key(alipay_public_key)
        # self.app_private_key_path = app_private_key
        # self.app_private_key = None
        # with open(self.app_private_key_path) as fp:
        #     self.app_private_key = RSA.importKey(fp.read())
        #
        # self.alipay_public_key_path = alipay_public_key
        # with open(self.alipay_public_key_path) as fp:
        #     self.alipay_public_key = RSA.import_key(fp.read())
        if debug is True:
            self.__gateway = "https://openapi.alipaydev.com/gateway.do"
        else:
            self.__gateway = "https://openapi.alipay.com/gateway.do"

    def direct_pay(self, subject, out_trade_no, total_amount, return_url=None, **kwargs):
        biz_content = {
            "subject": subject,
            "out_trade_no": out_trade_no,
            "total_amount": total_amount,
            "product_code": "FAST_INSTANT_TRADE_PAY",
            # "qr_pay_mode":4
        }

        biz_content.update(kwargs)
        data = self.build_body("alipay.trade.page.pay", biz_content, self.return_url)
        return self.sign_data(data)

    def build_body(self, method, biz_content, return_url=None):
        data = {
            "app_id": self.appid,
            "method": method,
            "charset": "utf-8",
            "sign_type": "RSA2",
            "timestamp": datetime.now().strftime("%Y-%m-%d %H:%M:%S"),
            "version": "1.0",
            "biz_content": biz_content
        }

        if return_url is not None:
            data["notify_url"] = self.app_notify_url
            data["return_url"] = self.return_url

        return data

    def sign_data(self, data):
        data.pop("sign", None)
        # 排序后的字符串
        unsigned_items = self.ordered_data(data)
        unsigned_string = "&".join("{0}={1}".format(k, v) for k, v in unsigned_items)
        sign = self.sign(unsigned_string.encode("utf-8"))
        # ordered_items = self.ordered_data(data)
        quoted_string = "&".join("{0}={1}".format(k, quote_plus(v)) for k, v in unsigned_items)

        # 获得最终的订单信息字符串
        signed_string = quoted_string + "&sign=" + quote_plus(sign)
        return signed_string

    def ordered_data(self, data):
        complex_keys = []
        for key, value in data.items():
            if isinstance(value, dict):
                complex_keys.append(key)

        # 将字典类型的数据dump出来
        for key in complex_keys:
            data[key] = json.dumps(data[key], separators=(',', ':'))

        return sorted([(k, v) for k, v in data.items()])

    def sign(self, unsigned_string):
        # 开始计算签名
        key = self.app_private_key
        signer = PKCS1_v1_5.new(key)
        signature = signer.sign(SHA256.new(unsigned_string))
        # base64 编码，转换为unicode表示并移除回车
        sign = encodebytes(signature).decode("utf8").replace("\n", "")
        return sign

    @do_cprofile("./mkm_run.prof")
    def _verify(self, raw_content, signature):
        # 开始计算签名
        key = self.alipay_public_key
        signer = PKCS1_v1_5.new(key)
        digest = SHA256.new()
        digest.update(raw_content.encode("utf8"))
        if signer.verify(digest, decodebytes(signature.encode("utf8"))):
            return True
        return False

    # import pstats
    # p = pstats.Stats('mkm_run.prof')
    # p.strip_dirs().sort_stats('cumtime').print_stats(10, 1.0, '.*')

    def verify(self, data, signature):
        if "sign_type" in data:
            sign_type = data.pop("sign_type")
        # 排序后的字符串
        unsigned_items = self.ordered_data(data)
        message = "&".join(u"{}={}".format(k, v) for k, v in unsigned_items)
        # message = "&".join(u"{}={}".format(k, v) for k, v in  message)

        return self._verify(message, signature)

if __name__ == "__main__":
    alipay = AliPay(
        appid=APPID,
        # app_private_key="../trade/keys/private_2048.txt",
        # alipay_public_key="../trade/keys/alipay_key_2048.txt",  # 支付宝的公钥，验证支付宝回传消息使用，不是你自己的公钥
        # 支付成功之后 回调url
        app_notify_url="http://127.0.0.1:8000/alipay/return/",
        app_private_key=PRIVATE_KEY ,
        alipay_public_key=ALI_PUBILE_KEY ,
        debug=True,  # 默认False,
        # 支付成功之后 返回到的重定向URL
        return_url="http://127.0.0.1:8000/"
    )

    # url = alipay.direct_pay(
        # subject="测试订单2",
        # out_trade_no="201702021889",
        # total_amount=101,
        # return_url="http://127.0.0.1:8000/"
    # )
    # re_url = "https://openapi.alipaydev.com/gateway.do?{data}".format(data=url)
    # print(re_url)  # 生成一个支付页面


    return_url = 'http:127.0.0.1:8000/?total_amount=101.00&timestamp=2018-04-05+14%3A49%3A56&sign=fP8LUzbKaFsGC4zBieDFXUl3GMMiwnx%2FYn0p16cN%2Ba3R5cvIJ2CTOMY%2FQei%2Bt1hLeGYTDMTDK9cUyhWlMPmX2bb3wsapgeIQifTqIM1msrwxALYbmTJ4pXWJt1iwrgpUbeEygwir6EUNuqPQMTUvHwaO5%2BKxRiPCKsUhYH74DLs5JS3QdmHohKrtLCLX%2F1wBDY1ku3Ki2t2oQ%2BWYdlX1idqoqzZ%2BFYK4idjog5qygcvXcOj4Ayxh73VZlW8avCFfLQHTR6e9VsOc7uhlCSyyLtBgs8Mag0U2n0ftK7wYFfQjGvQmp%2FPWjivU5d84RYTPp5rHnQQl5DsCCETU2EjA4Q%3D%3D&trade_no=2018040521001004880200439173&sign_type=RSA2&auth_app_id=2016091000481136&charset=utf-8&seller_id=2088102175032333&method=alipay.trade.page.pay.return&app_id=2016091000481136&out_trade_no=201702021889&version=1.0'
    o = urlparse(return_url)
    query = parse_qs(o.query)
    processed_query = {}
    ali_sign = query.pop("sign")[0]

    for key, value in query.items():
        processed_query[key] = value[0]
    print (alipay.verify(processed_query, ali_sign)) # 将生成支付页面的重定向的URL当做return_url来验证签名是否正确
