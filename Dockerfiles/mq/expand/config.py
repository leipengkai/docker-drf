# -*- coding:utf-8 -*-

# rabbitmq 
MQUSER = "rabbitmq"
MQPAWD = "rabbitmq"
MQIP = "localhost"
MQPORT = 5672
MQVHOST = "/"
MQEXCHANGE = "info"
MQEXCHANGETYPE = "direct"
QUEUENAME = 'info_queue'  # 当不自定义交换机时,指定队列名

# mysql
MYSQLHOST = "localhost"
MYSQLPORT = "3308"
MYSQLUSER = "root"
MYSQLPAWD = "123456"
MYSQLDB = "test"

# 阿里云短信key
ACCESSKEYID = ""
# 阿里云短信secret
ACCESSSECRET = ""
# 阿里云短信注册模板,其它模板另取变量名,并在smsserver.py中sms_pubilc_param()中添加
TEMPLATECODEREG = "SMS_166777256"
# 阿里云短信签名名称
SIGNNAME = ""

# QQ发送邮箱,设置服务器
SMTPSERVER = "smtp.qq.com"
# 发送者
SENDER = ''
# 授权码
PASS = ""

# test 帐号
TESTMOBILE = "13925848599"
TESTEMAIL = "1643076443@qq.com"
