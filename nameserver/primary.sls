#
# Pillar data for primary nameserver, which runs the local cluster's
# private naming and can do all the DNS forwarding (and caching).
####################################################


{% from "settings.jinja" import settings %}
{% set empire = settings.get('empire', {}) %}
{% set sovereign = empire.get('sovereign', {}) %}
{% set cluster_tld = empire.get('tld', None) %}


include:
  - nameserver.installed
  - nameserver.common


{% if cluster_tld %}
bind:
  listen_on: {{ sovereign['listen_on'] }}

  configured_zones:
    {{ cluster_tld }}:
      type: master

  #available_zones:
  #  {{ cluster_tld }}:
  #    file: db.{{ cluster_tld }}

{% endif %}
