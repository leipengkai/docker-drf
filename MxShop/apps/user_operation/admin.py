from django.contrib import admin

# Register your models here.

from .models import UserFav, UserLeavingMessage, UserAddress


class UserFavAdmin(admin.ModelAdmin):
    list_display = ['user', 'goods', "add_time"]


class UserLeavingMessageAdmin(admin.ModelAdmin):
    list_display = ['user', 'message_type', "message", "add_time"]

    # 在管理后台 查看所有人的留言,其实好像不用做判断,因为后台只能是管理者才能进入的
    def get_queryset(self, request):
        qs = super(UserLeavingMessageAdmin, self).get_queryset(request)
        if request.user.is_superuser:
            return qs
        else:
            return qs.filter(user=request.user)


class UserAddressAdmin(admin.ModelAdmin):
    list_display = ["signer_name", "signer_mobile", "district", "address"]


admin.site.register(UserFav, UserFavAdmin)
admin.site.register(UserAddress, UserAddressAdmin)
admin.site.register(UserLeavingMessage, UserLeavingMessageAdmin)
