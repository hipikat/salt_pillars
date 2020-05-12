
vsftpd_config:
  listen: 'YES'
  anonymous_enable: 'NO'
  local_enable: 'YES'
  dirmessage_enable: 'YES'
  use_localtime: 'YES'
  xferlog_enable: 'YES'
  connect_from_port_20: 'YES'
  secure_chroot_dir: '/var/run/vsftpd/empty'
  pam_service_name: 'vsftpd'
  rsa_cert_file: '/etc/ssl/certs/vsftpdcertificate.pem'
  rsa_private_key_file: '/etc/ssl/private/vsftpdserverkey.pem'

  ssl_enable: 'YES'
  allow_anon_ssl: 'NO'
  force_local_data_ssl: 'YES'
  force_local_logins_ssl: 'YES'
  require_ssl_reuse: 'NO'

  ssl_tlsv1: 'NO'
  ssl_sslv2: 'YES'
  ssl_sslv3: 'YES'

  write_enable: 'YES'

  vsftpd_log_file: '/var/log/vsftpd.log'
  log_ftp_protocol: 'YES'
  xferlog_std_format: 'YES'


  # or use booleans
  # listen: true
  # anonymous_enable: false
  # local_enable: true
