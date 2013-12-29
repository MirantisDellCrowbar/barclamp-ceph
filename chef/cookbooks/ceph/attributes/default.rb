default['ceph']['install_debug'] = true
default['ceph']['encrypted_data_bags'] = false
default['ceph']['monitor-secret'] = "AQAkTzBSQIGsLRAATtjTpJ1RgdviJz1S0byJBA=="
default['ceph']['admin-secret'] = "AQAkTzBSmGKZFhAATjC+lKfxOxL1Wn+rgwbWpg=="
default['ceph']['osd_devices'] = []

# packages
case node[:platform]
when "debian", "ubuntu"
  default[:ceph][:packages][:common] = ["ceph", "ceph-common"]
  default[:ceph][:packages][:common_debug] = ["ceph-dbg", "ceph-common-dbg"]
when "rhel", "fedora", "centos"
  default[:ceph][:packages][:common] = ["ceph"]
  default[:ceph][:packages][:common_debug] = ["ceph-debug"]
when "suse"
  default[:ceph][:packages][:common] = ["ceph", "ceph-kmp-default"]
  default[:ceph][:packages][:common_debug] = []
end
