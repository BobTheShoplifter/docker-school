# build environment
FROM nginx:1.13.9-alpine as build-stage
ARG mode=production

RUN mkdir /usr/src/app
WORKDIR /usr/src/app
COPY . /usr/src/app
# Stage 1
# Production build based on Nginx with artefacts from Stage 0


# STAGE 2 Remove everything
RUN rm -rf /usr/src/app
EXPOSE 80 443
CMD ["nginx", "-g", "daemon off;"]