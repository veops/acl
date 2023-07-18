# ================================= UI ================================
FROM node:16.0.0-alpine AS builder

LABEL description="acl-ui"

COPY acl-ui /data/apps/acl-ui

WORKDIR /data/apps/acl-ui

RUN sed -i "s#http://127.0.0.1:5000##g" .env && yarn install  && yarn build


FROM nginx:alpine AS acl-ui

RUN mkdir /etc/nginx/html && rm -f /etc/nginx/conf.d/default.conf

COPY --from=builder /data/apps/acl-ui/dist /etc/nginx/html/


# ================================= API ================================
FROM python:3.8-alpine AS acl-api

LABEL description="Python3.8,acl"

COPY acl-api /data/apps/acl

WORKDIR /data/apps/acl

RUN apk add --no-cache tzdata gcc musl-dev libffi-dev openldap-dev python3-dev jpeg-dev zlib-dev build-base

ENV TZ=Asia/Shanghai

RUN pip install  --no-cache-dir -r requirements.txt \
    && cp ./settings.example.py settings.py \
    && sed -i "s#{user}:{password}@127.0.0.1:3306/{db}#acl:123456@mysql:3306/acl#g" settings.py \
    && sed -i "s#redis://127.0.0.1#redis://redis#g" settings.py \
    && sed -i 's#CACHE_REDIS_HOST = "127.0.0.1"#CACHE_REDIS_HOST = "redis"#g' settings.py

CMD ["bash", "-c", "flask run"]
