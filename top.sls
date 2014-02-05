### Top-level pillar - map configuration objects to minions
##########################################

base:
  '*':                  # Every minion gets...
    - users             # System administrators
    - useful_packages   # Packages I use as part of my daily workflow
    - miner             # Basic Salt Mine setup; feel free to extend it
 
  # Testing and development of hipikat.org 
  'clowder':
    - machines.clowder

