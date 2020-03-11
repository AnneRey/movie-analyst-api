FROM node:12

# Create app directory
WORKDIR /usr/src/app

RUN npm install
# If you are building your code for production

# Bundle app source
COPY . .

EXPOSE 3000
CMD [ "node", "server.js" ]
