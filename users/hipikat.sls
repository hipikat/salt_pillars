#
# User pillar for Adam 'hipikat' Wright
########################################

users:
  hipikat:

    # Used by the (SaltStack-blessed) Users formula
    fullname: Ada Wright
    groups:
      - wheel
    email: ada@hipikat.org
    shell: /bin/bash
    sudouser: True
    sudo_rules:
      - 'ALL=(ALL) NOPASSWD: ALL'
    ssh_auth:
      - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDKyCuPu+CjJ8z/Xiy8p57JxtbHwCvZe/KPKjkoLauObR9S{# -#}
  H1WLwbkgT8nOtYQskuIwcoHERp7GkSjCcI1qGYyILRYPIKmwC2mXyCFtb47PejAS8AhnT9XJ7luPuOL0En7X3las3LfZ{# -#}
  XjwwBjU1Hr9ZDZMImcki4rUpPcjKhgvsHI/eALO0FcV/4BCYrBKTTl1S8V1nolMb+D4VCpr/a43akqARtr04QKZCQZq/{# -#}
  7/q8Dts8f4TaR/YxXEK2n4TZsWdnsxkmGyQwdS0i9qUlyxdXSGLYW9vn+aceOgaYA5RiU/CO2wVm7SCungHjCBgPOQhr{# -#}
  bBj6RYWBv3Od1yYsRHad zeno@trepp
      - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDdN2knnuLR2UgJWXqXeQ6wn01AGbAoTzbf5pholx0qSQnm4C{# -#}
  fVc2vDfA8SdlNveNVvq6Z/frymohQPffaqxv/v+LtMxaU3hQRx8znaI+JaLu5VYV6IUwDVPVEddXTx02MlYiW4wzTbq0{# -#}
  bT84cAiix5zpvTY2ZNdzboQSTxLjoXqczeDXJ5fmzpEs0lJUBwXxZ6YcbuQ3vxQD8RNxHzgRGGplIrWpiktypgp7yUpr{# -#}
  XCpV87p2+JhnRrp5iJRD1JuJpgjwgQfmEZJtyM1eI4ln8EIarjhAveNhG4G+Zz32wspC72TcDy0n1Ms/Lp0bKDFm639t{# -#}
  LPymQRjkMH3yIypaKx hipikat@bellus
      - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDQOCW/I2y+rGJQb+Fr2FwO9Xh6AAcJUD4ObtNbk6BjUpYo3T{# -#}
  mBNStn7/JXt7xAz3X3FZBLcch4SLsGh+Nd2LzyVxfBgUVSGHnBYyconhChfY2RZP9AP1WvOUCjLzeL4/w5BKKDy6F8AV{# -#}
  bre+kudpJXoOjSVQbz+D513Ddt8RukXp2OR5UGNDhNFh5G43OXihnm6/1sYHyuOKe9z7I/83DggqiGL9iK5wIM2p87Bo{# -#}
  wH8QQCFphKSB0SBezJb9TZffuLZHeFjoKiqrrpmB78T6Wn+ovPREzdAz1+2C5TzBv3b2815uwWmaly68eN7DZyBrBCsN{# -#}
  Ri9dzG+NVL7bVdVvUcghwLds2Ne05nA156GcdLPwAhVUK9tVkI/7Kd6AFlxPdg9e0ghON+uR+AmTGmOJsanQ7E4UmbT9{# -#}
  By379yPmuqZbTxs1G62yGVd8LnthRaDwHtENqaIA4c9M4VLbnNMZ+QjJzr5dERt96+kfIyPq0443R68jtiIviZ1xQNuI{# -#}
  Y32JkeYsIIck/QIZQLHlrWNhk48rs5aVbhIrpgdVdsi8K9365MZ5c9/K6WaY6hWFAhqGat/xiGTrOnGtc39cpA3H/zbL{# -#}
  Dh8IYDdxe+n5W+QEto6Ey9BXBt8KQ/iu9pGvWW1mJmW25c6haL7KGuTCST312lqUWmqX0OakuY60e8Ham5cQ== hipikat@metis

    # Used by the Homeboy formula
    dotfiles:
      url: https://github.com/hipikat/dotfiles.git
      install_cmd: 'install_dotfiles.sh'
      dir: .dotfiles
      #deploy_key: /etc/saltlick/deploy_keys/hipikat-github

    #crontabs:
    #  - '@reboot USER=hipikat SHELL=/bin/bash HOME=/home/hipikat PWD=/home/hipikat sleep 5 && cd /home/hipikat && /home/hipikat/.bin/screen-launch irc-etc'

    needs_system_packages:
      - curl
      - exuberant-ctags
      - git
      - jq
      - mosh
      - screen
      - tree
      - vim

    needs_home_packages:
      - pyenv
      - nvm

    #uses_python_packages:
    #  - fabric
    #  - flake8
    #  - httpie
    #  - pep8
