
{%- from "secrets.sls" import domain_name %}

users:
  exalted:
    email: exalted@hpk.io
    #ssh_auth: [secrets.sls]
    dotfiles:
      url: https://github.com/hipikat/dotfiles.git
      install_cmd: './plumb_files.py --current-user --force'

mysql:
  database:
    - exalted
  user:
    exalted:
      #password: [secrets.sls]
      host: localhost
      databases:
        - database: exalted
          grants: ['all privileges']


php:
  modules:
    - xml
    - mbstring
    - imagick
    - zip


nginx:
  servers:
    managed:
      exalted:
        enabled: true
        overwrite: true
        config:
          - server:
              - server_name: {{ domain_name }}
              - listen:
                  - '80'
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
              - root: '/home/exalted/wordpress/'
              - index: 'index.php index.html index.htm'
              - location ~ .htm:
                  - try_files: '$uri $uri/ =404'
                  - autoindex: "on"
              - 'location ~* \.php$':
                  - fastcgi_pass: "unix:/var/run/php/php7.3-fpm.sock"
                  - include: "fastcgi_params"
                  - fastcgi_param: "SCRIPT_FILENAME    $document_root$fastcgi_script_name"
                  - fastcgi_param: "SCRIPT_NAME        $fastcgi_script_name"
          - server:
              - server_name: "www.{{ domain_name }}"
              - listen:
                  - '443 ssl'
              - include: "/etc/letsencrypt/options-ssl-nginx.conf"
              - ssl_certificate: "/etc/letsencrypt/live/{{ domain_name }}/fullchain.pem"
              - ssl_certificate_key: "/etc/letsencrypt/live/{{ domain_name }}/privkey.pem"
              - ssl_dhparam: "/etc/letsencrypt/ssl-dhparams.pem"
              - rewrite: "^/(.*)$ https://{{ domain_name }}/$1 permanent"
