#
# Top-level pillar - map configuration objects to minions
##########################################

base:
  '*':                  # Every minion gets...
    - users             # System administrator user accounts
    - miner             # Basic Salt Mine setup; feel free to extend it
    - sys_packages      # Useful system, system-Python, etc. packages

  'mr-*':
    - saltlick.master
 
  # Testing and development cluster for hipikat.org 
  'clowder':
    - machines.clowder

