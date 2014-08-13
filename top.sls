#
# Minion pillar configuration
####################################################

base:
  # My 'peak' master. Utility box, IRC proxy, and deployer of other masters.
  'mr-bones':
    - groups.hipikat
    - machines.emperor
    - maps.fullstack
    - maps.splitends

  # Syndicated master for testing and development
  #'clowder':
  #  - machines.clowder
  #  - groups.hipikat

  # PriceTrack dev box
  #'cockerel':
  #  - machines.cockerel
