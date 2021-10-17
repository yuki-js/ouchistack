FROM node:alpine3.12

ADD . /workdir
WORKDIR /workdir
RUN npm i
ENTRYPOINT ["node", "./index.js"]
CMD ["8080"]