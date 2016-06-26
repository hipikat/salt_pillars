#
# Minion pillar configuration
########################################
#
# Compound matcher quick reference:
#
# G *   Grains glob
# E     PCRE minion ID
# P *   Grains PCRE
# L     List of minions
# I *   Pillar glob
# J *   Pillar PCRE
# S     Subnet/IP address
# R     Range cluster
# 
# '*' Indicates an alternative delimiter to ':' may be
# specified between the letter and '@' character.


{% from "settings.jinja" import settings %}


{% set empire = settings.get('empire', {}) %}

base:
  # Configure the node as a 'sovereign', 'prefect', 'noble' or 'peasant'
  # - see pillar/rank/README.txt for more information.
  {% for rank in empire.get('ranks', []) %}
    {% if rank in empire %}

  '{{ empire[rank] }}':
    - rank.{{ rank }}

    {% endif %}
  {% endfor %}

  # Older boxes, not managed by the Salt formula
  'not L@kerry':
    - match: compound
    - salt

  # Cluster defaults
  '*':
    - ubiquitous
    - users
    - firewall
    - mine

    # TODO: Delete me! (Just for development)
    - scratch

  # Default timezone to Perth unless a 'timezone' grain is set
  'not P@timezone':
    - match: compound
    - tz-perth-au
