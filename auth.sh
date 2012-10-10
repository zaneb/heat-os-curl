. ~/.openstack/keystonerc

username() {
    echo "X-Auth-User: ${OS_USERNAME:?}"
}

password() {
    echo "X-Auth-Key: ${OS_PASSWORD:?}"
}

auth_token() {
    AUTH_JSON="{\"auth\": {                      \
        \"passwordCredentials\": {               \
            \"username\": \"${OS_USERNAME:?}\",  \
            \"password\": \"${OS_PASSWORD:?}\"   \
        },                                       \
        \"tenantName\": \"${OS_TENANT_NAME:?}\"  \
    }}"

    TOKEN=$(curl -s -d "$AUTH_JSON" -H "Content-type: application/json" ${OS_AUTH_URL:?}/tokens | sed -e 's/\([{},]\)/\1\n/g' | sed -n -e '/^"token":/,/^}/ {' -e '/"id":/ {' -e 's/[^:]\+: "\([0-9a-f]\+\)",$/\1/' -e p -e q -e '}' -e '}')

    echo "X-Auth-Token: ${TOKEN}"
}
