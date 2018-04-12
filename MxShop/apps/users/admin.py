from django.contrib import admin

# Register your models here.

from .models import VerifyCode, Member, UserProfile


class BaseSetting(admin.ModelAdmin):
    enable_themes = True
    use_bootswatch = True


class GlobalSettings(admin.ModelAdmin):
    site_title = "慕学生鲜后台"
    site_footer = "mxshop"
    # menu_style = "accordion"


class VerifyCodeAdmin(admin.ModelAdmin):
    list_display = ['code', 'mobile', "add_time"]

class MemberAdmin(admin.ModelAdmin):
    '''
    会员等级
    '''
    list_display = ['level', 'integral', "owned_sum", "sign_sum", "share_sum"]

class UserProfileAdmin(admin.ModelAdmin):
    list_display = ['name','birthday','gender', 'mobile','email','level', 'integral', "owned_sum", "sign_sum", "share_sum"]

    list_filter = ["level", "integral", "name"]
    search_fields = ['name', ]
    list_per_page = 30
    list_editable = ["integral"]


admin.site.register(VerifyCode, VerifyCodeAdmin)
admin.site.register(Member, MemberAdmin)
admin.site.register(UserProfile, UserProfileAdmin)
# admin.site.register(views.BaseAdminView, BaseSetting)
# admin.site.register(views.CommAdminView, GlobalSettings)
