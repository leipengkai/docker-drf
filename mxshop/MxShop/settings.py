"""
Django settings for mxshop project.

Generated by 'django-admin startproject' using Django 1.11.3.

For more information on this file, see
https://docs.djangoproject.com/en/1.11/topics/settings/

For the full list of settings and their values, see
https://docs.djangoproject.com/en/1.11/ref/settings/
"""

# import django
# django.setup()

import os
import sys
# from filebrowser.sites import site
# Build paths inside the project like this: os.path.join(BASE_DIR, ...)
BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
# 将应用包加入系统变量，便于模块导入
sys.path.insert(0, BASE_DIR)
sys.path.insert(0, os.path.join(BASE_DIR, 'apps'))
sys.path.insert(0, os.path.join(BASE_DIR, 'extra_apps'))

# Quick-start development settings - unsuitable for production
# See https://docs.djangoproject.com/en/1.11/howto/deployment/checklist/

# SECURITY WARNING: keep the secret key used in production secret!
SECRET_KEY = 'z(v$@^23_!%jd$(#z2a-uv)#^iz)u+-bzgtzbx#uxmx+zhn7zs'

# SECURITY WARNING: don't run with debug turned on in production!
DEBUG = True

ALLOWED_HOSTS = ['*']

# 由于我们在users/models.py继承了django的AbstractUser，所以需要在settings.py中指定我们自定义的user模型,否则创建模型会报E304错
AUTH_USER_MODEL = 'users.UserProfile'

# Application definition,会生成对应的迁移文件
INSTALLED_APPS = [
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    # 'users.apps.UsersConfig',
    'users',
    # 相当于加了'users' app .users/__init__.py加上 default_app_config= 'users.apps.UsersConfig' 并且后台还显示中文
    'DjangoUeditor',
    'goods.apps.GoodsConfig',
    'trade.apps.TradeConfig',
    'user_operation.apps.UserOperationConfig',
    'crispy_forms',
    'django_filters',
    # 'xadmin',
    'rest_framework',
    'corsheaders',  # 解决跨域
    'rest_framework.authtoken',
    # 'social_django',
    'jet.dashboard',
    'jet',
    # 'grappelli.dashboard',
    # 'grappelli',
    # 'filebrowser',
    'django.contrib.admin',
    # 性能分析工具
    'debug_toolbar',
    'django_extensions',
]
# JET_DEFAULT_THEME = 'light-blue'
JET_THEMES = [
    {
        'theme': 'default',  # theme folder name
        'color': '#47bac1',  # color of the theme's button in user menu
        'title': 'Default'  # theme title
    },
    {
        'theme': 'green',
        'color': '#44b78b',
        'title': 'Green'
    },
    {
        'theme': 'light-green',
        'color': '#2faa60',
        'title': 'Light Green'
    },
    {
        'theme': 'light-violet',
        'color': '#a464c4',
        'title': 'Light Violet'
    },
    {
        'theme': 'light-blue',
        'color': '#5EADDE',
        'title': 'Light Blue'
    },
    {
        'theme': 'light-gray',
        'color': '#222',
        'title': 'Light Gray'
    }
]

JET_SIDE_MENU_COMPACT = True

GRAPPELLI_INDEX_DASHBOARD = 'dashboard.CustomIndexDashboard'
GRAPPELLI_ADMIN_TITLE = '女王幻幻后台管理系统'


# HttpRequest会先通过中间件的处理之后,再进入URLConf进行处理
# http:projectsedu.com/2016/10/17/django%E4%BB%8E%E8%AF%B7%E6%B1%82%E5%88%B0%E8%BF%94%E5%9B%9E%E9%83%BD%E7%BB%8F%E5%8E%86%E4%BA%86%E4%BB%80%E4%B9%88/
MIDDLEWARE = [
    'corsheaders.middleware.CorsMiddleware',
    'django.middleware.security.SecurityMiddleware',
    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.middleware.common.CommonMiddleware',
    'django.middleware.csrf.CsrfViewMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.contrib.messages.middleware.MessageMiddleware',
    'django.middleware.clickjacking.XFrameOptionsMiddleware',
    'debug_toolbar.middleware.DebugToolbarMiddleware',  # DB性能分析工具
    # 'pyinstrument.middleware.ProfilerMiddleware',
    'django.middleware.locale.LocaleMiddleware', # 国际化
]

CORS_ORIGIN_ALLOW_ALL = True
ROOT_URLCONF = 'mxshop.urls'
# post http://127.0.0.1:8000/api-token-auth/


