
map/fullstack:
  full: 
    profile: droplet512M
    grains:
      chippery/roles:
        - varnish
        - nginx
        - app
        - postgres

map/fullback:
  back:
    profile: droplet512M
    grains:
      chippery/roles:
        - nginx
        - app
        - postgres
