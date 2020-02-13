
{# from "settings.jinja" import settings #}

salt:
  # Suppress warning about md5 hashing
  # (The defaults should just work in a future version of Salt.)
  hash_type: sha256

  # Set this to False to not have the formula install packages (in the case you
  # install Salt via git/pip/etc.)
  install_packages: True

  # Salt master config
  master:
    log_level: warning
    worker_threads: 4
    timeout: 30
    # Allow master config data in pillars
    # (Do NOT store sensitive information in the master config!)
    pillar_opts: True

  # Salt minion config:
  minion:
    log_level: debug
   #master: 127.0.0.1
    mine_interval: 2
    timeout: 30

salt_formulas:
  git_opts:
    # The Git options can be customized differently for each
    # environment, if an option is missing in a given environment, the
    # value from "default" is used instead.
    default:
      # URL where the formulas git repositories are downloaded from
      # it will be suffixed with <formula-name>.git
      #baseurl: "https://github.com/hipikat"
      #baseurl: git@github.com:hipikat
      baseurl: https://github.com/saltstack-formulas/

      # Directory where Git repositories are downloaded
      basedir: /srv/formulas
      # Update the git repository to the latest version (False by default)
      update: False
      # Options passed directly to the git.latest state
      options:
        rev: master
        remote: github
        #identity: /root/.ssh/salt-master-deploy

  # List of formulas to enable in each environment
  list:
    base:
      - salt-formula
      - system-formula

      - users-formula
      - homeboy-formula

      - nginx-formula
      - php-formula

  # Options of the file.directory state that creates the directory where
  # the git repositories of the formulas are stored
  basedir_opts:
    makedirs: True
    user: root
    group: root
    mode: 755
