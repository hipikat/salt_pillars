
shoaler:
  formations:
    scaling_apps:
      front: 
        profile: droplet512M
        grains:
          chippery/roles:
            - varnish
      web: 
        profile: droplet512M
        autoscale_min: 2
        autoscale_max: 8
        grains:
          chippery/roles:
            - nginx
            - app
            - static
      db:
        profile: droplet512M
        grains:
          chippery/roles:
            - db

    full_stack:
      fullstack:
        profile: droplet512M
        grains:
          chippery/roles:
            - varnish
            - nginx
            - app
            - static
            - db

