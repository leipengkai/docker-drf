FROM python:3.6
ENV PYTHONUNBUFFERED 1
RUN mkdir /code
WORKDIR /code
ADD . /code/
# M2Crypto python package need swig .host:Ubuntu18.04
RUN apt-get update && apt-get -y upgrade && apt-get install -y cron swig
# 设置时区
RUN echo "Asia/Shanghai" > /etc/timezone && dpkg-reconfigure -f noninteractive tzdata
RUN pip install -r requirements.txt -i http://mirrors.aliyun.com/pypi/simple/ --trusted-host mirrors.aliyun.com

#RUN python manage.py collectstatic --noinput

