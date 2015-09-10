#
# Pillar applied to all machines in my production web formation
########################################################################


{% from 'projects/hipikat_org.sls' import hipikat_org %}


include:
  - projects.tweepost



# Use Chippery to manage and configure projects
chippery:
  #enabled: True    # Just check for a 'deployments' dictionary

  # Global settings, applied to the minion and all syndicated machines
  settings:
    project_user: hipikat
    project_group: www-data

  # Make this a pleasant environment
  #stacks:
  #  - wsgi_dev

  varnish:
    port: 80

    backends:
      - url_re: ^/tweep/
        backend: tweepost
      - url_re: ^/_static/
        backend: hipikat_static
      - url_re: ^/_media/
        backend: hipikat_media

      - backend: hipikat_org
      
  nginx:
    port: 8080
    backend_name: local_web


  deployments:

    tweepost:
      project: tweepost

    hipikat_org:


    # Adam Wright's personal home site (development)
    hipikat:
      {{ hipikat_org()|indent(4) }}
