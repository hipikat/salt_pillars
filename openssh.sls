
sshd_config:
  PermitRootLogin: 'yes'
  PasswordAuthentication: 'yes'
  ChallengeResponseAuthentication: 'no'
  UsePAM: 'yes'
  X11Forwarding: 'yes'
  PrintMotd: 'yes'
  AcceptEnv: "LANG LC_*"
  Subsystem: "sftp /usr/lib/openssh/sftp-server"
