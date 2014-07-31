#
# Minion pillar configuration
####################################################

base:
  # My 'peak' master. Utility box, IRC proxy, and deployer of other masters.
  'mr-bones':
    - machines.mrbones
    - groups.hipikat

  # Syndicated master for testing and development
  'clowder':
    - machines.clowder
    - groups.hipikat

  # PriceTrack dev box
  'cockerel':
    - machines.cockerel
