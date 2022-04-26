#!/bin/bash
# Create all directories
mkdir -p data
mkdir -p config
mkdir -p postgres
chown 1000:1000 config/ data/
# Generate fresh secrets
cp .env.sample .env
POSTGRES_PASSWORD=$(openssl rand -hex 64) 
sed -i "s/{{POSTGRES_PASSWORD}}/$POSTGRES_PASSWORD/g" .env
sed -i "s/{{GITEA__database__PASSWD}}/$POSTGRES_PASSWORD/g" .env
