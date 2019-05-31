FROM python:3.6
ENV PYTHONUNBUFFERED 1
RUN mkdir /code
COPY ./requirements.txt /code/requirements.txt
RUN pip install --upgrade pip
RUN pip install -r /code/requirements.txt -i http://mirrors.aliyun.com/pypi/simple/ --trusted-host mirrors.aliyun.com
COPY . /code/
#COPY --from=build-env /usr/local/lib/python3.6/site-packages /usr/local/lib/python3.6/site-packages
WORKDIR /code
# M2Crypto python package need swig .host:Ubuntu18.04
RUN apt-get update && apt-get -y upgrade && apt-get install -y cron swig vim
# 设置时区
RUN echo "Asia/Shanghai" > /etc/timezone && dpkg-reconfigure -f noninteractive tzdata
ENV PYTHONPATH=/usr/local/lib/python3.6/site-packages
#RUN python manage.py collectstatic --noinput

