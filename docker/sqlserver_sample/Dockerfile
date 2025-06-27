# Use a base image (you can choose an appropriate base image for your scripts)
FROM mcr.microsoft.com/mssql/server:2022-latest

# Set the working directory inside the container
WORKDIR /app

# Copy your scripts into the container
COPY ./scripts /docker-entrypoint-initdb.d

# Set execute permissions for the scripts
USER root
RUN chmod +x /docker-entrypoint-initdb.d/*.sh
RUN chmod -R 777 /docker-entrypoint-initdb.d/
USER mssql

RUN /opt/mssql/bin/sqlservr --accept-eula & /docker-entrypoint-initdb.d/install-databases.sh

USER root
RUN rm -r /docker-entrypoint-initdb.d
USER mssql