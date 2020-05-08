FROM node:10
WORKDIR /usr/src/app
COPY app/* /usr/src/app/
RUN npm install
HEALTHCHECK --interval=5s --timeout=10s --retries=3 CMD curl -sS http://localhost:3001/healthcheck || exit 1
CMD ["node","index.js"]
EXPOSE 3001
