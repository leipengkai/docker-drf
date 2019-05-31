from datetime import datetime

from django.db import models
from django.contrib.auth.models import AbstractUser
# from user_operation.models import UserMembershipInfo

# Create your models here.
class UserProfile(AbstractUser):
    """
    用户
    """
    username = models.CharField(
        max_length=30,
        null=True,
        blank=True,unique=True,
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
    image = models.ImageField(upload_to='users/avatar',verbose_name='用户头像',default='')
    # membershipInfo = models.OneToOneField(
        # UserMembershipInfo,
        # related_name='users',
        # default='',
        # verbose_name='会员资料',
        # help_text='用户资料',
        # on_delete=models.CASCADE)

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
