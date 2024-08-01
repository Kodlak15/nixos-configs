FROM node:20-alpine3.19
WORKDIR /cascade-botanicals
COPY . .
RUN npm install && npm run build
CMD ORIGIN=http://localhost:3000 node build
