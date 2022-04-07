#!/bin/bash

# Create all directories
mkdir -p nginx
mkdir -p acme.sh

# Create network
docker network create proxy
