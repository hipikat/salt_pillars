
{%- from "secrets.sls" import domain_name %}


wordpress:
  sites:
    sitename:
      username: hipikat
      #password: <your-wordpress-user-password>
      database: hpk_wordpress
      dbuser: hipikat
      #dbpass: <your-wordpress-db-password>
      url: 'https://{{ domain_name }}'
      title: 'Ada Wright - Home'
      email: 'ada@hpk.io'
      #plugins:
      #  - '<plugin-name>'
      #plugins_url:
      #  '<plugin-name>':
      #    url: '<url-to-obtain-plugin-zipfile>'
      #    name: '<plugin-name>'
  

nginx:
  servers:
    managed:
      hipikat:
        enabled: true
        overwrite: true
        config:
          - server:
              - server_name: "www.{{ domain_name }}"
              - listen:
                  - '80'
              - rewrite: "^/(.*)$ https://{{ domain_name }}/$1 permanent"
          - server:
              - server_name: {{ domain_name }}
              - listen:
                  - '80 default_server'
              - rewrite: "^/(.*)$ https://{{ domain_name }}/$1 permanent"
          - server:
              - server_name: {{ domain_name }}
              - listen:
                  - '443 ssl'
              - include: '/etc/letsencrypt/options-ssl-nginx.conf'
              - ssl_certificate: "/etc/letsencrypt/live/{{ domain_name }}/fullchain.pem"
              - ssl_certificate_key: "/etc/letsencrypt/live/{{ domain_name }}/privkey.pem"
              - ssl_dhparam: "/etc/letsencrypt/ssl-dhparams.pem"
              - client_max_body_size: 128m
              - root: '/var/www/html/'
              - index: 'index.html index.htm'
              - location ~ .htm:
                  - try_files: '$uri $uri/ =404'
                  - autoindex: "on"
          - server:
              - server_name: "www.{{ domain_name }}"
              - listen:
                  - '443 ssl'
              - include: "/etc/letsencrypt/options-ssl-nginx.conf"
              - ssl_certificate: "/etc/letsencrypt/live/{{ domain_name }}/fullchain.pem"
              - ssl_certificate_key: "/etc/letsencrypt/live/{{ domain_name }}/privkey.pem"
              - ssl_dhparam: "/etc/letsencrypt/ssl-dhparams.pem"
              - rewrite: "^/(.*)$ https://{{ domain_name }}/$1 permanent"
