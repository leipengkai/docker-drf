from django.contrib import admin

# Register your models here.

from .models import UserFav, UserLeavingMessage, UserAddress,Membership,UserMembershipInfo

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

class MembershipAdmin(admin.ModelAdmin):
    '''
    会员等级
    '''
    list_display = ['tier_name', 'min_bonus_point', "min_owned", "min_shared", "color",'decorate_image',
                    'banner_image','discount_rate','is_exc_shipment_free','is_exc_new','is_special_available']


class UserMembershipInfoAdmin(admin.ModelAdmin):
    list_display = ['user','membership','bonus_point','owned_sum','shared_sum','check_in_sum']
    # list_editable = ["bonus"]
    list_per_page = 30


admin.site.register(UserFav, UserFavAdmin)
admin.site.register(UserAddress, UserAddressAdmin)
admin.site.register(UserLeavingMessage, UserLeavingMessageAdmin)
admin.site.register(Membership, MembershipAdmin)
admin.site.register(UserMembershipInfo, UserMembershipInfoAdmin)
