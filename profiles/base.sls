#
# Base system profile


include:
  # Install Salt in a Virtualenv at /opt/salt, let Supervisord manage it
  - saltlick.venv_salt_install


# Shared settings
settings:
  # system.system_timezone
  system_timezone: 'Australia/Perth'

  # Set by saltlick.supervisor, used by programs installing themselves in Supervisor
  supervisor_conf_dir: /etc/supervisor/programs-enabled


# Define states responsible for programs (etc.)
controllers:
  supervisor: saltlick.supervisor
