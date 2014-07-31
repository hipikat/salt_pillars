#
# Saltlick configuration: Make `caddy` a peak master.

{% from 'secrets.sls' import digitalocean_key %}

saltlick:
  enabled: True
  salt_group: hipikat
  salt_roots: https://github.com/hipikat/salt-roots.git
  salt_pillars: https://github.com/hipikat/salt-pillars.git
  salt_formulas:
    users: https://github.com/saltstack-formulas/users-formula.git
    saltlick: https://github.com/hipikat/saltlick-formula.git
    chippery: https://github.com/hipikat/chippery-formula.git
  salt_cloud:
    master_address: mrbones.hpk.io
    client_key: {{ digitalocean_key('client') }}
    api_key: {{ digitalocean_key('api') }}


