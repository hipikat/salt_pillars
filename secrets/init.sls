# Example secrets file (cp without .example and delete this line.)
#
# Strings for htpasswd can be generated with apache2-utils's htpasswd
# script. Nginx accepts crypt() or MD5-based passwords. Circa January
# 2014, uWSGI only accepts crypt.
##########################################

{% macro htpasswd(user) -%}
  {%- if user == 'hipikat' -%}
    12345
  {%- endif -%}
{%- endmacro %}

# Cloud provider secrets
{% macro digitalocean_key(type) -%}
  {%- if type == 'client' -%}
    123456789
  {%- elif type == 'api' -%}
    123456789
  {%- endif -%}
{%- endmacro %}
