

#include:
#  - letsencrypt


#system:
#  packages:
#    python-certbot-nginx: True


# Web server configuration
nginx:
  install_from_ppa: true
  ppa_version: 'stable'

  service:
    enable: true

  config:
    worker_processes: 4
    events:
      worker_connections: 1024
    http:
      disable_symlinks: 'off'
      sendfile: 'on'
      tcp_nopush: 'on'
      tcp_nodelay: 'on'
      keepalive_timeout: 65
      include:
        - /etc/nginx/mime.types

  server:
    config:
      http:
        default_type: "text/plain"

  servers:
    managed:
      default:
        enabled: false
      web_root:
        enabled: true
        overwrite: true
        config:
          - server:
              #- server_name: localhost
              - listen:
                  - '80'
                  - '443 ssl'
              - root: '/var/www/html/'
              - index: 'index.html index.htm'
              - location ~ .htm:
                  - try_files: '$uri $uri/ =404'
                  - autoindex: "on"
              #- 'location ~* \.php$':
              #    - fastcgi_pass: "unix:/var/run/php/php7.3-fpm.sock"
              #    - include: "fastcgi_params"
              #    - fastcgi_param: "SCRIPT_FILENAME    $document_root$fastcgi_script_name"
              #    - fastcgi_param: "SCRIPT_NAME        $fastcgi_script_name"

  #certificates_path: '/etc/nginx/ssl'



