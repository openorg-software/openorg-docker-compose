# nextcloud

## Apps

- Office & Test
  - OnlyOffice
- Integration
  - Social Login


## OnlyOffice

- In Settings -> ONLYOFFICE
  - ONLYOFFICE Docs address = `https://office.openorg.software`
  - Secret key = JWT_SECRET from `.env` file

## Single Sign-On

### Configure Keycloak

1. Log in to `<keycloak URL>` -> Administration Console with
      - `username: admin`
      - `password: see keepass`

2. Add Client
    - Clients -> Create
        - Client Id: Nextcloud
        - Protocol: openid-connect
        - Save!
3. Configure client
    - Name: nextcloud
    - Access Type: confidential
    - Root URL: `<nextcloud URL>`
    - Valid redirect URIs: `<nextcloud URL>/*`
    - Base URL: `<nextcloud URL>`
    - Fine Grain OpenID Connect Configuration
      - ID Token Signature Algorithm: `RS256`
    - save!
4. Configure mappers (All empty fields are not described)
    - sub (create nextcloud users with real username instead of keycloak ID)
        - Mapper Type: User Property
        - Property: username
        - Token Claim Name: sub
        - Claim JSON Type: String
        - Add to ID Token: on
        - Add to access Token: on
        - Add to userinfo: on
    - Realm Roles
        - name: realm roles
        - mapper type: User Realm Role
        - Multivalued: On
        - Token Claim Name: roles
        - Claim JSON Type: String
        - Add to ID Token: on
        - Add to access Token: on
        - Add to userinfo: on

## Configure Nextcloud

1. Install `Social Login` App
2. Configure `Social Login` at Settings -> Social Login
   - Global Settings
        1. [X] Update user profile every login
            - Ensures that a user change in keycloak (e.g. new role) is propagated to nextcloud
        1. [x] Automatically create groups if they do not exist
            - Ensures that all groups are created on login
3. Add new `Custom OpenID Connect` setting     
  - Internal name: keycloak
  - Title: OpenOrg SSO
  - Authorize URL: `https://sso.openorg.software/realms/openorg/protocol/openid-connect/auth`
  - Token URL: `https://sso.openorg.software/realms/openorg/protocol/openid-connect/token`
  - User Info URL: `https://sso.openorg.software/realms/openorg/protocol/openid-connect/userinfo`
  - Logout URL: `https://sso.openorg.software/realms/openorg/protocol/openid-connect/logout`
  - Client Id: nextcloud
  - Client Secret: In Keycloak -> Client -> Credentials -> Copy `secret`
  - Scope: `openid`
  - Groups claim: `roles`
  - Button Style: Keycloak
  - Default group: none
4. Add all relevant group mappings
  - e.g. `admin` & `admin`
  - Missing mappings result in automatically created groups if they are not known
  - The automatically created groups are prefixed with `keycloak-`
5. Add configuration in `config.php` (mounted in `/srv/nextcloud/data/config/config.php`)
  - `'overwriteprotocol' => 'https',`: use https, necessary because of reverse proxy
  - `'social_login_auto_redirect' => true,`: Automatically redirect to OpenOrg SSO, you can still access the direct login at [https://\<nextcloud URL\>/login?noredir=1](https://cloud.openorg.software/login?noredir=1)
  - `'allow_user_to_change_display_name' => false,`: The user info should only be edited in keycloak