from datetime import datetime

from django.db import models
from django.contrib.auth.models import AbstractUser

# Create your models here.

# 会员列表,等级管理，积分管理
class Member(models.Model):
    '''
    会员等级
    '''
    LEVEL_MESSAGE = (
        (0 , '普通'),
        (1 , '青铜'),
        (2 , '白银'),
        (3 , '黄金'),
        (4 , '白金'),
        (5 , '钻石'),
        (6 , '尊贵'),
    )

    level = models.IntegerField(default=0, verbose_name="等级", help_text="等级",choices=LEVEL_MESSAGE,unique=True)
    integral  = models.IntegerField(default=0, verbose_name="积分", help_text="积分")
    owned_sum = models.IntegerField(default=0, verbose_name="商品拥有数", help_text="商品拥有数")
    sign_sum = models.IntegerField(default=0, verbose_name="签到数", help_text="签到数")
    share_sum = models.IntegerField(default=0, verbose_name="分享数", help_text="分享数")

    class Meta:
        verbose_name = "会员等级"
        verbose_name_plural = verbose_name

    def __str__(self):
        return str(self.level),self.LEVEL_MESSAGE[0][self.level]



class UserProfile(AbstractUser):
    """
    用户
    """
    name = models.CharField(
        max_length=30,
        null=True,
        blank=True,
        verbose_name="姓名")
    birthday = models.DateField(null=True, blank=True, verbose_name="出生年月")
    gender = models.CharField(max_length=6, choices=(
        ("male", u"男"), ("female", "女")), default="female", verbose_name="性别")
    mobile = models.CharField(
        null=True,
        blank=True,
        max_length=11,
        verbose_name="电话")
    email = models.EmailField(
        max_length=100,
        null=True,
        blank=True,
        verbose_name="邮箱")

    level = models.IntegerField(default=0, verbose_name="等级", help_text="等级")
    integral  = models.IntegerField(default=0, verbose_name="积分", help_text="积分")
    owned_sum = models.IntegerField(default=0, verbose_name="商品拥有数", help_text="商品拥有数")
    sign_sum = models.IntegerField(default=0, verbose_name="签到数", help_text="签到数")
    share_sum = models.IntegerField(default=0, verbose_name="分享数", help_text="分享数")

    class Meta:
        verbose_name = "用户"
        verbose_name_plural = verbose_name

    def __str__(self):
        return self.username


class VerifyCode(models.Model):
    """
    短信验证码
    """
    code = models.CharField(max_length=10, verbose_name="验证码")
    mobile = models.CharField(max_length=11, verbose_name="电话")
    add_time = models.DateTimeField(default=datetime.now, verbose_name="添加时间")

    class Meta:
        verbose_name = "短信验证码"
        verbose_name_plural = verbose_name

    def __str__(self):
        return self.code
