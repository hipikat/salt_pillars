
{% from "secrets.sls" import services %}


# TODO: manage your pillar (and roots??) directories here?
# AND ensure secrets.sls isn't readable by the public user.


system:
  git_latest:
    salt_roots:
      name: git@github.com:hipikat/salt_roots.git
      target: /srv/salt
      user: root
      #identity: /etc/salt/deploy_keys/hipikat-githubrsa
    salt_pillars:
      # ...

  managed_files:
    salt_pillar_secrets:
      name: /srv/pillar/secrets.sls
      mode: 660



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
    log_level: warning
    master: salt
    mine_interval: 2
    timeout: 30
    {% if 'wordpress' in services %}
    grains:
      services:
        wordpress: {{ services.wordpress }}
    {% endif %}

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
      baseurl: https://github.com/hipikat

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

      - vsftpd-formula
      - nginx-formula
      - php-formula
      - mysql-formula
      - openssh-formula
      - letsencrypt-formula
      - ufw-formula

      - wordpress-formula

  # Options of the file.directory state that creates the directory where
  # the git repositories of the formulas are stored
  basedir_opts:
    makedirs: True
    user: root
    group: root
    mode: 755


# salt.formulas doesn't symlink custom execution modules and states for us,
# so we have our own 'system' formula do it for us
system:
  symlinks:
    /srv/salt/_modules/ufw.py: /srv/formulas/ufw-formula/_modules/ufw.py
    /srv/salt/_states/ufw.py: /srv/formulas/ufw-formula/_states/ufw.py

