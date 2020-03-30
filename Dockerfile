# build environment
FROM nginx:1.13.9-alpine
ARG mode=production

RUN mkdir /usr/src/app
WORKDIR /usr/src/app
COPY . /usr/src/app

# Stage 1
# Production build based on Nginx with artefacts from Stage 0
COPY /usr/src/app/nginx.conf /etc/nginx/conf.d/default.conf
COPY /usr/src/app/dist /usr/share/nginx/html

# STAGE 2 Remove everything
RUN rm -rf /usr/src/app
RUN rm -rf /usr/share/nginx/html/js/*.map
EXPOSE 80 443
CMD ["nginx", "-g", "daemon off;"]