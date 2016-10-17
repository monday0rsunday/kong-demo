docker-compose up

docker cp kong.conf kongtest_kong-distro_1:/etc/kong/ \
&& docker cp lua-test kongtest_kong-distro_1:/usr/local/share/lua/5.1/kong/plugins/


curl -i -X POST \
  --url http://localhost:8001/apis/ \
  --data 'name=mockbin' \
  --data 'upstream_url=http://mockbin.com/' \
  --data 'request_host=mockbin.com'

curl -X POST http://localhost:8001/apis/mockbin/plugins \
    --data "name=lua-test"

curl -X POST http://localhost:8001/apis/mockbin/plugins \
    --data "name=oauth2" \
    --data "config.enable_password_grant=true" \
    --data "config.scopes=email,phone,address" \
    --data "config.mandatory_scope=true"


{"api_id":"46d8f0e3-0078-40cc-9fb9-6b65255f8d96","id":"ba39b889-e295-4c6e-8952-a7086fcc24c0","created_at":1475724194000,"enabled":true,"name":"oauth2","config":{"mandatory_scope":true,"token_expiration":7200,"enable_implicit_grant":false,"scopes":["email","phone","address"],"hide_credentials":false,"enable_password_grant":true,"accept_http_if_already_terminated":false,"provision_key":"1bf03f7fc17845f09560994331a56c84","enable_client_credentials":false,"enable_authorization_code":false}}




curl -X POST http://localhost:8001/consumers/ \
    --data "username=userg01" \
    --data "custom_id=customerg01"


{"custom_id":"customerg01","username":"userg01","created_at":1475724212000,"id":"0c63715c-1cbd-4e5a-9a1c-3b9430558218"}




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
    --data "provision_key=1bf03f7fc17845f09560994331a56c84" \
    --data "authenticated_userid=12" \
    --data "username=congnh" \
    --data "password=a@2a@2"


nc -k -l 10.22.20.179 8888
echo "333" | nc 10.22.20.179 8888

curl -X POST http://localhost:8001/apis/mockbin/plugins \
    --data "name=tcp-log" \
    --data "config.host=10.22.20.179" \
    --data "config.port=8888" \
    --data "config.timeout=1000" \
    --data "config.keepalive=1000"