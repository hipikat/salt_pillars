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

    # SaltStack-blessed formulas
    users: https://github.com/saltstack-formulas/users-formula.git

    # Hipikat's formulas on GitHub
  {% for formula in ('chippery', 'git-server', 'homeboy', 'saltlick', 'shoaler') %}
    {{ formula }}:
      url: git@github.com:hipikat/{{ formula }}-formula.git
      deploy_key: salt://deploy_keys/github/{{ formula }}-formula
      remote_name: github
  {% endfor %}

  salt_cloud:
    master_address: salt-master.hpk.io
    client_key: {{ digitalocean_key('client') }}
    api_key: {{ digitalocean_key('api') }}


system_packages:
  - git
  - zangband:
      hold: True


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

    # Front-end proxy-cache/load-balancers for two or more sites
    hipikat-front:
      profile: droplet512M
      grains:
        chippery/roles:
          - varnish
          - redis

    private-front:
      profile: droplet512M
      grains:
        chippery/roles:
          - varnish
          - redis

    # Scaling, stateless layer of apps, for all servers
    apps-prod:
      status: disabled        # disabled
      profile: droplet512M
      autoscale_min: 2
      autoscale_max: 8
      grains:
        chippery/roles:
          - nginx
          - apps
          - static
          - media

    apps-stage:
      profile: droplet512M
      count: 2
      grains:
        chippery/roles:
          - nginx
          - apps
          - static
          - media
   
    # One minion just hosting databases for all sites
    databases-prod:
      status: disabled        # disabled
      profile: droplet1G
      grains:
        chippery/roles:
          - databases

    databases-stage:
      profile: droplet512M
      grains:
        chippery/roles:
          - databases



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
    # Web server (Nginx) state. One of 'enabled' (default), 'disabled' or 'ignore'
    web_server: enabled

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
      # WSGI app state - 'running'/True (default), 'dead'/False or 'ignore'
      #wsgi_state: running
      # Nginx site configuration - 'enabled'/True (default), 'disabled'/False or 'ignore'
      #site_state: enabled


    # Adam Wright's personal home-site
    #hipikat_prod:
    #  {# hipikat_org()|indent(4) #}
    #  destinations:
    #    - sng_production
    #    - us_production
 
    #hipikat_staging:
    #  {# hipikat_org(**{
    #      'fqdn': 'hipi-staging.hpk.io',
    #      'rev': 'stage',
    #  })|indent(4) #}
    #  #destinations:
    #  #  - sng_staging

    #hipikat_dev:
    #  {# hipikat_org(**{
    #      'fqdn': 'hipi-dev.hpk.io',
    #      'rev': 'develop',
    #      'settings': 'Development',
    #      'http_basic_auth': True,
    #      'auto-reload': True,
    #  })|indent(4) #}
    #  #destinations:
    #  #  - dev_box