# DB性能分析工具配置
DEBUG_TOOLBAR_PANELS = [
    'debug_toolbar.panels.versions.VersionsPanel',
    'debug_toolbar.panels.timer.TimerPanel',
    'debug_toolbar.panels.settings.SettingsPanel',
    'debug_toolbar.panels.headers.HeadersPanel',
    'debug_toolbar.panels.request.RequestPanel',
    'debug_toolbar.panels.sql.SQLPanel',
    'debug_toolbar.panels.staticfiles.StaticFilesPanel',
    'debug_toolbar.panels.templates.TemplatesPanel',
    'debug_toolbar.panels.cache.CachePanel',
    'debug_toolbar.panels.signals.SignalsPanel',
    'debug_toolbar.panels.logging.LoggingPanel',
    'debug_toolbar.panels.redirects.RedirectsPanel',
]
CONFIG_DEFAULTS = {
    'RESULTS_CACHE_SIZE': 3,
    'SHOW_COLLAPSED': True,
    'SQL_WARNING_THRESHOLD': 100,   # milliseconds
}
INTERNAL_IPS = [
    '127.0.0.1',
    '192.168.5.20'
]


# PYINSTRUMENT_PROFILE_DIR = 'profiles'

APPEND_SLASH = False

TEMPLATES = [
    {
        'BACKEND': 'django.template.backends.django.DjangoTemplates',
        'DIRS': [os.path.join(BASE_DIR, 'templates')],
        'APP_DIRS': True,
        'OPTIONS': {
            'context_processors': [
                'django.template.context_processors.debug',
                'django.template.context_processors.request',
                'django.contrib.auth.context_processors.auth',
                'django.contrib.messages.context_processors.messages',
                'social_django.context_processors.backends',
                'social_django.context_processors.login_redirect',
            ],
        },
    },
]

WSGI_APPLICATION = 'mxshop.wsgi.application'


# Database
# https://docs.djangoproject.com/en/1.11/ref/settings/#databases

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',
        'NAME': "mxshop1",
        'USER': 'root',
        'PASSWORD': "123456",
        'HOST': "0.0.0.0",
        'PORT': "3308",
        # 'HOST': "mysql",  # docker-compose.yml mysql的服务名
        # 'PORT': "3306",
        'default-character-set': 'utf8',
        'OPTION': {'init_command': 'SET storage_engine=INNODB;'},
        'OPTIONS': {'charset': 'utf8mb4'},
        'TEST': { # 单元测试的临时数据库
            'ENGINE': 'django.db.backends.sqlite3',
            'NAME': 'test2',
            'CHARSET': 'utf8', # 一定要设置为utf8
            # 'OPTION': {'init_command': 'SET storage_engine=INNODB;',
            #            'charset': 'utf8'},
}
    }
}

if 'test' in sys.argv:
        DATABASES['default'] = {'ENGINE': 'django.db.backends.sqlite3',}


# Password validation
# https://docs.djangoproject.com/en/1.11/ref/settings/#auth-password-validators

AUTH_PASSWORD_VALIDATORS = [
    {
        'NAME': 'django.contrib.auth.password_validation.UserAttributeSimilarityValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.MinimumLengthValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.CommonPasswordValidator',
    },
    {
        'NAME': 'django.contrib.auth.password_validation.NumericPasswordValidator',
    },
]


# Internationalization
# https://docs.djangoproject.com/en/1.11/topics/i18n/

# 设置时区
LANGUAGE_CODE = 'zh-hans'  # 中文支持，django1.8以后支持；1.8以前是zh-cn
TIME_ZONE = 'Asia/Shanghai'
USE_I18N = True # 需要开启支持国际化
USE_L10N = True
USE_TZ = False  # 默认是Ture，时间是utc时间，由于我们要用本地时间，所用手动修改为false！！！！
LANGUAGES = (
    ('en', ('English')),
    ('zh-hans', ('中文简体')),
    ('zh-hant', ('中文繁體')),
)
#翻译文件所在目录，需要手工创建
LOCALE_PATHS = (
    os.path.join(BASE_DIR, 'locale'),
)
# JWT默认是usernaem,password登陆
AUTHENTICATION_BACKENDS = (

    # 'social_core.backends.open_id.OpenIdAuth',
    # 'social_core.backends.google.GoogleOpenId',
    # 'social_core.backends.google.GoogleOAuth2',
    # 'social_core.backends.google.GoogleOAuth',
    # 'social_core.backends.twitter.TwitterOAuth',
    # 'social_core.backends.yahoo.YahooOpenId',

    'users.views.CustomBackend',# 当调用authenticate()时,会进行定制身份验证. jwt登录时:auth/login/时会认证
    'social_core.backends.weibo.WeiboOAuth2',
    'social_core.backends.qq.QQOAuth2',
    'social_core.backends.weixin.WeixinOAuth2',
    'django.contrib.auth.backends.ModelBackend',
)


# Static files (CSS, JavaScript, Images)
# https://docs.djangoproject.com/en/1.11/howto/static-files/

STATIC_URL = '/static/'
# 测试环境下使用
# STATICFILES_DIRS = (
#     os.path.join(BASE_DIR, "static"),
# )

STATIC_ROOT = os.path.join(BASE_DIR, "static/")  # 使用nginx静态资源 配置,docker部署时使用
# python3 manage.py collectstatic 会在此项目下生成一个static目录,并将静态文件收集在此目录下

