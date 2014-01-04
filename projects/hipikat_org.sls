
# Define basic configuration for the project



# ... TODO: Ask yourself if there's enough logic getting into this thing
# that we should use a Python renderer for it. If we do, we can't have
# Jinja macros imported into the host VM SLS files. So obviously we should
# make them Python renderers too? Would that be so bad? That might be good.
# How do we import project config defined here into the host VM SLS?



# Return YAML configuration for the project based on arguments
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
