#
# Chippery project configuration for Hipikat.org
####################################################

{% from 'projects/hipikat_org-rewrites.sls' import hipikat_rewrites %}


# Default watch directories; if `watch: true`, restart the app server
# if any files under these directories changes.
{% macro watch_dirs() %}
- etc
- lib
- src
- var/env
{% endmacro %}

# Paths relative to the project source added to the Python Path
{% macro python_paths() %}
- src
- etc
- lib/django-cinch
- lib/feincms-elephantblog
- lib/django-revkom
{% endmacro %}

# Return YAML config for the hipikat.org project.
{% macro hipikat_org() %}
  {% set fqdn = kwargs.get('fqdn', 'hipikat.org') %}
  {% set deploy_name = kwargs.get('name', 'hipikat.org') %}
  {{- deploy_name ~ ':' }}

    # Project source
    git_url: https://github.com/hipikat/hipikat.org.git
    {% if 'git_rev' in kwargs %}
    git_rev: {{ kwargs['git_rev'] }}
    {% endif %}

    # Project administrators
    admins:
      - hipikat

    # System components
    include:
      - pillow
      - postgresql
      - memcached

    # Requirements
    python_version: {{ kwargs.get('python_version', '2.7.6') }}
    python_requirements: etc/requirements.txt
    lib_dir: lib
    git_libs:
      django-cinch:
        url: https://github.com/hipikat/django-cinch.git
        rev: master
      feincms-elephantblog: https://github.com/hipikat/feincms-elephantblog.git
      django-revkom: https://github.com/hipikat/django-revkom.git

    # App configuration
    wsgi_module: hipikat.wsgi
    port: {{ kwargs.get('port', 80) }}
    envdir: var/env
    env:
      DJANGO_SETTINGS_MODULE: hipikat.settings
      DJANGO_SETTINGS_CLASS: {{ kwargs.get('settings', 'Production') }}
      DJANGO_ALLOWED_HOSTS: [{{ '.' ~ fqdn }}]
    python_paths:
      {{ python_paths()|indent(6) }}
    watch_dirs: 
      {{ watch_dirs()|indent(6) }}

    # Bootstrap triggers
    post_install:
      make_secret_key:
          run: scripts/make_secret_key.py > var/env/DJANGO_SECRET_KEY
          onlyif: test ! -f var/env/DJANGO_SECRET_KEY

    # Runtime switches
    site_enabled: {{ kwargs.get('enabled', true) }}
    wsgi_enabled: {{ kwargs.get('run_uwsgi', true) }}
    reload_watch: {{ kwargs.get('watch', false) }}
    
    # Web server configuration
    http_basic_auth: {{ kwargs.get('http_basic_auth', false) }}
    servers:
      {{ fqdn }}:
        return: 301 http://www.{{ fqdn }}$request_uri
      www.{{ fqdn }}:
        locations:
          '/':
            directives:
              {{ hipikat_rewrites()|indent(14) }}
            pass_upstream: true
          '/media':
            alias: var/media
          '/static':
            alias: var/static
      blog.{{ fqdn }}:
        locations:
          '/':
            pass_upstream: true

{% endmacro %}
