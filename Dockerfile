# Author: Shilrata Chawhan
# pull official base image
FROM node:14 as build

#working directory of containerized app

WORKDIR /app

#copy the react app to the container

COPY . /app/

#prepare the container for building angular

RUN npm install

# RUN npm install

RUN npm run build

# Remove the default nginx configuration
RUN rm -rf /usr/share/nginx/html/*
#prepare nginx

FROM nginx:1.16.0-alpine
COPY --from=build /app/dist /usr/share/nginx/html

RUN rm /etc/nginx/conf.d/default.conf

COPY nginx/nginx.conf /etc/nginx/conf.d

#fire for nginx

EXPOSE 80

CMD [ "nginx","-g","daemon off;" ]

