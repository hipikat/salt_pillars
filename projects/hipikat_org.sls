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
  {% set deploy_name = kwargs.get('name', 'hipikat.org') %}
  {% set fqdn = kwargs.get('fqdn', 'hipikat.org') %}
  {% set settings = kwargs.get('settings', 'Production') %}

  {{- deploy_name ~ ':' }}

    # Project source
    git_url: https://github.com/hipikat/hipikat.org.git
    git_rev: {{ kwargs.get('git_rev', 'master') }}

    # Project administrators
    owner: hipikat
    admins:
      - hipikat

    # System components
    include:
      - pillow
    #  - memcached
    system_packages:
      # For packages requiring lxml (currently, on latest Ubuntu (still not working))
      #- libxml2-dev
      #- libxslt-dev
      #- lib32z1-dev
      # For Foundation/Compass/Sass watching/compiling
      - bundler

    # Requirements
    python_version: {{ kwargs.get('python_version', '3.4.0') }}
    python_requirements: etc/requirements.txt
    lib_root: lib
    libs:
      django-cinch: https://github.com/hipikat/django-cinch.git
      django-revkom: https://github.com/hipikat/django-revkom.git
      {% if kwargs.get('git_rev') == 'djcms3' %}
      django-cms:
        url: https://github.com/divio/django-cms.git
        rev: 2.4.3
        pip-install:
          editable: true
      {% endif %}
      envdir:
        url: https://github.com/hipikat/envdir.git
        rev: no-clobber
        pip-install:
          editable: true

    # Database
    databases:
      {{ deploy_name }}:
        type: postgres
        owner: hipikat

    # App configuration
    wsgi_module: hipikat.wsgi
    port: {{ kwargs.get('port', 80) }}
    envdir: var/env
    env:
      DJANGO_DATABASE_URL: postgres://hipikat:insecure@localhost/{{ deploy_name }}
      DJANGO_SETTINGS_MODULE: hipikat.settings
      DJANGO_SETTINGS_CLASS: {{ settings }}
      DJANGO_ROOT_FQDN: {{ fqdn }}
    python_paths:
      {{ python_paths()|indent(6) }}
    watch_dirs: 
      {{ watch_dirs()|indent(6) }}

    # Bootstrap triggers
    post_install:
      make_secret_key:
        run: scripts/make_secret_key.py > var/env/DJANGO_SECRET_KEY
        onlyif: test ! -f var/env/DJANGO_SECRET_KEY
      venv_postactivate_hook:
        run: ln -fs %proj%/scripts/export_env.sh %venv%/bin/postactivate
        onlyif: test ! -f %venv%/bin/postactivate
          

    # Runtime switches
    site_enabled: {{ kwargs.get('site_enabled', true) }}
    wsgi_enabled: {{ kwargs.get('wsgi_enabled', true) }}
    reload_watch: {{ kwargs.get('reload_watch', false) }}
    
    # Web server configuration
    http_basic_auth: {{ kwargs.get('http_basic_auth', false) }}
    servers:
      {{ fqdn }}:
        return: 301 http://www.{{ fqdn }}$request_uri
      www.{{ fqdn }}:
        locations:
          '/':
            pass_upstream: true
            directives:
              {{ hipikat_rewrites()|indent(14) }}
          # Serve /static and /media files from var/[static|media]
          {% for file_dir in ('/media', '/static') %}
          {{ file_dir }}:
            alias: var{{ file_dir }}
            {% if ( kwargs.get('autoindex') is not none and kwargs['autoindex'] ) or (
               settings in ('Debug', 'Development') ) %}
            directives:
              - autoindex on
            {% endif %}
          {% endfor %}
      blog.{{ fqdn }}:
        locations:
          '/':
            pass_upstream: true

{% endmacro %}
