name "ceph-nova"
description "Ceph Nova Client"
run_list(
        'recipe[ceph::nova]'
)
