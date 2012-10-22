PORT=8004
ENDPOINT=/v1
#export HOST=localhost

get_tenant_id() {
    local tenant_name=$1
    echo $(keystone tenant-list | awk -F'|' "\$3 ~ \"^ ${tenant_name} *\$\" { print \$2 }")
}

. ~/.openstack/keystonerc
TENANT=`get_tenant_id "$OS_TENANT_NAME"`
