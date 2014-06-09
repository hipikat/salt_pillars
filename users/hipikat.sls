#
# System administrators.
##########################################

{% from 'secrets.sls' import htpasswd %}

{% set machine_users = grains.get('users', []) %}

users:
  {% if not machine_users or 'hipikat' in machine_users %}
    hipikat:
      fullname: Adam Wright
      email: adam@hipikat.org
      sudouser: True
      sudo_rules:
        - 'ALL=(ALL) NOPASSWD: ALL'
      groups:
        - root
        - www-data
      shell: /bin/bash
      dotfiles:
        git_url: https://github.com/hipikat/dotfiles.git
        install_cmd: 'python plumb_files.py -U -f'
      uses_sys_packages:
        - exuberant-ctags
        - mosh
        - screen
      uses_py_packages:
        - flake8
      ssh_auth:
        - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDKyCuPu+CjJ8z/Xiy8p57JxtbHwCvZe/KPKjkoLauObR9S{# -#}
H1WLwbkgT8nOtYQskuIwcoHERp7GkSjCcI1qGYyILRYPIKmwC2mXyCFtb47PejAS8AhnT9XJ7luPuOL0En7X3las3LfZ{# -#}
XjwwBjU1Hr9ZDZMImcki4rUpPcjKhgvsHI/eALO0FcV/4BCYrBKTTl1S8V1nolMb+D4VCpr/a43akqARtr04QKZCQZq/{# -#}
7/q8Dts8f4TaR/YxXEK2n4TZsWdnsxkmGyQwdS0i9qUlyxdXSGLYW9vn+aceOgaYA5RiU/CO2wVm7SCungHjCBgPOQhr{# -#}
bBj6RYWBv3Od1yYsRHad zeno@trepp
  {% endif %}

  {% if 'weboffice' in machine_users %}
    weboffice:
      fullname: University Website Office
      sudouser: False
  {% endif %}
