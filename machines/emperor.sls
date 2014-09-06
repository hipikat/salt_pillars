#
# Machine-specific pillars for my highest-level master

{% from 'projects/hipikat_org.sls' import hipikat_org %}
{% from 'secrets.sls' import digitalocean_key %}


# Use Saltlick to synchronise one Salt configuration across my masters
saltlick:
  salt_group: hipikat
  salt_roots: https://github.com/hipikat/salt-roots.git
  salt_pillars: https://github.com/hipikat/salt-pillars.git
  salt_formulas:
    chippery: https://github.com/hipikat/chippery-formula.git
    git-server: https://github.com/hipikat/gitserver-formula.git
    homeboy: https://github.com/hipikat/homeboy-formula.git
    users: https://github.com/saltstack-formulas/users-formula.git
    saltlick: https://github.com/hipikat/saltlick-formula.git
  salt_cloud:
    master_address: salt-master.hpk.io
    client_key: {{ digitalocean_key('client') }}
    api_key: {{ digitalocean_key('api') }}


system_packages:
  - zangband


# Simple, shared, ssh-based git server via formula
git-server:
  authorized_users:
    - hipikat


# Act as a DynDNS-like master-server (or something?!)
# (not programmed yet)
#syndee:
#  nameserver: digital_ocean
#  base_fqdn: hpk.io
#  secret_password: {# pillar['secrets:syndee_password'] #}


# Cloud orchestration
shoaler:
  settings:
    autoscale:
      upsize_cpu_threshold: 60
      upsize_cpu_wait: 15
      downsize_cpu_threshold: 20
      downsize_cpu_wait: 120

  deployments:
    sng-home-prod:
      formation: scaling_apps
      status: deployed

    us-home-prod:
      formation: scaling_apps
      extend:
        front:profile: droplet512M-ny2
        web:profile: droplet512M-ny2
        db:profile: droplet512M-ny2
        db:grains:chippery/roles:
          - db-replica
      status: disabled

    sng-staging:
      formation: scaling_apps
      status: disabled

    dev:
      formation: full_stack
      status: disabled


# Use Chippery to manage and configure projects across syndicated machines
chippery:

  # Enable minion-targetting via 'chippery:enabled:True' (when you also
  # pass it a '- match: pillar' option) in the Top states file.
  enabled: True

  # Global settings, applied to the minion and all syndicated machines
  settings:
    # Set the default UMASK for users in /etc/login.defs
    default_umask: '002'
    # Base directory for projects described in chippery.projects
    project_path: /opt
    # The group to be set, by default, across project files
    project_group: hipikat
    # Base directory for Python virtual environments
    virtualenv_path: /opt/.virtualenvs

  stacks:
    - wsgi_dev

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

    # Adam Wright's personal home-site
    hipikat_prod:
      {{ hipikat_org()|indent(4) }}
      #destinations:
      #  - sng_production
      #  - us_production
 
    hipikat_staging:
      {{ hipikat_org(**{
          'fqdn': 'hipi-staging.hpk.io',
          'rev': 'stage',
      })|indent(4) }}
      #destinations:
      #  - sng_staging

    hipikat_dev:
      {{ hipikat_org(**{
          'fqdn': 'hipi-dev.hpk.io',
          'rev': 'develop',
          'settings': 'Development',
          'http_basic_auth': True,
          'auto-reload': True,
      })|indent(4) }}
      #destinations:
      #  - dev_box
