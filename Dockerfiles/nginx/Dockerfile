FROM nginx:latest

COPY nginx.conf /etc/nginx/nginx.conf
COPY default.conf /etc/nginx/conf.d/default.conf
COPY uwsgi.conf /etc/nginx/sites-available/

RUN mkdir -p /etc/nginx/sites-enabled/\
	&& ln -s /etc/nginx/sites-available/uwsgi.conf /etc/nginx/sites-enabled/
COPY index.html /usr/share/nginx/html

# RUN mkdir -p /etc/nginx/sites-enabled/\
#     && ln -s /etc/nginx/sites-available/my_nginx.conf /etc/nginx/sites-enabled/\
#     && rm /etc/nginx/conf.d/default.conf

CMD ["nginx", "-g", "daemon off;"]

# https:github.com/twtrubiks/docker-django-nginx-uwsgi-postgres-tutorial/blob/master/docker-compose.yml
