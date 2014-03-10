#
# Adam Wright's main testing-and-development box
####################################################

{% from 'projects/hipikat_org.sls' import hipikat_org %}


{% set hipikat_dev = { 
    'name': 'hipi-dev',
    'settings': 'Development',
    'fqdn': 'dev.hpk.io',
    'http_basic_auth': true,
} %}


# Have Chippery configure the full web stacks for projects
chippery:
  enabled: True

  # Base Virtualenv and project paths
  #virtualenv_path: /opt/venv
  #project_path: /opt/proj

  # Superusers for the target machines
  sysadmins:
    - hipikat

  # Return 444 (no response) for all non-configured virtual hosts
  nginx_default:
    directives:
      - return 444

  # Lay out the WSGI projects defined above
  wsgi_projects:
    {{ hipikat_org(**hipikat_dev)|indent(4) }}
