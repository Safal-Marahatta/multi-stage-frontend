# # Use a node base image
# FROM node:18

# # Set working directory
# WORKDIR /app

# # Copy package.json and package-lock.json
# COPY package*.json ./

# # Install dependencies
# RUN npm install

# # Copy application files
# COPY . .

# # Build the application
# RUN npm run build

# # Expose port
# EXPOSE 5173

# # Start the application
# CMD ["npm", "run", "dev"]




# Use the official Node.js image as a base
FROM node:14 as build

# Set working directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy project files
COPY . .

# Build the React app
RUN npm run build


# Use lightweight Nginx image for serving static files
FROM nginx:alpine



# Copy build files from the previous stage
COPY --from=build /app/dist /usr/share/nginx/html

                    #############
                    # COPY ./nginx_conf/nginx.conf /etc/nginx/nginx.conf
                    # COPY ./nginx_conf/default.conf /etc/nginx/conf.d/default.conf
                    ##############

                    # Expose port 80
EXPOSE 80

# Default command to start Nginx
CMD ["nginx", "-g", "daemon off;"]

#new