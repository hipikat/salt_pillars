#
# Firewall configuration - using ufw-formula
###############################################################################

ufw:
  enabled: True

  settings:
    loglevel: low 
    ipv6: true
    default_input_policy: 'DROP'
    default_output_policy: 'ACCEPT'
    default_forward_policy: 'DROP'
    default_application_policy: 'SKIP'
    manage_builtins: false
    ipt_sysctl: '/etc/ufw/sysctl.conf'
    ipt_modules:
      - nf_conntrack_ftp
      - nf_nat_ftp
      - nf_conntrack_netbios_ns

  services:

    # Allow 80/tcp (http) traffic from only two remote addresses.
    http:
      protocol: tcp
      from_addr:
        - 124.171.8.244
      comment: Restrict web access to home (development) IP 

    https:
      protocol: tcp
      from_addr:
        - 124.171.8.244
      comment: Restrict (secure) web access to home (development) IP 

    ftps:
      comment: FTP over SSL

  # Allow an application defined at /etc/ufw/applications.d/
  applications:
    mosh:
      allow: true
    #nginx:
    #  enabled: true
    OpenSSH:
      allow: true

  # Allow all traffic in on the specified interface
  interfaces:
    eth2:
      comment: Private network
