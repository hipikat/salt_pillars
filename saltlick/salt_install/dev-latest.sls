

saltlick:
  # Install Salt in a Virtualenv from a GitHub checkout
  salt_install:
    type: development
    launcher: supervisor
    virtualenv_dir: /opt/salt
    source_dir: /opt/salt/salt
    rev: v2015.8.0
