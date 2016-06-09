

{% set scratch0 = salt['network.in_subnet']('10.129.0.0/16') %}

{% set run = salt['saltutil.runner'] %}
{% set scratch = run('mine.get', tgt='not I@blacklisted', fun='private_ip',
                     tgt_type='compound') %}


scratch:
  foo: bar
  {% set scratch1 = run('mine.get',
                                 tgt='not I@blacklisted',
                                 fun='private_ip',
                                 tgt_type='compound') %}
  privates: {{ scratch1 }}

  {% set scratch2 = run('mine.get',
                                 tgt='not I@blacklisted',
                                 fun='public_ip',
                                 tgt_type='compound') %}
  publics: {{ scratch2 }}
