# -*- coding: utf-8 -*-
# vim: ft=yaml

system:
  directories:
    /var/lib/letsencrypt/.well-known: True
    /var/lib/letsencrypt:
      group: www-data
      dir_mode:


letsencrypt:
  config: |
    server = https://acme-v01.api.letsencrypt.org/directory
    email = letsencrypt@hpk.io
    authenticator = webroot
    webroot-path = /var/lib/letsencrypt
    agree-tos = True
    renew-by-default = True
  config_dir:
    path: /etc/letsencrypt
    user: root
    group: root
    mode: 755
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
