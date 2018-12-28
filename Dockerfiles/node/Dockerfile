FROM node
RUN mkdir /vue
WORKDIR /vue
ADD . /vue/
#RUN apt update && apt install unzip && unzip online-store.zip
WORKDIR /vue/online-store
RUN cd /vue/online-store && \
    npm install -g n && n stable && \
    npm install npm@latest -g && \
    npm install -g cnpm --registry=https://registry.npm.taobao.org && \
    cnpm install


