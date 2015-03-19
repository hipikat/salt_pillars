#
# Chippery project configuration for UWA Unwrapped
####################################################


{% macro unwrapped() %}
  {% set fqdn = kwargs.get('fqdn', 'unwrapped.hpk.io') %}
  {% set settings = kwargs.get('settings', 'Production') %}


{% endmacro %}
