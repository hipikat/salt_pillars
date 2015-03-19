

saltlick:

  # Install Salt in a Virtualenv from a GitHub checkout
  salt_install:
    type: dev
    launcher: supervisor
    virtualenv_dir: /opt/salt
    source_dir: /opt/salt/salt
    config_dir: /etc/salt
    rev: 2015.2
