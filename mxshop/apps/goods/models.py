from datetime import datetime

from django.db import models
from DjangoUeditor.models import UEditorField

from users.models import UserProfile
# Create your models here.


class GoodsCategory(models.Model):
    """
    商品类别
    """
    CATEGORY_TYPE = (
        (1, "一级类目"),
        (2, "二级类目"),
        (3, "三级类目"),
    )

    name = models.CharField(
        default="",
        max_length=30,
        verbose_name="类别名",
        help_text="类别名")
    code = models.CharField(
        default="",
        max_length=30,
        verbose_name="类别code",
        help_text="类别code")
    desc = models.TextField(default="", verbose_name="类别描述", help_text="类别描述")
    category_type = models.IntegerField(
        choices=CATEGORY_TYPE,
        verbose_name="类目级别",
        help_text="类目级别")
    parent_category = models.ForeignKey(
        "self",
        null=True,
        blank=True,
        verbose_name="父类目级别",
        help_text="父目录",
        related_name="sub_cat",
        on_delete=models.CASCADE)

    is_tab = models.BooleanField(
        default=False,
        verbose_name="是否导航",
        help_text="是否导航")
    add_time = models.DateTimeField(default=datetime.now, verbose_name="添加时间")

    class Meta:
        verbose_name = "商品类别"
        verbose_name_plural = verbose_name

    def __str__(self):
        return self.name


class GoodsCategoryBrand(models.Model):
    """
    品牌名
    """
    category = models.ForeignKey(
        GoodsCategory,
        related_name='brands',
        null=True,
        blank=True,
        verbose_name="商品类目",
        on_delete=models.CASCADE,
        limit_choices_to={
            'category_type': 1})
    name = models.CharField(
        default="",
        max_length=30,
        verbose_name="品牌名",
        help_text="品牌名")

    desc = models.TextField(
        default="",
        max_length=200,
        verbose_name="品牌描述",
        help_text="品牌描述")
    image = models.ImageField(max_length=200, upload_to="brands/")
    add_time = models.DateTimeField(default=datetime.now, verbose_name="添加时间")

    class Meta:
        verbose_name = "品牌"
        verbose_name_plural = verbose_name
        db_table = "goods_goodsbrand"

    def __str__(self):
        return self.name


class Spec(models.Model):
    """规格(属性)表"""
    name = models.CharField(null=False,verbose_name="规格名",max_length=126)

    class Meta:
        verbose_name = "规格(属性)"
        verbose_name_plural = verbose_name

    def __str__(self):
        return self.name

class SpecValue(models.Model):
    """规格(属性)值表"""
    value = models.CharField(null=False,verbose_name="规格值",max_length=126)
    # 以一方的Model为多方的字段.related_name为自己的Model.方便drf与django的反向查询一致
    spec = models.ForeignKey(Spec, verbose_name="规格", on_delete=models.CASCADE,related_name="specvalue")

    class Meta:
        verbose_name = "规格(属性)值" # Model在侧边栏的显示
        verbose_name_plural = verbose_name  # 解决admin侧边栏的英文复数问题

    def __str__(self):
        return self.value  # 以str类型的方式去显示此Model

class Goods(models.Model):
    """
    商品
    """
    category = models.ForeignKey(
        GoodsCategory,
        verbose_name="商品类目",
        on_delete=models.CASCADE)
    goods_sn = models.CharField(
        max_length=50,
        default="",
        verbose_name="商品唯一货号")
    name = models.CharField(max_length=100, verbose_name="商品名")
    click_num = models.IntegerField(default=0, verbose_name="点击数")
    sold_num = models.IntegerField(default=0, verbose_name="商品销售量")
    fav_num = models.IntegerField(default=0, verbose_name="收藏数")
    goods_num = models.IntegerField(default=0, verbose_name="库存数")
    market_price = models.FloatField(default=0, verbose_name="市场价格")
    shop_price = models.FloatField(default=0, verbose_name="本店价格")
    goods_brief = models.TextField(max_length=500, verbose_name="商品简短描述")
    goods_desc = UEditorField(
        verbose_name=u"内容",
        imagePath="goods/images/",
        width=1000,
        height=300,
        filePath="goods/files/",
        default='')
    ship_free = models.BooleanField(default=True, verbose_name="是否承担运费")
    goods_front_image = models.ImageField(
        upload_to="goods/images/",
        null=True,
        blank=True,
        verbose_name="封面图")
    is_new = models.BooleanField(default=False, verbose_name="是否新品",help_text='是否新品:True or False')
    is_hot = models.BooleanField(default=False, verbose_name="是否热销",help_text='是否热销:True or False')
    add_time = models.DateTimeField(default=datetime.now, verbose_name="添加时间")
    spec = models.ManyToManyField(Spec,related_name="goods") # 多对多关联 django会默认生成第三张关联表,也可以自定义关联表
    specvalue = models.ManyToManyField(SpecValue,related_name="goods")  # 可以不关联

    class Meta:
        verbose_name = '商品'
        verbose_name_plural = verbose_name

    def __str__(self):
        return self.name

