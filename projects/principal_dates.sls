#
# Project configuration for UWA's Principal Dates application
#############################################################


{% macro principal_dates() %}
  {% set fqdn = kwargs.get('fqdn', 'principal-dates.hpk.io') %}

  id: UWA Principal Dates
  source:

    #url: git@github.com:hipikat/principal-dates.git
    #deploy_key: salt://deploy_keys/github/principal_dates
    #remote_name: github

    url: git@hpk.io:uwa-dates.git
    deploy_key: salt://deploy_keys/private/{{ kwargs['deploy_minion'] }}
    remote_name: hpk

    rev: {{ kwargs.get('source_rev', 'master') }}

  python_version: {{ kwargs.get('python_version', '2.6.6') }}
  #python_paths:
  #  - src

  ## Pip requirements file relative to source.url
  #python_requirements: etc/requirements.txt

  ## Python packages that require special system packages
  #python_system:
  #  - pillow

  ## Python libraries installed from source
  #python_libs:
  #  django-cms:
  #    url: https://github.com/divio/django-cms.git
  #    rev: 3.0.3
  #    editable: true
  #  envdir:
  #    url: https://github.com/hipikat/envdir.git
  #    rev: no-clobber
  #    editable: true

  ## System and cloud services
  #services:
  #  postgresql:
  #    owner: hipikat

  ## Server
  #wsgi_module: hipikat.wsgi
  #port: {{ kwargs.get('port', '80') }}
  #env_dir: var/env
  #env:
  #  DJANGO_DATABASE_URL: TODO
  #  DJANGO_ROOT_FQDN: {{ fqdn }}
  #  {% if kwargs.get('auto-reload', False) %}
  #  AUTO-RELOAD: True
  #  {% endif %}

  #post_install:
  #  make_secret_key:
  #    # TODO: We need the same key on each app server
  #    run: scripts/make_secret_key.py > var/env/DJANGO_SECRET_KEY
  #    onlyif: test ! -f var/env/DJANGO_SECRET_KEY
  #  venv_postactivate_hook:
  #    run: ln -fs %proj%/scripts/export_env.sh %venv%/bin/postactivate
  #    # TODO: This test should look at relative modification dates
  #    onlyif: test ! -f %venv%/bin/postactivate

  ## Runtime switches
  #site_enabled: {{ kwargs.get('site_enabled', true) }}
  #wsgi_enabled: {{ kwargs.get('wsgi_enabled', true) }}

  ## Web server configuration
  #http_basic_auth: {{ kwargs.get('http_basic_auth', false) }}
  #servers:
  #  {{ fqdn }}:
  #    return: 301 http://www.{{ fqdn }}$request_uri
  #  www.{{ fqdn }}:
  #    locations:
  #      '/':
  #        pass_upstream: true
  #      # Serve /static and /media files from var/[static|media]
  #      {% for file_dir in ('/media', '/static') %}
  #      {{ file_dir }}:
  #        alias: var{{ file_dir }}
  #      {% endfor %}
  #  blog.{{ fqdn }}:
  #    locations:
  #      '/':
  #        pass_upstream: true

{% endmacro %}
