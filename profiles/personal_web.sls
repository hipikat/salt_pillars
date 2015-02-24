#
# Pillar applied to all machines in my production web formation
########################################################################


{% from 'projects/hipikat_org.sls' import hipikat_org %}


# Use Chippery to manage and configure projects
chippery:
  enabled: True

  # Global settings, applied to the minion and all syndicated machines
  settings:
    project_user: hipikat
    project_group: www-data

  # Make this a pleasant environment
  stacks:
    - wsgi_dev

  projects:

    # Adam Wright's personal home site (development)
    hipikat:
      {{ hipikat_org()|indent(4) }}
