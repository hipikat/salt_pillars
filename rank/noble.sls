#
# Pillar data for persistent boxes
########################################


include:
  # Set up Salt Cloud
  - saltlick.cloud

  # Include deploy keys, cloud provider auth tokens, etc.
  - secrets

  # Installed (but not necessarily enabled) software
  - gitlab


####
# Default system settings for upper-echelon machines

swapfile: 2G

system_packages:
  docker.io: True
  docker-compose: True
  irssi: True

saltlick:
  # Salt roots and pillars
  salt_roots:
    url: git@github.com:hipikat/salt_roots.git
    deploy_key: saltlick:deploy_keys:hipikat-github

  salt_pillars:
    url: git@github.com:hipikat/salt_pillars.git
    deploy_key: saltlick:deploy_keys:hipikat-github

  salt_formulas:
    # SaltStack-blessed formulas
    users: https://github.com/saltstack-formulas/users-formula.git

    # Hipikat's Salt formulas
  {% for formula in ('chippery', 'git-server', 'homeboy', 'saltlick', 'shoaler', 'system') %}
    {{ formula }}: 
      url: git@github.com:hipikat/{{ formula }}-formula.git
      deploy_key: saltlick:deploy_keys:hipikat-github
  {% endfor %}

