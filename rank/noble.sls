#
# Pillar data for persistent boxes
########################################


include:
  # Include deploy keys, cloud provider auth tokens, etc.
  - secrets.hipikats_eyes_only

swapfile: 2G

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

  salt_cloud:

    # Cloud providers defined here get written to noble boxes,
    # in /etc/salt/cloud.providers.d/saltlick.conf
    #
    # The 'digitalocean-secrets' profile they extend is defined in 
    # pillar/secrets/hipikats_eyes_only.sls and it looks like:
    #
    # saltlick:
    #   salt_cloud:
    #     providers:
    #
    #       # Digital Ocean
    #       digitalocean-secrets:
    #         provider: digital_ocean
    #         ssh_key_names: hipikat-digitalocean,trepp-rsa,hipikat@bellus,hipikat@mimint
    #
    #         # See https://cloud.digitalocean.com/settings/applications#access-tokens
    #         personal_access_token: [64 character hexadecimal string]
    # 
    #         # Taken from saltlick:deploy_keys:hipikat-digitalocean:(public|private)
    #         # and written to /etc/saltlick/deploy_keys/hipikat-digitalocean[.pub]
    #         # - this becomes 'ssh_key_file' in Salt Cloud provider configurations.
    #         deploy_key: hipikat-digitalocean

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
      salt_ext:
        extends: default
        minion:
          master: salt.hpk.io
