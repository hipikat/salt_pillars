

saltlick:
  salt_cloud:

    # saltlick:salt_cloud:providers:digitalocean-secrets
    # is defined in pillar/secrets/hipikats_eyes_only.sls
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
        image: 14.10 x64
        size: 512MB
        private_networking: True
        backups_enabled: True
        delete_sshkeys: True
        script_args: -LUP git 2015.2
        minion:
          master: kerry-a.hpk.io

      salt_dev:
        extends: default
        size: 1G
        deploy: False
        grains: 
          profile: development

