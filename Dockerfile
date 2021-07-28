FROM node:12

WORKDIR /usr/src/app
RUN chmod -R 777 /usr/src/app

COPY packages/api/package*.json ./
COPY packages/api/. ./

RUN npm install
RUN npm run build

FROM node:12

ARG NODE_ENV=production
ENV NODE_ENV=${NODE_ENV}

WORKDIR /usr/src/app

COPY packages/api/package*.json ./
COPY packages/api/. ./
COPY --from=0 /usr/src/app/dist ./dist

EXPOSE 8080

CMD ["node", "dist/main"]
