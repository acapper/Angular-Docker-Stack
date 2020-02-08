#############
### build ###
#############

# base image
FROM node:12.2.0 as development

# set working directory
WORKDIR /app

# add `/app/node_modules/.bin` to $PATH
ENV PATH /app/node_modules/.bin:$PATH

# install and cache app dependencies
COPY package.json /app/package.json
RUN npm install
RUN npm install -g @angular/cli

# add app
COPY . /app

# expose port 80
EXPOSE 80

# generate build
RUN ng build --output-path=dist


##################
### production ###
##################

# base image
FROM nginx:alpine as production

# copy artifact development from the 'development environment'
COPY --from=development /app/dist /usr/share/nginx/html

# expose port 80
EXPOSE 80

# run nginx
CMD ["nginx", "-g", "daemon off;"]
