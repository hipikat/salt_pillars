#
# Pillar data shared by all machines in the cluster, all the time
###############################################################################


system:
  package_repositories:
    Felix Krull's Python PPA:
      ppa: fkrull/deadsnakes

  packages:
    apt-transport-https: True
    ca-certificates: True
    curl: True
    fail2ban: True
    git: True
    python3.5: True
    python3.5-venv: True
    unzip: True
    virtualenv: True
    virtualenvwrapper: True
    zip: True

  python_packages:
    autoenv: True
    flake8: True
    httpie: True
    pep8: True
