#
# Salt functions to be periodically mined on minions
########################################################################


{% from "settings.jinja" import settings %}

mine_functions:
  network:
    mine_function: network.interfaces

  public_ip:
    mine_function: network.interface_ip
    iface: {{ settings.public_interface }}

  private_ip:
    mine_function: network.interface_ip
    iface: {{ settings.private_interface }}

  private_subnets:
    mine_function: network.subnets
    interfaces: {{ settings.private_interface }}

