### Top-level pillar - map configuration objects to minions
##########################################

base:
  '*':            # Every minion gets...
    - users       # System administrators

  # Test box for developing the projects/django_project formulas
  'foxypig':
    - droplets.foxypig

  'pinkdoge':
    - droplets.pinkdoge
