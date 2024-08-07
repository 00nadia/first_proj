
FROM node:20-alpine AS dev
WORKDIR /app

COPY package.json /app/package.json
COPY package-lock.json /app/package-lock.json
RUN npm install 

CMD ["npm", "run", "dev"]


FROM node:20-alpine AS build
WORKDIR /app

COPY package.json /app/package.json
COPY package-lock.json /app/package-lock.json
RUN npm ci
COPY . .
RUN npm run build 


FROM node:20-alpine AS production
WORKDIR /app

COPY --from=build /app/build /app/build
COPY package.json /app/package.json
CMD ["node","build/index.js"]
