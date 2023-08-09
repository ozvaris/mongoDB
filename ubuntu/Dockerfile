# Using the official Ubuntu 20.04 base Docker image
FROM ubuntu:20.04

# Maintainer information
LABEL maintainer="your name <email@example.com>"

# Ensure non-interactive setup (useful when installing packages)
ENV DEBIAN_FRONTEND=noninteractive

# Update packages and install required packages
RUN apt-get update && \
    apt-get install -y \
    wget \
    curl \
    build-essential \
    openssl \
    vim && \  
    apt-get clean

# Set the working directory
WORKDIR /app

# Create a directory to be used as a volume
RUN mkdir /app/crt

# Mark the directory as a volume
VOLUME ["/app/crt"]

# Set the working directory
WORKDIR /app/crt

# Command to run when the Docker container starts
CMD ["/bin/bash"]
