FROM alpine:3.8
LABEL maintainer="lccf <leftcold@gmail.com>"

ENV TIMEZONE Asia/Shanghai

RUN sed -i -e 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/' /etc/apk/repositories && \
  apk update && \
  apk add tzdata && \
  cp /usr/share/zoneinfo/${TIMEZONE} /etc/localtime && \
  echo "${TIMEZONE}" > /etc/timezone && \
  apk del tzdata && \
  rm -rf /var/cache/apk/*