#
# Firewall configuration - using ufw-formula
###############################################################################

{%- from "secrets.sls" import development, development_ips %}


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

    {% if development %}
    # Allow 80/tcp (http) traffic only from development machines.
    http:
      protocol: tcp
      from_addr:
        {% for development_ip in development_ips %}
        - {{ development_ip }}
        {% endfor %}
      comment: Restrict web access to home (development) IP 

    https:
      protocol: tcp
      from_addr:
        {% for development_ip in development_ips %}
        - {{ development_ip }}
        {% endfor %}
      comment: Restrict (secure) web access to home (development) IP 
    {% endif %}

    ftps:
      comment: FTP over SSL

  # Allow an application defined at /etc/ufw/applications.d/
  applications:
    mosh:
      allow: true
    {% if not development %}
    Nginx Full:
      enabled: false
    {% endif %}
    OpenSSH:
      allow: true

  # Allow all traffic in on the specified interface
  interfaces:
    eth2:
      comment: Private network
