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
  # Cluster defaults
  '*':
    - salt
    - salt_mine
    - packages
    - firewall
    - users
    - openssh
    - vsftpd
    - web

  # Master controller
  'orchard':
    #- irc
    - games

  # Per-machine projects
  'apricot':
    - wordpress.exalted

  # Don't do this, they say everything should default to UTC
  #'not P@timezone:':
  #  - match: compound
  #    # - tz-perth-au
