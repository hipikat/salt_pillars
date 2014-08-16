#
# Minion pillar configuration
####################################################

base:
  # My 'peak' master. Utility box, IRC proxy, and deployer of other masters.
  'mr-bones':
    - groups.hipikat
    - machines.emperor

    # Import map/fullstack
    - maps.fullstack
    # Import map/frontend and map/layer4backend
    - maps.splitends

  # Syndicated master for testing and development
  #'clowder':
  #  - machines.clowder
  #  - groups.hipikat

  # PriceTrack dev box
  #'cockerel':
  #  - machines.cockerel
