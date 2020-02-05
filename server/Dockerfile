FROM node

COPY ./package.json .
COPY ./package-lock.json .
RUN npm i

COPY ./src ./src

CMD node ./src/main.js

