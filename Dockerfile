FROM node:10
WORKDIR /usr/src/app
COPY app/* /usr/src/app/
RUN npm install
CMD ["node","index.js"]
EXPOSE 3001