class SKU(models.Model):
    """ 具体商品:sku
    Standard Product Unit （标准化产品单元):Goods.eg:iPhone6
    stock keeping unit(库存量单位):GoodsSku. eg:iPhone6 32G 白色,iPhone6 128G 白色是另一个SKU
    """
    goods = models.ForeignKey(Goods,related_name="sku",on_delete=models.CASCADE,verbose_name="sku所属商品")
    name = models.CharField(null=False,verbose_name="sku名",help_text='具体的商品全名',max_length=126)
    price = models.DecimalField(max_digits=7,decimal_places=2,default=0, verbose_name="商品价格")
    stock = models.IntegerField(default=0, verbose_name="商品库存")


    class Meta:
        verbose_name = "sku具体商品"
        verbose_name_plural = verbose_name

    def __str__(self):
        return self.name

class SKUValue(models.Model):
    sku = models.ForeignKey(SKU,related_name="skuvalue", verbose_name="sku商品",on_delete=models.CASCADE)
    specvalue = models.OneToOneField(SpecValue,related_name="skuvalue", verbose_name="sku商品的规格值",on_delete=models.CASCADE)# ,parent_link=False

    class Meta:
        verbose_name = "sku值"
        verbose_name_plural = verbose_name

    def __str__(self):
        return self.specvalue.value # 注意比较要返回str类型

class IndexAd(models.Model):
    category = models.ForeignKey(
        GoodsCategory,
        related_name='category',
        verbose_name="商品类目",
        on_delete=models.CASCADE,
        limit_choices_to={
            'category_type': 1}
    )
    goods = models.ForeignKey(
        Goods,
        related_name='goods',
        on_delete=models.CASCADE)

    class Meta:
        verbose_name = '首页商品类别广告'
        verbose_name_plural = verbose_name

    def __str__(self):
        return self.goods.name


class GoodsImage(models.Model):
    """
    商品轮播图
    """
    goods = models.ForeignKey(
        Goods,
        verbose_name="商品",
        related_name="images",
        on_delete=models.CASCADE)
    image = models.ImageField(
        upload_to="",
        verbose_name="图片",
        null=True,
        blank=True)
    add_time = models.DateTimeField(default=datetime.now, verbose_name="添加时间")

    class Meta:
        verbose_name = '商品图片'
        verbose_name_plural = verbose_name

    def __str__(self):
        return self.goods.name


class Banner(models.Model):
    """
    轮播的商品
    """
    goods = models.ForeignKey(
        Goods,
        verbose_name="商品",
        on_delete=models.CASCADE)
    image = models.ImageField(upload_to='banner', verbose_name="轮播图片")
    index = models.IntegerField(default=0, verbose_name="轮播顺序")
    add_time = models.DateTimeField(default=datetime.now, verbose_name="添加时间")

    class Meta:
        verbose_name = '轮播商品'
        verbose_name_plural = verbose_name

    def __str__(self):
        return self.goods.name


class HotSearchWords(models.Model):
    """
    热搜词
    """
    keywords = models.CharField(default="", max_length=20, verbose_name="热搜词")
    index = models.IntegerField(default=0, verbose_name="排序")
    add_time = models.DateTimeField(default=datetime.now, verbose_name="添加时间")

    class Meta:
        verbose_name = '热搜词'
        verbose_name_plural = verbose_name

    def __str__(self):
        return self.keywords

class GoodsComment(models.Model):
    '''
    商品评论
    '''
    goods = models.ForeignKey(Goods,related_name='comment',default='',verbose_name='商品',on_delete=models.CASCADE)
    users = models.ForeignKey(UserProfile,related_name='comment_goods',default='',verbose_name='用户',on_delete=models.CASCADE)
    comment = models.TextField(max_length=500,verbose_name='评论内容')
    add_time = models.DateTimeField(default=datetime.now,verbose_name='添加时间')

    class Meta:
        verbose_name = '评论'
        verbose_name_plural = verbose_name 

    def __str__(self):
        return self.goods.name

class GoodsCommentIamge(models.Model):
    '''
    商品评论图片
    '''
    comment = models.ForeignKey(GoodsComment,related_name='images',default='',verbose_name='评论',on_delete=models.CASCADE)
    add_time = models.DateTimeField(default=datetime.now,verbose_name='添加时间')
    image = models.ImageField(upload_to='goods/comment',verbose_name='图片')

    class Meta:
        verbose_name = '评论图片'
        verbose_name_plural = verbose_name

    def __str__(self):
        return self.comment.comment
