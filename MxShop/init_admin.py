import django
import os
os.environ.setdefault("DJANGO_SETTINGS_MODULE", "MxShop.settings")
django.setup()
# from django.contrib.auth.models import User
from django.contrib.auth import get_user_model
User = get_user_model()
try:
    admin = User.objects.get(username='admin')
except:
    User.objects.create_superuser('admin', 'admin@example.com', 'asdf1234')
