
{% from 'users/hipikat.sls' import user_hipikat %}

users:
  # Adam Wright
  {{ user_hipikat()|indent(2) }}

  # Website office
  weboffice:
    fullname: UWA Website Office
    groups:
      - www-data
    createhome: False

