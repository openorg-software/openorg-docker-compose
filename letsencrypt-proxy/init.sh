#!/bin/bash

# Create all directories
mkdir -p acme.sh
mkdir -p ./nginx/certs
mkdir -p ./nginx/vhost.d
mkdir -p ./nginx/html
mkdir -p ./nginx/conf.d
# Create network
docker network create proxy
