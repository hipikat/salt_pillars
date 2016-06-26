#
# Pillar data in common between all boxes that might act as a
# nameserver, such as what constitutes the list of trusted IPs...
####################################################


{% from "empire.jinja" import empire %}


{% set self = empire['self'] %}

{% if me == sovereign or me == prefect %}
# Only set bind data on sovereign and prefect

{% set run = salt['saltutil.runner'] %}
{% set private_ips = run('mine.get', tgt='not I@blacklisted', fun='private_ip',
                         tgt_type='compound') %}
{% set public_ips = run('mine.get', tgt='not I@blacklisted', fun='public_ip',
                        tgt_type='compound') %}

{% set my_cidrs = run('mine.get', tgt=me, fun='private_subnets')[me] %}
{% set sov_cidrs = run('mine.get', tgt=sovereign, fun='private_subnets')[sovereign] %}

bind:
  config:
    options:
      listen-on:
        {% if me == sovereign %}
        - {{ private_ips[sovereign] }}
        {% elif me == prefect %}
          {% for cidr in sov_cidrs %}
            {% if salt['network.ip_in_subnet'](private_ips[prefect], cidr) %}
        - {{ private_ips[prefect] }}
            {% else %}
        - {{ public_ips[prefect] }}
            {% endif %}
          {% endfor %}
        {% endif %}
      acl "trusted":
        {% for cidr in sov_cidrs %}
              - '{{ cidr }};  # Sovereign: {{ sovereign }}'
        {% endfor %}
        {% for minion, ips in private_ips|dictsort %}
          {% if ips is string %}
            {% for cidr in sov_cidrs %}
              {% if salt['network.ip_in_subnet'](ips, cidr) %}
              - '{{ ips }};   # {{ minion }}'
              {% else %}
                {% set ext_ip = run('mine.get', tgt=minion, fun='public_ip')[minion] %}
              - '{{ ext_ip }};   # {{ minion }} (external)'
              {% endif %}
            {% endfor %}
          {% else %}
            {% for ip in ips %}
              {% for cidr in sov_cidrs %}
                {% if salt['network.ip_in_subnet'](ip, cidr) %}
              - '{{ ip }};    # {{ minion }}'
                {% endif %}
              {% endfor %}
            {% endfor %}
          {% endif %}
        {% endfor %}


{% endif %}
