FROM  sdhibit/rpi-raspbian
MAINTAINER BEstLibre <github@bestlibre.org>
RUN echo "deb http://archive.raspbian.org/raspbian jessie main" >> /etc/apt/sources.list &&\
    apt-get update &&\
    apt-get install -y nginx &&\
    apt-get clean

RUN echo "daemon off;" >> /etc/nginx/nginx.conf

#fix for long server names
RUN sed -i 's/# server_names_hash_bucket/server_names_hash_bucket/g' /etc/nginx/nginx.conf

ADD data/ /opt/app
WORKDIR /opt/app

EXPOSE 80
ENV DOCKER_HOST unix:///tmp/docker.sock

CMD ["forego", "start", "-r"]
