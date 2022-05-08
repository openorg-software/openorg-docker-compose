# wiki.js

# SSO Authorization & Authentication in wiki.js:

Add groups
- `keycloak-access-group`
- ... (More groups if required)

## Keycloak SSO Configuration

1. Add client to keycloak
   1. Client ID: `wiki`
   2. Access Type: `confidential`
   3. Valid redirect URI: See wiki.js auth strategy (Configuration Reference)

## wiki.js Authentication Strategy

- Display Name: Keycloak
- host: `https://sso.openorg.software`
- realm: `openorg`
- client ID: `wiki`
- client secret: See keycloak client credentials
- Auth Endpoint: `https://sso.openorg.software/realms/openorg/protocol/openid-connect/auth`
- Token Endpoint: `https://sso.openorg.software/realms/openorg/protocol/openid-connect/token`
- User Info Endpoint: `https://sso.openorg.software/realms/openorg/protocol/openid-connect/userinfo`
- Logout Endpoint: `https://sso.openorg.software/realms/openorg/protocol/openid-connect/logout`
- Allow self-registration
  - Assign to group: generic access group defined above


# Rendering via kroki

Settings -> Rendering -> Kroki
  - Kroki Server: `https://kroki.openorg.software`
  - Open Marker: ` ```kroki `
  - Close Marker: ` ``` `