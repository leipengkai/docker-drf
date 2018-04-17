from django.shortcuts import render
from datetime import datetime

# Create your views here.
from django.contrib.auth.backends import ModelBackend
from django.contrib.auth import get_user_model
from django.db.models import Q
from rest_framework.mixins import CreateModelMixin
from rest_framework import mixins
from rest_framework import viewsets
from rest_framework.response import Response
from rest_framework import status
from random import choice
from rest_framework import permissions
from rest_framework import authentication
from rest_framework_jwt.authentication import JSONWebTokenAuthentication

from rest_framework_jwt.serializers import jwt_encode_handler, jwt_payload_handler

from .serializers import SmsSerializer, UserRegSerializer, UserDetailSerializer
from MxShop.settings import APIKEY
from utils.yunpian import YunPian
from .models import VerifyCode

User = get_user_model()


class CustomBackend(ModelBackend):
    """
    自定义用户验证
    """

    def authenticate(self, username=None, password=None, **kwargs):
        try:
            user = User.objects.get(Q(username=username) | Q(mobile=username))
            if user.check_password(password):
                return user
        except Exception as e:
            return None


class SmsCodeViewset(CreateModelMixin, viewsets.GenericViewSet):
    """
    发送短信验证码
    """
    serializer_class = SmsSerializer

    def generate_code(self):
        """
        生成四位数字的验证码
        :return:
        """
        seeds = "1234567890"
        random_str = []
        for i in range(4):
            random_str.append(choice(seeds))

        return "".join(random_str)

    def create(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)

        mobile = serializer.validated_data["mobile"]

        yun_pian = YunPian(APIKEY)

        code = self.generate_code()

        sms_status = yun_pian.send_sms(code=code, mobile=mobile)

        if sms_status["code"] != 0:
            return Response({
                "mobile": sms_status["msg"]
            }, status=status.HTTP_400_BAD_REQUEST)
        else:
            code_record = VerifyCode(code=code, mobile=mobile)
            code_record.save()
            return Response({
                "mobile": mobile
            }, status=status.HTTP_201_CREATED)


class UserViewset(
        CreateModelMixin,
        mixins.ListModelMixin,
        mixins.UpdateModelMixin,
        mixins.RetrieveModelMixin,
        viewsets.GenericViewSet):
    """
    用户
    """
    queryset = User.objects.all()
    authentication_classes = (
        JSONWebTokenAuthentication,
        authentication.SessionAuthentication)

    # serializer_class = UserRegSerializer
    def get_serializer_class(self):
        if self.action == "retrieve":
            return UserDetailSerializer
        elif self.action == "create":
            return UserRegSerializer
        return UserDetailSerializer

    # permission_classes = (permissions.IsAuthenticated, )
    def get_permissions(self):
        if self.action == "retrieve":
            return [permissions.IsAuthenticated()]
        elif self.action == "list":
            return [permissions.IsAdminUser()]
        elif self.action == "create":
            return []
        return []

    def create(self, request, *args, **kwargs):
        serializer = self.get_serializer(data=request.data)
        serializer.is_valid(raise_exception=True)
        user = self.perform_create(serializer)

        re_dict = serializer.data
        payload = jwt_payload_handler(user)
        re_dict["token"] = jwt_encode_handler(payload)
        re_dict["name"] = user.name if user.name else user.username

        headers = self.get_success_headers(serializer.data)
        return Response(
            re_dict,
            status=status.HTTP_201_CREATED,
            headers=headers)

    def get_object(self):
        return self.request.user

    def perform_create(self, serializer):
        return serializer.save()

    def retrieve(self, request, *args, **kwargs):
        instance = self.get_object()
        # 当用户没有第一次签到时,是没有会员资料的
        if hasattr(instance,'membershipInfo'):
            userMembershipInfo = instance.membershipInfo
            last_time = userMembershipInfo.last_check_in_time  
            now = datetime.now()
            tom = datetime(last_time.year,last_time.month,last_time.day+1)
            if now.day - last_time.day >=1 or now > tom:
                userMembershipInfo.check_in_status = False
                # 表示未签到
            else:
                userMembershipInfo.check_in_status = True

        serializer = self.get_serializer(instance)
        return Response(serializer.data)

    def list(self, request, *args, **kwargs):
        queryset = self.filter_queryset(self.get_queryset())

        for instance in queryset:
            if hasattr(instance,'membershipInfo'):
                userMembershipInfo = instance.membershipInfo
                last_time = userMembershipInfo.last_check_in_time  
                now = datetime.now()
                tom = datetime(last_time.year,last_time.month,last_time.day+1)
                if now.day - last_time.day >=1 or now > tom:
                    userMembershipInfo.check_in_status = False
                else:
                    userMembershipInfo.check_in_status = True


        page = self.paginate_queryset(queryset)
        if page is not None:
            serializer = self.get_serializer(page, many=True)
            return self.get_paginated_response(serializer.data)

        serializer = self.get_serializer(queryset, many=True)
        return Response(serializer.data)
