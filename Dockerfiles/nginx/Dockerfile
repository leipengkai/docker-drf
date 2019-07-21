FROM nginx:latest

COPY nginx.conf /etc/nginx/nginx.conf
COPY default.conf /etc/nginx/conf.d/default.conf
COPY femn.pem /etc/nginx/femn.pem
COPY femn_private.key /etc/nginx/femn_private.key
COPY uwsgi.conf /etc/nginx/sites-available/

RUN mkdir -p /etc/nginx/sites-enabled/\
	&& ln -s /etc/nginx/sites-available/uwsgi.conf /etc/nginx/sites-enabled/

RUN ln -sf /dev/stdout /var/log/nginx/access.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log

COPY index.html /usr/share/nginx/html

# RUN mkdir -p /etc/nginx/sites-enabled/\
#     && ln -s /etc/nginx/sites-available/my_nginx.conf /etc/nginx/sites-enabled/\
#     && rm /etc/nginx/conf.d/default.conf

EXPOSE 80 443
CMD ["nginx", "-g", "daemon off;"]

# https:github.com/twtrubiks/docker-django-nginx-uwsgi-postgres-tutorial/blob/master/docker-compose.yml
