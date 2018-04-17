from datetime import datetime

from django.db import models
from django.contrib.auth import get_user_model

from goods.models import Goods
from users.models import UserProfile
# Create your models here.
User = get_user_model()


class UserFav(models.Model):
    """
    用户收藏
    """
    user = models.ForeignKey(User, verbose_name="用户", on_delete=models.CASCADE)
    goods = models.ForeignKey(
        Goods,
        verbose_name="商品",
        help_text="商品id",
        on_delete=models.CASCADE)
    add_time = models.DateTimeField(default=datetime.now, verbose_name=u"添加时间")

    class Meta:
        verbose_name = '用户收藏'
        verbose_name_plural = verbose_name
        unique_together = ("user", "goods")

    def __str__(self):
        return self.user.name


class UserLeavingMessage(models.Model):
    """
    用户留言
    """
    MESSAGE_CHOICES = (
        (1, "留言"),
        (2, "投诉"),
        (3, "询问"),
        (4, "售后"),
        (5, "求购")
    )
    user = models.ForeignKey(User, verbose_name="用户", on_delete=models.CASCADE)
    message_type = models.IntegerField(
        default=1,
        choices=MESSAGE_CHOICES,
        verbose_name="留言类型",
        help_text=u"留言类型: 1(留言),2(投诉),3(询问),4(售后),5(求购)")
    subject = models.CharField(max_length=100, default="", verbose_name="主题")
    message = models.TextField(
        default="",
        verbose_name="留言内容",
        help_text="留言内容")
    file = models.FileField(
        upload_to="message/images/",
        verbose_name="上传的文件",
        help_text="上传的文件")
    add_time = models.DateTimeField(default=datetime.now, verbose_name="添加时间")

    class Meta:
        verbose_name = "用户留言"
        verbose_name_plural = verbose_name

    def __str__(self):
        return self.subject


class UserAddress(models.Model):
    """
    用户收货地址
    """
    user = models.ForeignKey(User, verbose_name="用户", on_delete=models.CASCADE)
    province = models.CharField(
        max_length=100,
        default="",
        verbose_name="省份",
        help_text='省份')
    city = models.CharField(
        max_length=100,
        default="",
        verbose_name="城市",
        help_text='城市')
    district = models.CharField(
        max_length=100,
        default="",
        verbose_name="区域",
        help_text='区域')
    address = models.CharField(
        max_length=100,
        default="",
        verbose_name="详细地址",
        help_text='详细地址')
    signer_name = models.CharField(
        max_length=100,
        default="",
        verbose_name="签收人",
        help_text='签收人')
    signer_mobile = models.CharField(
        max_length=11,
        default="",
        verbose_name="电话",
        help_text='签收人电话')
    add_time = models.DateTimeField(default=datetime.now, verbose_name="添加时间")
    default_address = models.CharField(max_length=10, default='0', verbose_name="默认收货地址", help_text="默认收货地址")
# '0'表示不是默认收货地址  '1'则是

    class Meta:
        verbose_name = "收货地址"
        verbose_name_plural = verbose_name

    def __str__(self):
        return self.address


# 会员列表,等级管理，积分管理
class Membership(models.Model):
    '''
    会员等级规则
    '''
    # LEVEL_MESSAGE = (
    # (0 , '普通'),
    # (1 , '青铜'),
    # (2 , '白银'),
    # (3 , '黄金'),
    # (4 , '白金'),
    # (5 , '钻石'),
    # (6 , '尊贵'),
    # )

    # level = models.IntegerField(default=0, verbose_name="等级", help_text="等级",choices=LEVEL_MESSAGE,unique=True)
    tier_name = models.CharField(
        default='',
        max_length=20,
        verbose_name='等级名称',
        help_text='等级名称',
        unique=True)
    min_bonus_point = models.IntegerField(
        default=0, verbose_name="最小积分数", help_text="最小积分数")
    min_owned = models.IntegerField(
        default=0,
        verbose_name="最小商品拥有数",
        help_text="最小商品拥有数")
    # check_in_sum = models.IntegerField(default=0, verbose_name="最小签到数", help_text="最小签到数")
    min_shared = models.IntegerField(
        default=0, verbose_name="最小分享数", help_text="最小分享数")
    color = models.CharField(
        default='',
        max_length=10,
        verbose_name='背景颜色',
        help_text='背景颜色')
    decorate_image = models.ImageField(
        upload_to='user/decorate',
        verbose_name='用户装饰图片',
        help_text='用户装饰图片',
        default='')
    banner_image = models.ImageField(
        upload_to='user/banner',
        verbose_name='皇冠图片',
        help_text='皇冠图片',
        default='')
    discount_rate = models.FloatField(
        default=0, verbose_name="优惠等级", help_text="优惠等级")
    is_exc_shipment_free = models.BooleanField(
        default=False, verbose_name='是否可置换免邮', help_text='是否可置换免邮')
    is_exc_new = models.BooleanField(
        default=False,
        verbose_name='是否可置换全新包',
        help_text='是否可置换全新包')
    is_special_available = models.BooleanField(
        default=False,
        verbose_name='是否可购买或置换特殊款式',
        help_text='是否可购买或置换特殊款式')

    class Meta:
        verbose_name = "会员等级规则"
        verbose_name_plural = verbose_name

    def __str__(self):
        # return str(self.level),self.LEVEL_MESSAGE[0][self.level]
        return self.tier_name


class UserMembershipInfo(models.Model):
    '''
    会员资料信息
    '''
    user = models.OneToOneField(
        UserProfile,
        related_name='membershipInfo',
        verbose_name='用户',
        help_text='用户',
        on_delete=models.CASCADE)
    membership = models.ForeignKey(
        Membership,
        related_name='membershipInfo',
        verbose_name='会员等级',
        help_text='会员等级',
        on_delete=models.CASCADE)

    bonus = models.IntegerField(default=0, verbose_name="积分", help_text="积分")
    owned_sum = models.IntegerField(
        default=0,
        verbose_name="商品拥有数",
        help_text="商品拥有数")
    shared_sum = models.IntegerField(
        default=0, verbose_name="分享数", help_text="分享数")
    check_in_sum = models.IntegerField(
        default=0, verbose_name="签到数", help_text="签到数")

    check_in_status = models.BooleanField(default=False,verbose_name='每日签到状态',help_text='每日签到状态')
    last_check_in_time = models.DateTimeField(default=datetime.now,verbose_name='最后签到时间',help_text='最后签到时间')

    class Meta:
        verbose_name = '会员资料信息'
        verbose_name_plural = verbose_name

    def __str__(self):
        return self.membership.tier_name
