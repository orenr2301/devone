FROM node:14

WORKDIR /app

COPY package.json ./

RUN npm install

COPY app.js .
COPY package.json .
COPY package-lock.json .

EXPOSE 80

CMD ["node", "app.js"]