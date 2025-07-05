# -------- Stage 1: Base build, only deps --------
FROM node:20-alpine AS base

WORKDIR /app

COPY package*.json ./
COPY yarn.lock ./

RUN yarn

COPY . .
RUN yarn build


# -------- Stage 3: Production (use dist folder from above build) --------
FROM nginx:stable-alpine3.21-perl AS production

RUN rm /etc/nginx/conf.d/default.conf
COPY nginx.conf /etc/nginx/conf.d/default.conf

COPY --from=base /app/dist /usr/share/nginx/html
EXPOSE 80
ENTRYPOINT ["nginx", "-g", "daemon off;"]

