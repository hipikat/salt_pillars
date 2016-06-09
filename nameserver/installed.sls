#
# Install BIND and define a basic configuration
####################################################


{% from "settings.jinja" import settings %}


include:
  - nameserver.common

bind:
  config:
    # Set up BIND for IPv4 only
    protocol: 4

    options:
      recursion: yes
      allow-recursion:
        - trusted
      allow-transfer:
        - none
      forwarders:
        {% for forwarder in settings.get('dns_forwarders',
                                         ['8.8.8.8', '8.8.4.4']) %}
          - {{ forwarder }}
        {% endfor %}
