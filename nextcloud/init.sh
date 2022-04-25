#!/bin/bash

# Copy sample env
cp .env.sample .env

# Generate fresh secrets
POSTGRES_PASSWORD=$(openssl rand -hex 16)
sed -i "s/{{POSTGRES_PASSWORD}}/$POSTGRES_PASSWORD/g" .env
JWT_SECRET=$(openssl rand -hex 16)
sed -i "s/{{JWT_SECRET}}/$JWT_SECRET/g" .env

