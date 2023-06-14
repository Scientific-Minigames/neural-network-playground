FROM node:stable-alpine
WORKDIR /app
COPY ./package.json ./package-lock.json ./
RUN npm i
ENV PATH="./node_modules/.bin:$PATH"
COPY . .
RUN npm run build

FROM nginx:stable-alpine
COPY --from=dist /app/dust /usr/share/nginx/html
COPY nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]