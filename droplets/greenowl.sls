{% from 'projects/hipikat_org.sls' import hipikat_org, foobar %}

{% set hipikat_dev = { 
    'virtualenv_name': 'hipi-dev',
    'tag': 'dev',
    'settings': 'Development',
} %}

django_projects:
  {{ hipikat_org(**hipikat_dev)|indent(2) }}
