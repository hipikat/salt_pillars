#
# Saltlick master configuration
##########################################

{% from 'secrets.sls' import digitalocean_key %}

saltlick:
  salt_cloud:
    master_address: salt.hpk.io
    client_key: {{ digitalocean_key('client') }}
    api_key: {{ digitalocean_key('api') }}
