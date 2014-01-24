# Example admin users' secrets file. Strings for htpasswd can be generated with
# apache2-utils's htpasswd script. Nginx accepts crypt() or MD5-based passwords.

{% macro hipikat_htpasswd %}$apr1$Q.A/2chg$DGSunqIPwqbuVEmOrIjdK1{% endmacro %}
