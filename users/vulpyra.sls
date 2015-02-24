#
# System administrators.
##########################################

{% macro user_vulpyra() %}
vulpyra:

  # Used by the users formula
  fullname: Ashlyn Black
  email: vulpyra@vulpyra.com
  sudouser: False
  groups:
    - www-data
    - perthfurs
  ssh_auth:
    - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAAAgQC/fCmTK48pmaA4R7srFW+HSWVwnvUD79h1HOKih6qY+BRAB{# -#}
axt6vR1ehDYFxyxTcuyhBcXxklrdVbAgI2PTAAMlzWYZc5YwY1kGMcynO+IaYnuZbqX7kmak6FJ8cyXv5dZqDrIcPJV{# -#}
abYem7XJhLwtRS3Ss0fZaCFppL47qql8kQ== vulpyra@Vulpyras-MacBook-Air.local

{% endmacro %}
