FROM node:18-alpine
WORKDIR /usr/src/app
RUN npm install -g npm@8.13.2
COPY package*.json .
RUN npm install
COPY . .
EXPOSE 3000
CMD ["npm", "start"]