#
# Chippery project configuration for Future Students
####################################################


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
- lib/django-cinch
{% endmacro %}

# Return YAML config for the Future Students project.
{% macro studyat_uwa() %}
  {% set deploy_name = kwargs.get('name', 'studyat-uwa') %}
  {% set fqdn = kwargs.get('fqdn', 'studyat.uwa.edu.au') %}
  {% set settings = kwargs.get('settings', 'Production') %}
  {% set owner = kwargs.get('owner', 'weboffice') %}

  {{- deploy_name ~ ':' }}

    # Project source
    git_url: git@github.com:hipikat/studyat_uwa.git
    {% if 'git_rev' in kwargs %}
    git_rev: {{ kwargs['git_rev'] }}
    {% endif %}

    # Project administrators
    owner: {{ owner }}
    admins:
      - {{ owner }}
      {# for admin in ('awright', 'tphillips', 'gmutale', 'vtran') #}
      {% for admin in ('hipikat') %}
      {% if admin != owner %}
      - {{ admin }}
      {% endif %}
      {% endfor %}

    # System components
    include:
      - pillow
      #- memcached
    #system_packages:
      # For packages requiring lxml (currently, on latest Ubuntu (still not working))
      #- libxml2-dev
      #- libxslt-dev
      #- lib32z1-dev
      # For Foundation/Compass/Sass watching/compiling
      #- bundler

    # Requirements
    python_version: {{ kwargs.get('python_version', '2.7.6') }}
    #python_requirements: etc/requirements.txt
    lib_root: lib
    libs:
      django-cinch: https://github.com/hipikat/django-cinch.git
      django-cms:
        url: https://github.com/divio/django-cms.git
        rev: 3.0c1
        pip-install:
          editable: true
      envdir:
        url: https://github.com/hipikat/envdir.git
        rev: no-clobber
        pip-install:
          editable: true

    # Database
    databases:
      {{ deploy_name }}:
        type: postgres
        owner: {{ kwargs.get('db_owner', owner) }}

    # App configuration
    wsgi_module: studyat_uwa.wsgi
    port: {{ kwargs.get('port', 80) }}
    envdir: var/env
    env:
      # TODO: Database passwords
      DJANGO_DATABASE_URL: postgres://{{ owner }}:insecure@localhost/{{ deploy_name }}
      DJANGO_SETTINGS_MODULE: studyat_uwa.settings
      DJANGO_SETTINGS_CLASS: {{ settings }}
      DJANGO_ROOT_FQDN: {{ fqdn }}
    python_paths:
      {{ python_paths()|indent(6) }}
    watch_dirs: 
      {{ watch_dirs()|indent(6) }}

    # Bootstrap triggers
    post_install:
      venv_postactivate_hook:
        run: ln -fs %proj%/scripts/export_env.sh %venv%/bin/postactivate
        onlyif: test ! -h %venv%/bin/postactivate

    # Runtime switches
    site_enabled: {{ kwargs.get('site_enabled', true) }}
    wsgi_enabled: {{ kwargs.get('wsgi_enabled', true) }}
    reload_watch: {{ kwargs.get('reload_watch', false) }}
    
    # Web server configuration
    http_basic_auth: {{ kwargs.get('http_basic_auth', false) }}
    servers:
      {{ fqdn }}:
        locations:
          '/':
            pass_upstream: true
          # Serve /static and /media files from var/[static|media]
          {% for file_dir in ('/media', '/static') %}
          {{ file_dir }}:
            alias: var{{ file_dir }}
            {% if ( kwargs.get('autoindex') is not none and kwargs['autoindex'] ) or (
               settings in ('Debug', 'Development') ) %}
            directives:
              - autoindex on;
            {% endif %}
          {% endfor %}

{% endmacro %}
