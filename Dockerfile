# Use the official Node.js image as the base image
FROM node:21.7.0 as build

# Set the working directory in the container
WORKDIR /app

ENV HOST 0.0.0.0

# Copy package.json and package-lock.json to the container
COPY package*.json ./

# Install project dependencies
RUN npm install

# Install Angular CLI globally
RUN npm install -g @angular/cli

# Copy the entire project to the container
COPY . .

# Build the Angular app for production
RUN ng build --prod

# Use a smaller, production-ready image as the final image
FROM nginx:alpine

# Copy the production-ready Angular app to the Nginx webserver's root directory
COPY --from=build /app/dist /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# # Use the official Node.js image as the base image
# FROM node:21.7.0 as build

# # Set the working directory in the container
# WORKDIR /app

# ENV HOST 0.0.0.0

# # Copy package.json and package-lock.json to the container
# COPY package*.json ./

# # Install project dependencies
# RUN npm install

# # Install Angular CLI globally
# RUN npm install -g @angular/cli

# # Copy the entire project to the container
# COPY . .

# # Build the Angular app for production
# RUN ng build 

# # Use a smaller, production-ready image as the final image
# FROM nginx:alpine

# #COPY --from=build /usr/local/app/dist/sample-angular-app /usr/share/nginx/html
# # Copy the production-ready Angular app to the Nginx webserver's root directory
# COPY --from=build /app/dist/bitacora-frontend /usr/share/nginx/html

# # Expose port 80
# EXPOSE 8080

# CMD ["nginx", "-g", "daemon off;"]