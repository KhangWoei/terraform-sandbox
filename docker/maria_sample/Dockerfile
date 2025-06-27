FROM mariadb:latest

# Set the working directory inside the container
WORKDIR /app

# Copy your scripts into the container
COPY ./scripts /docker-entrypoint-initdb.d

# Set execute permissions for the scripts
RUN chmod +x /docker-entrypoint-initdb.d/*.sh
RUN chmod -R 777 /docker-entrypoint-initdb.d/