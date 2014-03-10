#
# Minion pillar configuration
####################################################

base:
  # All minions get...
  '*':
    - users             # System administrator user accounts
    - miner             # Basic Salt Mine setup
    - sys_packages      # Useful system, system-Python, etc. packages

  # Top-level Salt masters
  'mr-*':
    - saltlick.master
 
  # Syndicated master for testing and development
  'clowder':
    - machines.clowder
