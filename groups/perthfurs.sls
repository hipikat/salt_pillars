
{% from 'users/hipikat.sls' import user_hipikat %}
{% from 'users/vulpyra.sls' import user_vulpyra %}

users:
  # Adam Wright
  {{ user_hipikat()|indent(2) }}

  # Ashlyn Black
  {{ user_vulpyra()|indent(2) }}

  # Website office
  weboffice:
    fullname: UWA Website Office
    groups:
      - www-data
    createhome: False

