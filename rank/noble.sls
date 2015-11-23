#
# Pillar data for persistent boxes
########################################


include:
  # Include deploy keys, cloud provider auth tokens, etc.
  - secrets

swapfile: 2G

system_packages:
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

  # See secrets.sls.example to find the missing pieces.
  salt_cloud:
    providers:
      digitalocean-sgp1:
        - extends: digitalocean-secrets:digital_ocean
          location: Singapore 1

      digitalocean-ny2:
        - extends: digitalocean-secrets:digital_ocean
          location: New York 2

    profiles:
      default:
        provider: digitalocean-sgp1
        image: 15.04 x64 
        size: 512MB
        private_networking: True
        backups_enabled: True
        delete_sshkeys: True
        script_args: -LUP git v2015.8.0
        minion:
          # References main Salt master using a Class A private address
          master: salt-a.hpk.io

      # When we don't actually want to immediately install Salt
      bare:
        extends: default
        deploy: False
        grains: 
          profile: development

      # For machines running outside my Digital Ocean private network
      external:
        extends: default
        minion:
          master: salt.hpk.io
