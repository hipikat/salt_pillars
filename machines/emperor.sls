#
# Machine-specific pillars for my highest-level master

{% from 'secrets.sls' import digitalocean_key %}


# Use Saltlick to synchronise one Salt configuration across my masters
saltlick:
  salt_group: hipikat
  salt_roots: https://github.com/hipikat/salt-roots.git
  salt_pillars: https://github.com/hipikat/salt-pillars.git
  salt_formulas:
    users: https://github.com/saltstack-formulas/users-formula.git
    saltlick: https://github.com/hipikat/saltlick-formula.git
    chippery: https://github.com/hipikat/chippery-formula.git
  salt_cloud:
    master_address: salt-master.hpk.io
    client_key: {{ digitalocean_key('client') }}
    api_key: {{ digitalocean_key('api') }}


# Use Chippery to manage and configure projects across syndicated machines
chippery:

  # Enable minion-targetting via 'chippery:enabled:True' (when you also
  # pass it a '- match: pillar' option) in the Top states file.
  enabled: True

  # Global settings, applied to the minion and all syndicated machines
  settings:
    # Set the default UMASK for users in /etc/login.defs
    default_umask: '002'
    virtualenv_path: /opt/.virtualenvs
    project_path: /opt
    # The group to be set on project files
    project_group: hipikat


  # Set up salt-syndic machines based on maps defined in the pillar
  syndicate:
    # Create gabby-front 
    gabby: map/frontend

    # Create pups-web1, pups-web2, pups-db
    pups: map/layer4backend

    # Create dogs-web[1-6], dogs-db, with overrides
    #dogs:
    #  map: map/layer4backend
    #  vm.db.profile: droplet2G
    #  vm.web.profile: droplet1G
    #  vm.web.count: 6

    # Create dev-fullstack
    dev: map/fullstack

    #varnish:
    #  # One of running, disabled or manual. (Default: running)
    #  status: running

    # Nginx will listen on port 80 if Varnish is disabled, or 8080 if
    # Varnish is running or being managed manually.
    #nginx:
    #  # Set managed to True (default) to have Chippery control nginx.conf
    #  managed: True
    #  # One of running, disabled or manual. Default: running
    #  status: running
    #  # Set reload to True to reload configuration instead of restarting,
    #  # when triggered by configuration changes. (Default: False)
    #  reload: True

  # Set the minion up as a WSGI development environment
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
    hipikat_dev:
      {{ hipikat_org({
          'fqdn': 'home-dev.hpk.io',
          'cloud': {
              '_self': [
                'roles': [
                  'varnish',
                  'nginx',
                  'postgres',
                  'app',
                ]
              ] 
           }
        }
      }) }}

    hipikat_prod:
      {{ hipikat_org({
          'fqdn': 'home-dev.hpk.io',
      }) }}
      local: False
      cloud_prefix:
      cloud:
        _self:
          roles:
            - varnish
        web:
          count: 2
          roles:
            - nginx
            - app_server
        db: 
          roles:
            - database


# Act as a DynDNS-like master-server (or something?!)
#domydns:
#  base_fqdn: hpk.io
