#Build React App

FROM node:alpine as build
WORKDIR /app
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# Server with nginx

FROM nginx:alpine
WORKDIR /usr/share/nginx/html
RUN rm -rf *
COPY --from=build /app/build /usr/share/nginx/html/
EXPOSE 80
ENTRYPOINT ["nginx", "-g", "daemon off;"]
