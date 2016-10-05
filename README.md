docker-compose up
docker cp lua-test container_name:/usr/local/share/lua/5.1/kong/plugins/

curl -X POST http://localhost:8001/apis/mockbin/plugins \
    --data "name=lua-test"

curl -X POST http://localhost:8001/apis/mockbin/plugins \
    --data "name=oauth2" \
    --data "config.enable_password_grant=true" \
    --data "config.scopes=email,phone,address" \
    --data "config.mandatory_scope=true"


{"api_id":"b43ed1a2-797d-4674-8d81-ddc59cb5e959","id":"21cdc329-41b7-4e60-a28b-1f1ac5592f25","created_at":1475655582000,"enabled":true,"name":"oauth2","config":{"mandatory_scope":true,"token_expiration":7200,"enable_implicit_grant":false,"scopes":["email","phone","address"],"hide_credentials":false,"enable_password_grant":true,"accept_http_if_already_terminated":false,"provision_key":"6fcb7c00378b45cf97386b09f120925d","enable_client_credentials":false,"enable_authorization_code":false}}




curl -X POST http://localhost:8001/consumers/ \
    --data "username=userg01" \
    --data "custom_id=customerg01"


{"custom_id":"customerg01","username":"userg01","created_at":1475654165000,"id":"8c3c62d7-376c-4fd3-9bd4-d441a2388967"}





curl -X POST http://localhost:8001/consumers/userg01/oauth2 \
    --data "name=Test%20Application" \
    --data "client_id=s6BhdRkqt3" \
    --data "client_secret=gX1fBat3bV" \
    --data "redirect_uri=http://some-domain/endpoint/"


    {"consumer_id":"8c3c62d7-376c-4fd3-9bd4-d441a2388967","client_id":"s6BhdRkqt3","id":"dd5839ca-3e11-4aea-80cd-72b10ec16c49","created_at":1475655655000,"redirect_uri":["http:\/\/some-domain\/endpoint\/"],"name":"Test Application","client_secret":"gX1fBat3bV"}



curl -k https://localhost:8443/oauth2/token \
	--header "Host: mockbin.com" \
    --header "Authorization: Basic czZCaGRSa3F0MzpnWDFmQmF0M2JW" \
    --data "grant_type=password" \
    --data "client_id=s6BhdRkqt3" \
    --data "client_secret=gX1fBat3bV" \
    --data "scope=email" \
    --data "provision_key=6fcb7c00378b45cf97386b09f120925d" \
    --data "authenticated_userid=12" \
    --data "username=congnh" \
    --data "password=a@2a@2"