# STATIC_ROOT='/var/www/static/'  #
# nginx.conf
# location /static {
# alias /code/static/;
# }


MEDIA_URL = "/media/"
MEDIA_ROOT = os.path.join(BASE_DIR, "media")


REST_FRAMEWORK = {
    'DEFAULT_AUTHENTICATION_CLASSES': (
        'rest_framework.authentication.BasicAuthentication',
        'rest_framework.authentication.SessionAuthentication',
        # 'rest_framework.authentication.TokenAuthentication', # 这两个认证不要设置成全局
        # 'rest_framework_simplejwt.authentication.JWTAuthentication',
    ),
    # 'DEFAULT_THROTTLE_CLASSES': (
    # 'rest_framework.throttling.AnonRateThrottle',
    # 'rest_framework.throttling.UserRateThrottle'
    # ),
    # 'DEFAULT_THROTTLE_RATES': {
    # 'anon': '20/minute',
    # 'user': '30/minute'
    # },
    'DEFAULT_FILTER_BACKENDS': ('django_filters.rest_framework.DjangoFilterBackend',),
}

import datetime
JWT_AUTH = {
    'JWT_EXPIRATION_DELTA': datetime.timedelta(days=7),
    'JWT_AUTH_HEADER_PREFIX': 'JWT',
}


# 手机号码正则表达式
REGEX_MOBILE = "^1[358]\d{9}$|^147\d{8}$|^176\d{8}$"


# 云片网设置
APIKEY = ""


# 支付宝相关配置
private_key_path = os.path.join(BASE_DIR, 'apps/trade/keys/private_2048.txt')
ali_pub_key_path = os.path.join(
    BASE_DIR, 'apps/trade/keys/alipay_key_2048.txt')


# 缓存失效时间5s
# REST_FRAMEWORK_EXTENSIONS = {
# 'DEFAULT_CACHE_RESPONSE_TIMEOUT': 5
# }


CACHES = {
    "default": {
        "BACKEND": "django_redis.cache.RedisCache",
        # "LOCATION": "redis://127.0.0.1:6379",
        "LOCATION": "redis://redis:6379", # docker-compose.yml 服务名
        # "LOCATION": "redis://:password@127.0.0.1:6379/1",
        "OPTIONS": {
            "CLIENT_CLASS": "django_redis.client.DefaultClient",
        }
    }
}

SOCIAL_AUTH_WEIBO_KEY = '762446969'
SOCIAL_AUTH_WEIBO_SECRET = '3d1f9fe14d390e3067dd5df2009cbd57'

SOCIAL_AUTH_QQ_KEY = 'foobar'
SOCIAL_AUTH_QQ_SECRET = 'bazqux'
#  http://127.0.0.1/complete/weibo/
# 先退出微博
# 再访问 127.0.0.1/login/weibo/

# 第三方登陆成功之后 跳转到此页面
# SOCIAL_AUTH_LOGIN_REDIRECT_URL = '/index/'


# 签到一次所给积分
CHECK_BONUS_POINT = 2
# 分享一次所给给分
SHARE_BONUS_POINT = 1

# LOGGING = {
    # 'version': 1,
    # 'disable_existing_loggers': False,
    # 'formatters': {
        # 'verbose': {
            # 'format': '%(levelname)s %(asctime)s %(module)s %(process)d %(thread)d %(message)s'
        # },
        # 'simple': {
            # 'format': '%(levelname)s %(message)s'
        # },
    # },
    # 'handlers': {
        # 'console': {
            # 'level': 'INFO',
            # 'class': 'logging.StreamHandler',
            # 'formatter': 'simple'
        # },
        # 'logstash': {
            # 'level': 'WARNING',
            # 'class': 'logstash.TCPLogstashHandler',
            # 'host': 'localhost',
            # 'port': 5000,  # Default value: 5000
            # 'version': 1,
            # 'message_type': 'django_logstash',  # 'type' field in logstash message. Default value: 'logstash'.
            # 'fqdn': False,  # Fully qualified domain name. Default value: false.
            # 'tags': ['django.request'],  # list of tags. Default: None.
        # },
    # },
    # 'loggers': {
        # 'django': {
            # 'handlers': ['console'],
            # 'level': 'INFO',
            # 'propagate': True,
        # },
        # 'django.request': {
            # 'handlers': ['logstash'],
            # 'level': 'WARNING',
            # 'propagate': True,
        # },
    # }
# }

# Celery 设置
# import djcelery
# djcelery.setup_loader()  # 去每一个应用目录下找 tasks.py 文件，到文件中去执行 celery 任务函数
CELERY_IMPORTS = ('goods.tasks',)
# BROKER_URL = 'pyamqp://rabbitmq:rabbitmq@rabbitmq:5672//'  # connect RabbitMQ 连接失败一直阻塞
# CELERY_RESULT_BACKEND = 'redis://redis:6379/0'  # docker-compose up
CELERY_RESULT_BACKEND = 'redis://192.168.50.130:6379/0'  # web服务由pycharm启动
