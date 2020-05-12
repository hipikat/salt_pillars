

# PHP setup
php:
  use_external_repo: true
  external_repo_name: 'ondrej/php'
  version: "7.3"

  modules:
    - cli
    - fpm
    - curl
    - mysql
    - zip

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
            extension_dir: '/usr/lib/php/modules/'
            extension: [pdo_mysql.so, iconv.so, openssl.so, curl.so, ssh2.so]
            short_open_tag: 'On'
            post_max_size: 128M
            upload_max_filesize: 128M
            memory_limit: 512M
      conf:
        opts:
          recurse: true
        settings:
          global:
            pid: /run/php/php7.3-fpm.pid
            log_level: debug

    service:
      enabled: true
      opts:
        reload: true
      pools:
        defaults:
          user: www-data
          group: www-data
          listen: /var/run/php/php7.3-fpm.sock
