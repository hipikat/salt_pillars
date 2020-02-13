

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

  servers:
    managed:
      default:
        enabled: false
      web_root:
        enabled: true
        overwrite: true
        config:
          - server:
              - server_name: localhost
              - listen:
                  - '80 default_server'
                  #- '443 ssl'
              - root: '/var/www/html/'
              - index: 'index.php index.html index.htm'
              - location ~ .htm:
                  - try_files: '$uri $uri/ =404'
                  - autoindex: "on"
              - 'location ~* \.php$':
                  - fastcgi_pass: "unix:/var/run/php/php7.0-fpm.sock"
                  - include: "fastcgi_params"
                  - fastcgi_param: "SCRIPT_FILENAME    $document_root$fastcgi_script_name"
                  - fastcgi_param: "SCRIPT_NAME        $fastcgi_script_name"

  #certificates_path: '/etc/nginx/ssl'

php:
  use_external_repo: true
  external_repo_name: 'ondrej/php'

  modules:
    - cli
    - fpm
    - curl
    - mysql

  cli:
    ini:
      opts:
        recurse: true
      settings:
        PHP:
          short_open_tag: 'On'

  fpm:
    config:
      ini:
        opts:
          recurse: true
        settings:
          PHP:
            engine: 'On'
            #extension_dir: '/usr/lib/php/modules/'
            #extension: [pdo_mysql.so, iconv.so, openssl.so]
            short_open_tag: 'On'
      conf:
        opts:
          recurse: true
        settings:
          global:
            pid: /run/php/php7.0-fpm.pid

    service:
      enabled: true
      opts:
        reload: true
      pools:
        defaults:
          user: www-data
          group: www-data
          listen: /var/run/php/php7.0-fpm.sock
