# gitea

## Initial set-up

1. Call `init.sh`
2. Execute `docker-compose up -d`
3. Go to `https://gitea.openorg.software` for initial configuration
   1. In ``General Settings
      1. Set `Site Title` to `OpenOrg Software Git`
      2. Set `Gitea Base URL` to `https://gitea.openorg.software/`
   2. In `Server and Third-Party Service Settings`
      1. Enable Local Mode = FALSE
      2. Disable Gravatar = FALSE
      3. Enable Federated Avatars = TRUE
      4. Enable OpenID Sign-In = TRUE
      5. Disable Self-Registration= FALSE
      6. Allow Registration Only Through External Service = TRUE
      7. Enable OpenID Self-Registration = TRUE
      8. Enable registration CAPTCHA = FALSE
      9. Require Sign-In to View Pages = FALSE
      10. Hide Email Addresses by Default = FALSE
      11. Allow Creation of Organizations by Default = TRUE
      12. Enable Time Tracking by Default = TRUE
      13. Hidden Email Domain = noreply.localhost
      14. Password Hash ALgorithm: bcrypt
  1.  In `Administrator Account Settings` set up a proper admin account
4. Execute `docker-compose stop`
5. Edit `config/app.ini`
   1. In section `[openid]` add `WHITELISTED_URIS=https://sso.openorg.software`
6. Execute `docker-compose up -d`

## Keycloak SSO Configuration

1. Add client to keycloak
   1. Client ID: `gitea`
   2. Base URL: https://gitea.openorg.software
2. Configure client
   1. Access Type: `confidential`
3. Configure Mappers
   1. Add builtin -> groups
      1. Add to userinfo -> On
4. Configure Roles
   1. Add Role -> Role Name: gitea-access
5. Assign Role to all users with access to gitea

## gitea Authentication Source

- Authentication Type: `OAuth2`
- Authentication Name: `keycloak`
- OAuth2 Provider: `OpenID Connect`
- client ID: `gitea`
- client secret:See keycloak client credentials
- OpenID Connect Auto Discovery URL: `https://sso.openorg.software/realms/openorg/.well-known/openid-configuration`
- Required claim name: `groups`
- Required claim value: `gitea-access`
