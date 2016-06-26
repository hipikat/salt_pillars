


{% from "empire.jinja" import empire, get_self, get_interface %}


empire: {{ empire }}

self: {{ get_self() }}

my_public_ip: {{ get_interface('public', 'ip') }}
