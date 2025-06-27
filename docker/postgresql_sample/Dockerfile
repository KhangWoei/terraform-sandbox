# Use a base image (you can choose an appropriate base image for your scripts)
FROM postgres:latest

# Set the working directory inside the container
WORKDIR /app
ENV POSTGRES_PASSWORD=P455w07d!

# Copy your scripts into the container
COPY ./scripts /docker-entrypoint-initdb.d

# Set execute permissions for the scripts
USER root
RUN chmod +x /docker-entrypoint-initdb.d/*.sh
RUN chmod -R 777 //docker-entrypoint-initdb.d/
USER postgres