FROM  resin/rpi-raspbian
MAINTAINER Andrew Schamp <schamp@gmail.com>
RUN apt-get update &&\
    apt-get install -y git mercurial golang nginx &&\
    apt-get clean

RUN echo "daemon off;" >> /etc/nginx/nginx.conf

# Configure Nginx and apply fix for very long server names
RUN echo "daemon off;" >> /etc/nginx/nginx.conf \
 && sed -i 's/^http {/&\n    server_names_hash_bucket_size 128;/g' /etc/nginx/nginx.conf

ENV GOPATH /opt/go
ENV PATH $PATH:$GOPATH/bin
RUN go get -u github.com/jwilder/docker-gen && go get -u github.com/ddollar/forego

#ADD data/ /opt/app
#WORKDIR /opt/app

ENV DOCKER_HOST unix:///tmp/docker.sock

VOLUME ["/etc/nginx/certs"]

ENTRYPOINT ["/app/docker-entrypoint.sh"]
CMD ["forego", "start", "-r"]
