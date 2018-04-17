from django.contrib import admin

# Register your models here.

from .models import VerifyCode, UserProfile
from user_operation.models import UserMembershipInfo

class BaseSetting(admin.ModelAdmin):
    enable_themes = True
    use_bootswatch = True


class GlobalSettings(admin.ModelAdmin):
    site_title = "慕学生鲜后台"
    site_footer = "mxshop"
    # menu_style = "accordion"


class VerifyCodeAdmin(admin.ModelAdmin):
    list_display = ['code', 'mobile', "add_time"]


class UserProfileAdmin(admin.ModelAdmin):
    list_display = ['name','birthday','gender', 'mobile','email','membershipInfo','is_superuser','date_joined','username']

    list_filter = ["name"]
    search_fields = ['name', ]
    list_per_page = 30

    # class UserMembershipInfoInline(admin.StackedInline):
        # model =  UserMembershipInfo
        # exclude = ["bonus",'owned_sum','shared_sum','check_in_sum']
        # extra = 3
        # style = 'tab'

    # inlines = [UserMembershipInfoInline]

admin.site.register(VerifyCode, VerifyCodeAdmin)
admin.site.register(UserProfile, UserProfileAdmin)
# admin.site.register(views.BaseAdminView, BaseSetting)
# admin.site.register(views.CommAdminView, GlobalSettings)
