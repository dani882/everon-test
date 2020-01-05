FROM nginx

# Copy settings
#USER www-data
COPY server_block.conf /etc/nginx/conf.d/default.conf
COPY nginx-selfsigned.crt /etc/nginx/conf.d/ext/nginx-selfsigned.crt
COPY nginx-selfsigned.key /etc/nginx/conf.d/ext/nginx-selfsigned.key
#USER root
EXPOSE 443
