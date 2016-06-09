#
# Firewall configuration - data for the official Salt iptables-formula
###############################################################################

{% from "settings.jinja" import settings %}

{% set allowed_anywhere = [
  'ssh',
] %}


firewall:
  enabled: True
  install: True
  strict: True

  whitelist:
    networks:
      ips_allow:
        {% if 'whitelist' in settings %}
        {% set trusted_ips = settings['whitelist'].get('ips', []) %}
          {% for ip in trusted_ips %}
            - {{ ip }}
          {% endfor %}
        {% endif %}
        {% if 'private_cidr' in settings %}
            - {{ settings['private_cidr'] }}
        {% endif %}

  services:

    # Mosh
    60000:61000:
      ips_allow:
        - 0.0.0.0/0
      protos:
        - udp

    {% for service in allowed_anywhere %}
    {{ service }}:
      ips_allow:
        - 0.0.0.0/0
    {% endfor %}
