# -*- coding: utf-8 -*-
# vim: ft=yaml

{%- from "secrets.sls" import domain_name %}

system:
  package_repositories:
    Debian Let's Encrypt Team's certbot PPA:
      ppa: certbot/certbot

  directories:
    /var/lib/letsencrypt/.well-known: True
    /var/lib/letsencrypt:
      group: www-data
      dir_mode:


letsencrypt:

  use_package: True
  pkgs:
    - certbot
    - python3-certbot-nginx

  config: |
    email = letsencrypt@hpk.io
    authenticator = nginx
    webroot-path = /var/lib/letsencrypt
    agree-tos = True
    renew-by-default = True

  domainsets:
    www:
      - {{ domain_name }}
      - www.{{ domain_name }}

  #config_dir:
  #  path: /etc/letsencrypt
  #  user: root
  #  group: root
  #  mode: 755

  #domainsets:
  #  www:
  #    - domain_name.tld
  #    - www.domain_name.tld

  # The post_renew cmds are executed via renew_letsencrypt_cert.sh after every
  # run. For more fine grain control, consider placing scripts in the pre,
  # post, and/or deploy directories within /etc/letsencrypt/renewal-hooks/. For
  # more information, see: https://certbot.eff.org/docs/using.html#renewal
  post_renew:
    cmds:
      - service nginx reload
      - service haproxy reload
  cron:
    minute: 10
    hour: 2
    dayweek: 1
