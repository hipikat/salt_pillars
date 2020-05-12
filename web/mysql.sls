

# Database configuration
mysql:
  global:
    client-server:
      default_character_set: utf8

  clients:
    mysql:
      default_character_set: utf8
    mysqldump:
      default_character_set: utf8

  library:
    client:
      default_character_set: utf8

  server:
    root_user: root
    #root_password: [secrets.sls]
    user: mysql
    # my.cnf sections changes
    mysqld:
      bind-address: 127.0.0.1
      log_bin: /var/log/mysql/mysql-bin.log
      datadir: /var/lib/mysql
      port: 3307
      binlog-ignore-db:
        - mysql
        - sys
        - information_schema
        - performance_schema
    mysql:
      no-auto-rehash: noarg_present

  salt_user:
    salt_user_name: 'salt'
    #salt_user_password: [secrets.sls]
    grants:
      - 'all privileges'

  database:
    - phpmyadmin

  user:
    phpmyadmin:
      #password: [secrets.sls]
      host: localhost
      databases:
        - database: phpmyadmin
          grants: ['all privileges']

