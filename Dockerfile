# build environment
FROM nginx:1.13.9-alpine as build-stage
ARG mode=production

RUN mkdir /usr/src/app
WORKDIR /usr/src/app
COPY . /usr/src/app
COPY ./site /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf

RUN rm -rf /usr/src/app
EXPOSE 80 443
CMD ["nginx", "-g", "daemon off;"]