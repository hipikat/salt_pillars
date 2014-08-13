
map/frontend:
  front:
    profile: droplet512M
    grains:
      chippery/roles:
        - vagrant

map/layer4backend:
  web:
    profile: droplet512M
    count: 2
    grains:
      chippery/roles:
        - nginx
        - app
  db:
    profile: droplet512M
    grains:
      chippery/roles:
        - nginx
        - app
