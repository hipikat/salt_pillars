#
# Pillar data for upper-eschelon machines
########################################


include:
  # Include deploy keys, cloud provider auth tokens, etc.
  - secrets

  # Set up Salt Cloud
  - saltlick.cloud

  # Install a dormant nameserver
  - nameserver.installed


empire:
  rank: noble


####
# Default system settings for upper-echelon machines

swapfile: 2G

system_packages:
  # (Primary controller is also my IRC bouncer.)
  irssi: True
