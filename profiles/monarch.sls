#
# Highest-level master profile


include:
  # Include base system profile
  - profiles.base

  # Install roots, pillars & formulas common to Adam Wright's masters
  - saltlick.hipikat_flats

  # Include deploy keys, cloud provider auth tokens, etc.
  - secrets.hipikats_eyes_only

  # Salt-cloud provider and profile settings
  - saltlick.hipikat_clouds




# Unix groups
users:
  hipikat:
    sudouser: True
    sudo_rules:
      - 'ALL=(ALL) NOPASSWD: ALL'
    groups:
      - root


# System and system-Python packages to install
system_python_packages:
  - virtualenvwrapper

system_packages:
  - irssi
#    # Note: pkg/hold appears broken in Salt 2014.7.2 - possibly issue 13293
#  - zangband:
#      hold: True


# Rsync anything that should exist on replicated servers and isn't already
# replicated with states and pillars and version control. TODO: Implement...
rsync_folders:
  patterns:
    - /home/*
    - /var/games/zangband


# Simple, shared, ssh-based git server via formula
git-server:
  authorized_users:
    - hipikat


# Act as a DynDNS-like master-server (or something?!)
# (not programmed yet)
syndee:
  nameserver: digital_ocean
  base_fqdn: hpk.io
  #secret_password: {# pillar['secrets:syndee_password'] #}


# Use Chippery to manage and configure projects across syndicated machines
chippery:

  # Enable minion-targetting via 'chippery:enabled:True' (when you also
  # pass it a '- match: pillar' option) in the Top states file.
  enabled: True

  # Global settings, applied to the minion and all syndicated machines
  settings:

    # Set the default UMASK for users in /etc/login.defs
    #default_umask: '002'

    # Base directory for projects described in chippery.projects
    project_path: /opt
    # The group to be set, by default, across project files
    project_group: hipikat
    # Base directory for Python virtual environments
    virtualenv_path: /opt/.virtualenvs
    # Web server (Nginx) state. One of 'enabled' (default), 'disabled' or 'ignore'
    web_server: enabled

  #stacks:
  #  - wsgi_dev

  projects:
    # Kenneth Reitz's request and response service
    # https://github.com/kennethreitz/httpbin
    httpbin:
      python_version: 3.4.1
      python_packages:
        - httpbin
      wsgi_module: httpbin.app
      virtual_hosts:
        - httpbin.hpk.io:
            locations:
              - '/':
                pass_upstream: true
      # WSGI app state - 'running'/True (default), 'dead'/False or 'ignore'
      #wsgi_state: running
      # Nginx site configuration - 'enabled'/True (default), 'disabled'/False or 'ignore'
      #site_state: enabled
