# Development box for hipikat.org

{% from 'projects/hipikat_org.sls' import hipikat_org %}

{% set hipikat_dev = { 
    'name': 'hipi-dev',
    'settings': 'Development',
    'fqdn': 'dev.hpk.io',
    'http_basic_auth': true,
} %}

chippery:
  enabled: True
  virtualenv_path: /opt/venv
  project_path: /opt/proj
  sysadmins:
    - hipikat
  nginx_default:
    directives:
      - return 444
  wsgi_projects:
    {{ hipikat_org(**hipikat_dev)|indent(2) }}


