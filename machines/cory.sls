#
# Machine-specific pillars for my highest-level master

{% from 'projects/principal_dates.sls' import principal_dates %}


# Use Chippery to manage and configure projects
chippery:
  enabled: True

  # Global settings, applied to the minion and all syndicated machines
  settings:
    # Set the default UMASK for users in /etc/login.defs
    default_umask: '002'
    # The group to be set, by default, across project files
    project_user: weboffice
    project_group: weboffice

  # Make this a pleasant environment
  stacks:
    - wsgi_dev

  projects:

    # Adam Wright's personal home-site
    principal_dates:
      {{ principal_dates(**{
        'fqdn': 'dates.' ~ grains['id'] ~ '.hpk.io',
      })|indent(4) }}
