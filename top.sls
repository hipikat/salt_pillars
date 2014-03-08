#
# Top-level pillar - map configuration objects to minions
##########################################

base:
  '*':                  # Every minion gets...
    - users             # System administrators
    - miner             # Basic Salt Mine setup; feel free to extend it

  'mr-*':
    - saltlick
 
  # Testing and development cluster for hipikat.org 
  'clowder':
    - machines.clowder

