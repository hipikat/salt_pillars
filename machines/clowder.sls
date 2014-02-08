{% from 'projects/hipikat_org.sls' import hipikat_org %}


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

wsgi_still:
  nginx_default:
    directives:
      - return 444
