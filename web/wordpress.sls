
include:
  - web.letsencrypt
  - web.nginx
  - web.mysql
  - web.php


wordpress:
  cli:
    source: https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    hash:  https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar.sha512
    allowroot: False
