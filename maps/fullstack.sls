
map/fullstack:
  full: 
    profile: droplet512M
    grains:
      chippery/roles:
        - varnish
        - nginx
        - app
        - postgres
