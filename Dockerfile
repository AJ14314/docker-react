#BUILD PHASE
FROM node:10-alpine3.11

WORKDIR '/app'

COPY package*.json ./

RUN npm install
#no need to use volume concept because code will not change in our prod container
COPY . .

RUN npm run build

#RUN PHASE
#terminating each successor block
FROM nginx
#AWS Elasticbeanstalk will be exposed 80 for incoming traffic
EXPOSE 80
#default path of nginx to serve static html content
COPY --from=0 /app/build /usr/share/nginx/html