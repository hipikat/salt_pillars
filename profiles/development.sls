#
# Generic development box profile


include:
  # Include base system profile
  - profiles.base


#controllers:
#  pyenv: chippery.pyenv


#settings:
#  pyenv_dir: /usr/local/


# Unix groups
users:
  hipikat:
    sudouser: True
    sudo_rules:
      - 'ALL=(ALL) NOPASSWD: ALL'
    groups:
      - root
      - www-data
      - weboffice


# Shared settings
#settings:
#  # Used by system.default_user_umask formula
#  default_user_umask: '002'


# System and system-Python packages to install
system_python_packages:
  - virtualenvwrapper
