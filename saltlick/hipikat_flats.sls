

saltlick:

  # Group identifier for Salt and its components
  salt_group: hipikat

  # Salt roots and pillars
  salt_roots:
    url: git@github.com:hipikat/salt-roots.git
    deploy_key: hipikat-github

  salt_pillars:
    url: git@github.com:hipikat/salt-pillars.git
    deploy_key: hipikat-github

  salt_formulas:

    # SaltStack-blessed formulas
    users: https://github.com/saltstack-formulas/users-formula.git

    # Hipikat's Salt formulas on GitHub
  {% for formula in ('chippery', 'git-server', 'homeboy', 'saltlick', 'shoaler', 'system') %}
    {{ formula }}:
      url: git@github.com:hipikat/{{ formula }}-formula.git
      deploy_key: hipikat-github
      #remote_name: github
  {% endfor %}

