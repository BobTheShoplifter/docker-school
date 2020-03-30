# build environment
FROM nginx:1.13.9-alpine as build-stage
ARG mode=production

RUN mkdir /usr/src/app
WORKDIR /usr/src/app
COPY . /usr/src/app

EXPOSE 80 443
CMD ["nginx", "-g", "daemon off;"]