# Use a base image (you can choose an appropriate base image for your scripts)
FROM container-registry.oracle.com/database/free:latest

# Set the working directory inside the container
WORKDIR /app

# Copy your scripts into the container
COPY ./scripts /opt/oracle/scripts/startup

# Set execute permissions for the scripts
USER root
RUN chmod +x /opt/oracle/scripts/startup/*.sh
RUN chmod -R 777 /opt/oracle/scripts/startup/
USER oracle