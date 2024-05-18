FROM alpine:latest
RUN apk update && apk add --no-cache nginx
COPY index.html /var/www/html/index.html
COPY nginx.conf /etc/nginx/nginx.conf
WORKDIR /var/www/html
EXPOSE 80
ENTRYPOINT ["nginx", "-g", "daemon off;"]

