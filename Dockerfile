FROM nginx

# Update and create self-signed certicate
RUN apt-get update && apt-get install -y libpcre3-dev \
openssl libssl-dev perl build-essential \
libmaxminddb0 libmaxminddb-dev mmdb-bin &&\
mkdir /etc/nginx/conf.d/ext &&\
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
-subj "/O=Everon Jesus Rivera test/CN=everon.test" \
-keyout /etc/nginx/conf.d/ext/nginx-selfsigned.key \
-out /etc/nginx/conf.d/ext/nginx-selfsigned.crt

# Copy settings
#USER www-data
COPY conf/server_block.conf /etc/nginx/conf.d/default.conf
#USER root
EXPOSE 443
