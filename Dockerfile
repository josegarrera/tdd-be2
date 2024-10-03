FROM node:20-alpine AS build
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm install
COPY . .

RUN npm run build

FROM node:20-alpine
WORKDIR /app
COPY --from=build /app/dist /app
COPY package.json package-lock.json ./
RUN npm install --production
EXPOSE 3002
CMD ["node", "index.js"]
