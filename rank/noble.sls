#
# Pillar data for upper-eschelon machines
########################################


include:
  # Set up Salt Cloud
  - saltlick.cloud

  # Include deploy keys, cloud provider auth tokens, etc.
  - secrets


####
# Default system settings for upper-echelon machines

swapfile: 2G

system_packages:
  docker.io: True
  docker-compose: True
  # (Primary controller is also my IRC bouncer.)
  irssi: True

saltlick:
  # Salt roots and pillars
  salt_roots:
    url: git@github.com:hipikat/salt_roots.git
    deploy_key: saltlick:deploy_keys:hipikat-github

  # Install a dormant nameserver
  #- nameserver.installed


empire:
  rank: noble
