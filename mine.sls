#
# Salt functions to be periodically mined on minions
########################################################################


{% from "settings.jinja" import settings %}


{% set empire = settings.get('empire', {}) %} 


mine_functions:
  network_interfaces:
    mine_function: network.interfaces

  {% if 'public_interface' in empire %}
  public_ip:
    mine_function: network.interface_ip
    iface: {{ empire['public_interface'] }}
  {% endif %}

  {% if 'private_interface' in empire %}
  private_ip:
    mine_function: network.interface_ip
    iface: {{ empire['private_interface'] }}

  private_subnets:
    mine_function: network.subnets
    interfaces: {{ empire['private_interface'] }}
  {% endif %}
