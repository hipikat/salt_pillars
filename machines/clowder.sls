#
# Adam Wright's main testing-and-development box
####################################################

{% from 'projects/hipikat_org.sls' import hipikat_org %}
{% from 'projects/uwa_courses.sls' import uwa_courses %}
{% from 'projects/studyat_uwa.sls' import studyat_uwa %}


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
{% set hipi23 = { 
    'name': 'hipi23',
    'python_version': '2.7.6',
    'git_rev': 'djcms3',
    'settings': 'Development',
    'fqdn': 'hipi23.clowder.hpk.io',
    'http_basic_auth': true,
    'wsgi_enabled': false,
    'site_enabled': false,
} %}

# Python 3 development deployment on the djcms3 branch
{% set hipi33 = { 
    'name': 'hipi33',
    'git_rev': 'djcms3',
    'python_version': '3.3.5',
    'settings': 'Development',
    'fqdn': 'hipi33.clowder.hpk.io',
    'http_basic_auth': true,
    'wsgi_enabled': false,
    'site_enabled': false,
} %}


# Development install for experimental Future Students site
{% set uwa_courses_dev = { 
    'settings': 'Development',
    'fqdn': 'uwa-courseinfo.hpk.io',
    'http_basic_auth': true,
    'wsgi_enabled': false,
    'site_enabled': false,
} %}

# Development install for experimental Future Students site
{% set studyat_uwa_dev = { 
    'settings': 'Development',
    'fqdn': 'studyat-uwa.hpk.io',
    'http_basic_auth': true,
    'wsgi_enabled': false,
    'site_enabled': false,
} %}


# Have Chippery configure the full web stacks for projects
chippery:
  enabled: True

  # Lay out the WSGI projects defined above
  wsgi_projects:
    {{ hipikat_org(**hipi23)|indent(4) }}
    {# hipikat_org(**hipi33)|indent(4) #}
    {# uwa_courses(**uwa_courses_dev)|indent(4) #}
    {{ studyat_uwa(**studyat_uwa_dev)|indent(4) }}

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
