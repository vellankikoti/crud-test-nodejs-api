FROM nginx:1.15.7-alpine

WORKDIR /usr/src/app

COPY package*.json ./

RUN apk add --no-cache --repository http://nl.alpinelinux.org/alpine/edge/main libuv \
    && apk add --no-cache --update-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/main nodejs=10.16.3-r0 nodejs-npm=10.16.3-r0 \
    && apk add --no-cache --update-cache --repository http://dl-cdn.alpinelinux.org/alpine/edge/community yarn=1.19.1-r0 \
    && echo "NodeJS Version:" "$(node -v)" \
    && echo "NPM Version:" "$(npm -v)" \
    && echo "Yarn Version:" "$(yarn -v)"

RUN apk --no-cache add --virtual native-deps \
  g++ gcc libgcc libstdc++ linux-headers autoconf automake make nasm python git && \
  yarn install --quiet node-gyp -g && \
  yarn install

COPY . .

CMD ["yarn", "start"]
