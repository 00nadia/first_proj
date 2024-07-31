
FROM node:20-alpine AS base
WORKDIR /app
COPY package.json /app/package.json
COPY package-lock.json /app/package-lock.json
RUN npm install 

FROM base AS build
COPY . .
RUN npm run build 


FROM node:20-alpine 
WORKDIR /app
EXPOSE 3000
COPY package.json /app/package.json
COPY package-lock.json /app/package-lock.json
RUN npm ci --include=dev

CMD ["npm","run", "dev"]
