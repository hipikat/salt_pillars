#
# Adam Wright's main testing-and-development box
####################################################

{% from 'projects/hipikat_org.sls' import hipikat_org %}

# Template dict containing the project defaults, for reference and copy-forking
{# set hipikat_defaults = { 
    'name': 'hipikat.org',     # The 'deploy_name' must be unique to this checkout/install
    'fqdn': 'hipikat.org',     # Base FQDN used by Nginx and set as an environment variable
    'git_rev': 'djcms3',       # Git branch or tag to checkout
    'python_version': '3.3.5', # Python version used in virtual environment
    'settings': 'Production',  # Value of DJANGO_SETTINGS_CLASS in the virtual environment
    'port': '80',              # Port Nginx runs the server on
    'http_basic_auth': true,   # Protect the whole site with HTTP basic auth; add keys for admins
    'site_enabled': true,      # Enable configuration in Nginx, ensure Nginx is running
    'wsgi_enabled': true,      # Turn on the Supervisor uWSGI job for this project
    'reload_watch': false,     # Run a process to restart the uWSGI job if changes are made
} #}

# Python 2 development deployment on the djcms3 branch
{% set hipikat_py2_dev = { 
    'name': 'hipi2-dev',
    'git_rev': 'djcms3',
    'python_version': '2.7.6',
    'settings': 'Development',
    'fqdn': 'py2.clowder.hpk.io',
    'http_basic_auth': true,
    'wsgi_enabled': false,
} %}

# Python 3 development deployment on the djcms3 branch
{% set hipikat_py3_dev = { 
    'name': 'hipi3-dev',
    'git_rev': 'djcms3',
    'settings': 'Development',
    'fqdn': 'py3.clowder.hpk.io',
    'http_basic_auth': true,
    'wsgi_enabled': false,
} %}

# Have Chippery configure the full web stacks for projects
chippery:
  enabled: True

  # Lay out the WSGI projects defined above
  wsgi_projects:
    {{ hipikat_org(**hipikat_py2_dev)|indent(4) }}
    {# hipikat_org(**hipikat_py3_dev)|indent(4) #}

  # Base Virtualenv and project paths
  #virtualenv_path: /opt/venv
  #project_path: /opt/proj

  # Superusers for the target machines. They get accounts in EVERYTHING!
  sysadmins:
    - hipikat

  # Return 444 (no response) for all non-configured virtual hosts
  nginx_default:
    directives:
      - return 444
