#
# Install an IRC client and open ports in the firewall for the bouncer
###############################################################################


system_packages:
  irssi: True


firewall:
  services:
    5000:5020:
      service: IRC proxy
      ips_allow:
        - 0.0.0.0/0
      protos:
        - tcp
