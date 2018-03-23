#
# Pillar data for secondary nameserver, which runs the local cluster's
# private naming and can do all the DNS forwarding (and caching).
####################################################


include:
  - nameserver.installed
  - nameserver.common
