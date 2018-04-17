import re

from rest_framework import serializers
from rest_framework.validators import UniqueTogetherValidator

from .models import UserFav
from .models import UserLeavingMessage, UserAddress,UserMembershipInfo,Membership
from goods.serializers import GoodsSerializer


class UserFavDetailSerializer(serializers.ModelSerializer):
    goods = GoodsSerializer()

    class Meta:
        model = UserFav
        fields = ("goods", "id")


class UserFavSerializer(serializers.ModelSerializer):
    user = serializers.HiddenField(
        default=serializers.CurrentUserDefault()
    )

    class Meta:
        model = UserFav
        validators = [
            UniqueTogetherValidator(
                queryset=UserFav.objects.all(),
                fields=('user', 'goods'),
                message="已经收藏"
            )
        ]

        fields = ("user", "goods", "id")


class LeavingMessageSerializer(serializers.ModelSerializer):
    user = serializers.HiddenField(
        default=serializers.CurrentUserDefault()
    )
    add_time = serializers.DateTimeField(
        read_only=True, format='%Y-%m-%d %H:%M')

    class Meta:
        model = UserLeavingMessage
        fields = (
            "user",
            "message_type",
            "subject",
            "message",
            "file",
            "id",
            "add_time")


class AddressSerializer(serializers.ModelSerializer):
    user = serializers.HiddenField(
        default=serializers.CurrentUserDefault()
    )
    add_time = serializers.DateTimeField(
        read_only=True, format='%Y-%m-%d %H:%M')

    def validate_signer_mobile(self, mobile):
        """
        验证手机号码
        :param data:
        :return:
        """
        # 验证手机号码是否合法
        if not re.match('^1[358]\d{9}$|^147\d{8}$|^176\d{8}$', mobile):
            raise serializers.ValidationError('请填写正确的手机号码')
        return mobile
    class Meta:
        model = UserAddress
        fields = (
            "id",
            "user",
            "province",
            "city",
            "district",
            "address",
            "signer_name",
            "add_time",
            "signer_mobile",
            "default_address",
        )

    def create(self, validated_data):
        user = self.context["request"].user
        # default_address = validated_data["default_address"]
        existed = UserAddress.objects.filter(user=user)
        if not existed:
            validated_data['default_address'] = '1'
        return  UserAddress.objects.create(**validated_data)

    def update(self, instance, validated_data):
        user = self.context["request"].user
        instance.default_address = validated_data["default_address"]
        existed = UserAddress.objects.filter(user=user).filter(default_address='1')
        if existed:
            for i in existed:
                i.default_address = '0'
                i.save()
        instance.save()
        return instance

class CheckInSerializer(serializers.Serializer):

    user = serializers.HiddenField(
        default=serializers.CurrentUserDefault()
    )
    # bonus = serializers.IntegerField(read_only=True)
    # owned_sum = serializers.IntegerField(read_only=True)
    # shared_sum = serializers.IntegerField(read_only=True)
    check_in_sum = serializers.IntegerField(read_only=True)
    # membership = serializers.PrimaryKeyRelatedField(read_only=True,default=Membership.objects.filter(id=1)[0])

    def create(self, validated_data):
        # 已经序列化的好的数据: validated_data
        user = self.context["request"].user

        existed = UserMembershipInfo.objects.filter(user=user)

        if existed:
            existed = existed[0]
            existed.check_in_sum += 2
            # existed.check_in_status = True
            existed.save()
        else:
            validated_data['check_in_sum'] = 2
            validated_data['membership'] = Membership.objects.filter(id=1)[0]
            # validated_data['check_in_status'] = True
            existed = UserMembershipInfo.objects.create(**validated_data)

        return existed

    # class Meta:
        # model = UserMembershipInfo
        # fields = '__all__'


