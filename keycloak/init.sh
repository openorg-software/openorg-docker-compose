#!/bin/bash

# Copy sample env
cp .env.sample .env

# Generate fresh secrets
KEYCLOAK_PASSWORD=$(openssl rand -base64 64)
sed -i "s/{{KEYCLOAK_PASSWORD}}/$KEYCLOAK_PASSWORD/g" .env
POSTGRES_PASSWORD=$(openssl rand -base64 64)
sed -i "s/{{POSTGRES_PASSWORD}}/$POSTGRES_PASSWORD/g" .env
sed -i "s/{{DB_PASSWORD}}/$DB_PASSWORD/g" .env
