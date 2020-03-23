FROM alpine:3.10.2

# install ca-certificates so that HTTPS works consistently
RUN apk add --no-cache ca-certificates

RUN apk add --no-cache --update \
      git \
      bash \
      nodejs \
      npm \
      aria2

# To handle not get uid/gid error while installing a npm package
RUN npm config set unsafe-perm true

RUN npm install -g typescript

RUN mkdir /bot
RUN chmod 777 /bot
WORKDIR /bot

RUN git clone https://github.com/Jackyj09/CloudTorrentDrive /bot

COPY ./src/.constants.js /bot/src/
COPY ./aria*.sh ./credentials.json ./start.sh /bot/

CMD ["bash","start.sh"]
