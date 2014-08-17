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
    # Base directory for projects described in chippery.projects
    project_path: /opt
    # The group to be set, by default, across project files
    project_group: hipikat
    # Base directory for Python virtual environments
    virtualenv_path: /opt/.virtualenvs


  # Set up salt-syndic machines based on maps defined in the pillar
  syndicates:
    # Front-end proxy/cache server in Singapore 
    gabby: map/frontend

    # Main production map
    # Create (pups|dogs)-web(1|2) and (pups|dogs)-db
    dog: map/layer4backend

    # High-scale production map
    # Create dogs-web[1-6], dogs-db, with overrides
    wolf:
      map: map/layer4backend
      vm.db.profile: droplet2G
      vm.web.profile: droplet1G
      vm.web.count: 6

    # Staging setup
    pup:
      map: map/layer4backend

    # Create hipi-dev-fullstack
    hipi-dev:
      map: map/fullstack
      stacks: wsgi_dev

    # US production mirror
    yankee: map/frontend
    mule: map/layer4backend

  # If 'formations' isn't defined, all syndicates are created under a
  # single formation named 'formation'. Otherwise, only create syndicate
  # groups that appear in a formation.
  formations:
    # Full-scale production, staging and suddenly-very-horizontally-scaled
    # deployments in Singapore
    sng_production: 
      - gabby
      - dog
      - wolf: absent
    sng_staging:
      - gabby
      - pup: manual
    # Full-scale production mirror in the US
    us_production:
      - yankee: manual
      - mule: manual
    # Full-stack, single-box dev machine in Singapore
    dev_box:
      - dev

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
      destinations:
        - sng_production
        - us_production
 
    hipikat_staging:
      {{ hipikat_org(**{
          'fqdn': 'hipikat-staging.hpk.io',
      })|indent(4) }}
      destinations:
        - sng_staging

    hipikat_dev:
      {{ hipikat_org(**{
          'fqdn': 'hipi-dev-fullstack.hpk.io',
          'source/rev': 'dev',
          'settings': 'Development',
          'http_basic_auth': True,
          'auto-reload': True,
      })|indent(4) }}
      destinations:
        - dev_box
 

# Act as a DynDNS-like master-server (or something?!)
syndee:
  nameserver: digital_ocean
  base_fqdn: hpk.io

