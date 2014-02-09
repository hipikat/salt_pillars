# Development box for hipikat.org

{% from 'projects/hipikat_org.sls' import hipikat_org %}

wsgi_still:
  enabled: True
  nginx_default:
    directives:
      - return 444

# TODO: Append -local to fqdn if grains indicate we're running in Virtualbox
{% set hipikat_dev = { 
    'name': 'hipi_dev',
    'settings': 'Development',
    'fqdn': grains['host'] ~ '-hipikat.org',
    'port': 8889,
    'http_basic_auth': true,
    'enabled': true,
} %}

wsgi_mash:
  {{ hipikat_org(**hipikat_dev)|indent(2) }}


