FROM node:12
# Create app directory
WORKDIR /usr/src/app
# Bundle app source
COPY . .
RUN npm install
EXPOSE 3000
CMD [ "node", "server.js" ]
