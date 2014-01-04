
# Define configuration for the project
{% macro _hipikat_org() %}
git_url: https://github.com/hipikat/hipikat.org.git
settings: {{ 'Production' if 'settings' not in kwargs else kwargs['settings'] }}
envdir: var/env
requirements: etc/requirements.txt
{% endmacro %}

# Wrap the project's settings in a YAML dict name matching the name of
# the virtualenv, if one is provided
{% macro hipikat_org() %}
  {% if 'virtualenv_name' in kwargs %}
    {{- kwargs['virtualenv_name'] }}
    {{- _hipikat_org(**kwargs)|indent(2, true) }}
  {% else %}
    {{- _hipikat_org(**kwargs) }} 
  {% endif %}
{% endmacro %}
