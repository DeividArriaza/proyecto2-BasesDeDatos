FROM node:20-alpine

WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . .

EXPOSE 13000

CMD ["node", "--watch", "src/index.js"]
