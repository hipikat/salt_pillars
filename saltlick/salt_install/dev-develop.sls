

saltlick:
  # Install Salt in a Virtualenv from a GitHub checkout
  salt_install:
    method: development
    launcher: supervisor
    virtualenv_dir: /opt/salt
    source_dir: /opt/salt/salt
    rev: develop
