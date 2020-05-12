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

  # Per-machine projects
  'apricot':
    - wordpress.exalted
    - games

  # Default timezone for myself and my boxen
  'not P@timezone:':
    - match: compound
    - tz-perth-au
