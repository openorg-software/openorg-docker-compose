#!/bin/bash

# Copy sample env
cp .env.sample .env

# Generate fresh secrets
OPENSSL_KEY=$(openssl rand -hex 64)
sed -i "s/{{_APP_OPENSSL_KEY_V1}}/$OPENSSL_KEY/g" .env
DB_PASS=$(openssl rand -hex 64)
sed -i "s/{{_APP_DB_PASS}}/$DB_PASS/g" .env
DB_ROOT_PASS=$(openssl rand -hex 64)
sed -i "s/{{_APP_DB_ROOT_PASS}}/$DB_ROOT_PASS/g" .env
EXECUTOR_SECRET=$(openssl rand -hex 64)
sed -i "s/{{_APP_EXECUTOR_SECRET}}/$EXECUTOR_SECRET/g" .env

# Set uncritical variables
sed -i 's/{{_APP_DOMAIN_TARGET}}/aw.openorg.software/g' .env
sed -i 's/{{_APP_SYSTEM_EMAIL_NAME}}/OpenOrg Appwrite/g' .env
sed -i 's/{{__APP_SYSTEM_EMAIL_ADDRESS}}/aw@openorg.software/g' .env