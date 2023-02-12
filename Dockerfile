# Use an official Node.js runtime as a parent image
FROM node:14.17.0

COPY [".", "/app"]

# Set the working directory to /app
WORKDIR /app

# Install any needed packages specified in package.json
RUN npm install

# Make port 3000 available to the world outside this container
EXPOSE 3000

CMD [ "npm", "start" ]