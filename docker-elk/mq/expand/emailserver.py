#!/usr/bin/env python
# -*- coding:utf-8 -*-

import smtplib
from email.header import Header
from email.mime.text import MIMEText
from email.utils import formataddr

from config import *
from db import *


def email(email, routing_key, action, target_type, code=None):
    """
    发送邮件
    :param email: 邮件
    :param routing_key: 路由关键字 eg: email_info
    :param action: 类型动作 不用但不可删除
    :param target_type: 消息类型 eg: email
    :param code: 随机码
    :return:
    """
    MSG = MysqlClient().get_template(routing_key)
    format_message = MIMEText(MSG.format(code), 'html', 'utf-8')
    format_message['From'] = formataddr(['', SENDER])
    format_message['To'] = email
    format_message['Subject'] = Header('验证邮箱', 'utf-8')
    smtp = smtplib.SMTP_SSL()
    smtp.connect(SMTPSERVER, 465)
    # 登录发信邮箱
    smtp.login(SENDER, PASS)
    # 发送邮件
    smtp.sendmail(SENDER, email, format_message.as_string())
    # 关闭服务器
    smtp.quit()
    # 记录日志
    MysqlClient().add(target=email, type=target_type, code=code, routing_key=routing_key)
    print('邮件已经发送,并加入日志')
