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


base:
  # Default constants, throughout the cluster
  '*':
    - ubiquitous

  # I live in Perth and primarily use Digital Ocean droplets in the Singapore
  # farm, which is in my timezone, so unless an explicit 'timezone' grain is
  # set, I can safely default the system timezone to Australia/Perth.
  'not P@timezone:':
    - match: compound
    - tz-perth-au

  # All nobles are equal (i.e. they have the same basic software installed,
  # so any one of them should be able to be made the current sovereign just by
  # having all of the 'live sovereign's' data files copied across, and
  # services that only want to run on the one 'main' master enabled, i.e.
  # GitLab and the Salt master itself).
  'P@cluster_rank:sovereign or P@cluster_rank:noble':
    - match: compound
    - rank.noble

  # The sovereign has all 'main controller' parts enabled
  'P@cluster_rank:sovereign':
    - match: compound
    - rank.sovereign
