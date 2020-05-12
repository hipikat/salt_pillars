

system:
  packages:
    phpmyadmin: True
    certbot: True


include:
  - web.letsencrypt
  - web.nginx
  - web.mysql
  - web.php

