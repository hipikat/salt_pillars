#
# Pillar data shared by all machines in the cluster, all the time
###############################################################################


swapfile: 4G

system:
  package_repositories:
    DeadSnakes (Python):
      ppa: deadsnakes/ppa
      #name: deb http://ppa.launchpad.net/deadsnakes/ppa/ubuntu bionic main

  packages:
    apt-transport-https: True
    ca-certificates: True
    curl: True
    fail2ban: True
    git: True
    python3-software-properties: True
    #python3.5: True
    #python3.5-venv: True
    unzip: True
    virtualenv: True
    virtualenvwrapper: True
    zip: True

  #python_packages:
  #  autoenv: True
  #  flake8: True
  #  httpie: True
  #  pep8: True

node:
    install_path: /opt/nvm

