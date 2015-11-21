#
# Pillar data shared by all machines in the cluster, all the time
###############################################################################

include:
  - users

system_packages:
  curl: True
  git: True

python_packages:
  flake8: True
  httpie: True
  pep8: True
  virtualenvwrapper: True
