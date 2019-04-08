FROM node:11-alpine
LABEL maintainer="leafney <babycoolzx@126.com>"

RUN echo "http://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
    apk add -U --no-cache --allow-untrusted tzdata chromium ttf-freefont wqy-zenhei ca-certificates && \
    mkdir -p /app /logs && \
    yarn global add pm2 && \
    yarn cache clean && \
    rm -rf /var/cache/apk/*

COPY ./startup.sh ./utc2cst.sh /usr/local/bin/
RUN chmod +x usr/local/bin/startup.sh && \
    chmod +x usr/local/bin/utc2cst.sh

WORKDIR /app
VOLUME ["/app"]

EXPOSE 8000
CMD [ "startup.sh" ]