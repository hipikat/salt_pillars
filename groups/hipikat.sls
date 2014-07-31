
{% from 'users/hipikat.sls' import user_hipikat %}

users:
  {{ user_hipikat()|indent(2) }}
