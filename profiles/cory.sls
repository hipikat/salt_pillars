#
# A 1G development box
####################################################


{% from 'projects/hipikat_org.sls' import hipikat_org %}
{% from 'projects/principal_dates.sls' import principal_dates %}


# Use Chippery to manage and configure projects
chippery:
  enabled: True

  # Global settings, applied to the minion and all syndicated machines
  settings:
    # Set the default UMASK for users in /etc/login.defs
    default_umask: '002'
    # The group to be set, by default, across project files
    project_file_mode: 755
    project_user: weboffice
    project_group: weboffice

  # Make this a pleasant environment
  stacks:
    - wsgi_dev

  projects:

    # UWA Principal Dates (development)
    principal_dates:
      deployment_user: hipikat
      deployment_group: weboffice
      {{ principal_dates(**{
        'deploy_minion': 'cory',
        'fqdn': 'dates.' ~ grains['id'] ~ '.hpk.io',
      })|indent(4) }}

    # Adam Wright's personal home site (development)
    hipikat_old:
      {{ hipikat_org(**{
          'fqdn': 'hipi-dev.cory.hpk.io',
          'rev': 'restart',
          'settings': 'Development',
          'http_basic_auth': True,
          'auto-reload': True,
      })|indent(4) }}
      #destinations:
      #  - dev_box
