#
# Secret data, only visible to trusted system admins
####################################################


# Strings for htpasswd can be generated with apache2-utils's htpasswd
# script. Nginx accepts crypt() or MD5-based passwords. Circa January 2014,
# uWSGI only accepts crypt.
{% macro htpasswd(user) -%} 
  {%- if user == 'hipikat' -%} 
    vX8xGxDxxpxE.
  {%- endif -%} 
{%- endmacro %}


# Cloud provider secrets
{% macro digitalocean_key(type) -%} 
  {%- if type == 'client' -%} 
    2e44de335fc1e6d679f2279da8d5e099
  {%- elif type == 'api' -%} 
    70862935dfdcf47b474c7b696cdcb98c
  {%- endif -%} 
{%- endmacro %}


saltlick:

  salt_cloud:
    providers:
      # Digital Ocean
      digitalocean-secrets:
        driver: digital_ocean
        ssh_key_names: hipikat-digitalocean,trepp-rsa,hipikat@bellus,hipikat@mimint

        # See https://cloud.digitalocean.com/settings/applications#access-tokens
        #personal_access_token: b6a5eb3cb9643b64dd268d615efdad37b2e2f3aebc16742143e95604fa6262c9
        personal_access_token: 8f94cb99ff73098c1fa49b6701ca0d65a2a6b08d7dca83faaf3b915bfd288fb3

        # Taken from saltlick:deploy_keys:hipikat-digitalocean:(public|private)
        # and written to /etc/saltlick/deploy_keys/hipikat-digitalocean[.pub]
        # - this becomes 'ssh_key_file' in Salt Cloud provider configurations.
        deploy_key: hipikat-digitalocean
        ssh_key_file: /etc/saltlick/deploy_keys/hipikat-digitalocean


  # Saltlick will place deploy keys in /etc/saltlick/deploy_keys/
  deploy_keys:

    # Okay so this one's actually just attached to my user profile...
    hipikat-github:
      public: ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDErWmmiITHhPTzoxlp1gIyHWsgcUBLz3BLQ7atLGlVo2C56Dm35DQhnaWUXRWdF4Nh+VFlxecc9HxP20gRYjCZ6K/Wsx9fPxfRsd4cZJ88qSfMg1zOM/eMWN1lmBLAmKv4wNwayJwzRSti7MLPvS1DO/9N4OA/2Rs7deJGrNtX22U17N2UIgc1QS4dBHcDNbg4i7qpRJ06bB6yp6G8zI+UXLQ9McmnHQU1zri0cRp8cugkAivjgExJfF/wPxNgHE5EGmoSzItC7eaxhiYd1IlzTBEqdBqU+l94XjsFDChFwm4asTkefzZkYgytrQffotlOGFsJmQk0n0HTtPPBlxqX hipikat-github
      private: |
        -----BEGIN RSA PRIVATE KEY-----
        MIIEpAIBAAKCAQEAxK1ppoiEx4T086MZadYCMh1rIHFAS89wS0O2rSxpVaNgueg5
        t+Q0IZ2llF0VnReDYflRZcXnHPR8T9tIEWIwmeiv1rMfXz8X0bHeHGSfPKknzINc
        zjP3jFjdZZgSwJir+MDcGsicM0UrYuzCz70tQzv/TeDgP9kbO3XiRqzbV9tlNezd
        lCIHNUEuHQR3AzW4OIu6qUSdOmwesqehvMyPlFy0PTHJpx0FNc64tHEafHLoJAIr
        44BMSXxf8D8TYBxORBpqEsyLQu3msYYmHdSJc0wRKnQalPpfeF47BQwoRcJuGrE5
        Hn82ZGIMra0H36LZThhbCZkJNJ9B07TzwZcalwIDAQABAoIBABfwZ6Cuk0LZyxrw
        qkI4m1HQRN7RChtwJ2Hx3wVbF4Ml/LsEKipY64N/9cyGPABAAWzmdOLnYMckdxEd
        Rrte8T16lhSS/umP+205sihQkxVGHaMGBkDPEH2Tv3cDOJ0auCvyBZh4/JI9BBfp
        a5jvlNfPMLcg/QqoeWkWYzFpDtW1lw7h9rFEXQ4eDqdS6ob7GiyMbrGcJ8FCRGs3
        cinFxedbSImvLiIasnDgmI71VbrEn4R4s4A9lhunuW06LpMntWJqJmK6vDIRSkI2
        XC8JV/4Rkh/5kDFHAyd1UxT89LN8lqd7BkHiKu63utgz91/Z+iqn5Ro5OI+Fw0A/
        CaCwYUkCgYEA4h8DPxH0poc2rdKS6MEL9NgDwkvA6cxJR5+VqoKDtNN6HFIAtXp1
        cwQmV4lfP+R8klxVfXNmzUjslm0hduabH1eAKVdnak9xH96wP/VmoIjiJ5MWJaxr
        V0ubqEcLuBBWlSsICoReB1/ynn9Xe11hoetB5pZlu6+U3fC+YK5aT9UCgYEA3qpo
        benVXs2ViDzJPI4KiE5xmBZOeu8+GMivRROVVzw1rwa0LnsgKAOrF+p4sAD9KVx6
        tvG3qu3Cz6zpkF1yZ05vSahUDtt/t/sXazMhl+8EVZBx8d1iUEVkPJi1k7h6D0xa
        iEVUBhI+68KbRE6bZSEcXA5bKxfJw304sEmyorsCgYEA1Yt8QV/vsCUZ2mZ3HyDQ
        7dXjFub7tNCck+t+KJ1BTNA7DevTh4+yw4AzxY+SSIC7tG1Gv0bw2wX3iMhfRi7a
        aGr2OhS1MYz8xKBFyuEynoEnM0CRNdrzNGnPAsi1pIqpeg49ddE0C7rtIgoY0ASM
        Y6INhnqacPmMmVz2Lc/6slECgYAS4jTVDX2w+pJx6WXPouQ1xyFPGqUxO9TyWSK0
        IwMJUOvkmhbx0jNZ8WWzM4lks9DEjzlBBqLi9iMNZcaxHZu0Myyw/HuUfv0H512H
        E+EHd5fQgd2H+5R45kmn8fOEQaLoZTtQT0De+vEnIWv1kQ0QuIwlKnqE3xGXaKlE
        GhvyPQKBgQDLoKtlabSYrIFtIBH3IuImUYcVZZ1+a/f/hoXEi3hw8N4BMitkTdNR
        Xb4IhqFxuuF9nSN2/XHDIoNe4GIbKHN1IFy7oMVUsQb1mlRZOX+swpDcIf8hij8/
        TEg/u74T7R/eO+ksiyquIS12Np2igE00obZbY64ICr5BUZigeKzHPQ==
        -----END RSA PRIVATE KEY-----

    # Used for salt-cloud VM deployment
    hipikat-digitalocean:
      public: ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDCDsXyxHv6Axr4Q32fpgNXmP5wUijC0Qpq6ppQFPaC3zClDdIqDcH7JZuh4pIoNu6htD2pPqLMeC2IE6KqG+8fnClq2gsdMfvcMlDk1C56H0dBRZSEeFYWMvAsaoI0CAC8RTjovaojWh1h0RAVczWzte4gbKiopVCDOY0jgbblgPjWq8b13CuH81tVVZM6BodJfphuD1CPgpS0K9kgADZcZ5O+jT61wzVAN2tyvPsS8ekVd9hTF2ukte3YWNUeOy8WbKBdLKz9DZUH2ubrXIM05UKx7h5QwAKjwzLwG2ZStxInEwN8gLoA68NMPdgQ7PuRh2U08EaOZXJqaZu8r9MX hipikat-digitalocean-2015-03-27
      private: |
        -----BEGIN RSA PRIVATE KEY-----
        MIIEowIBAAKCAQEAwg7F8sR7+gMa+EN9n6YDV5j+cFIowtEKauqaUBT2gt8wpQ3S
        Kg3B+yWboeKSKDbuobQ9qT6izHgtiBOiqhvvH5wpatoLHTH73DJQ5NQueh9HQUWU
        hHhWFjLwLGqCNAgAvEU46L2qI1odYdEQFXM1s7XuIGyoqKVQgzmNI4G25YD41qvG
        9dwrh/NbVVWTOgaHSX6Ybg9Qj4KUtCvZIAA2XGeTvo0+tcM1QDdrcrz7EvHpFXfY
        UxdrpLXt2FjVHjsvFmygXSys/Q2VB9rm61yDNOVCse4eUMACo8My8BtmUrcSJxMD
        fIC6AOvDTD3YEOz7kYdlNPBGjmVyammbvK/TFwIDAQABAoIBAH0Lc/ZJMfIaSiir
        pKlZGlI53cqWxnkyplnarnDn8SjHlNrmmwRKNTMWOsEH9FJBg2djc1A5ckH7Nqu2
        q1yd/2oJAI8/zWWUrcxoB8RMDV7YBNxEb70kpaRMUoLsZtYMSh0HJfKjNJzvFnvP
        cWPBB1uz4au3GL8DN2w3i4DTtv0PDKipSQXQL59gXanvfQ36RmdiHWAvYpjygXJY
        yRncJV9Syv8sZwRPnIsDiFjY26OKW2AHu10O4grfgTm1NmNZwWU2PBsN2FeJ2TSf
        XB4bKtZXnSOuaP1hazPZwGlM8ih5BwkGGSZdKoMAzXOqK6DZSdwD+zWL08u+qptm
        0hDVbqECgYEA6qpZN8khd1Kk9U0rRAqWlhoSOLr5KntiiyS6EVBE6SoU5j8s41ik
        KeS/W6hFi1+RqizOGlyeT6PJXIvJ2x9TDhbl/chhZ5td92zT5r+JdSzqeCq+7gIr
        1XLedJ6s+sf4hRkaM9UThDN6witemrIWTDr1wsJt5W1+VZZOxh23zB8CgYEA07NP
        93WcqfQzMqwmDDor0ImDpcAtCMXPG1EjK9r/3i34K2Ts37S2xabz/F2lRkhLzIo/
        AVsTxQbkUpYA5+1sRuFKaz01v5V9tVqSggwvVm1SdqhuaWaIlRYwxZ9ea2mBSn44
        0CkRR7JWDMCoWJ6FVxQ9LtKihjsWhxuaoCGxmgkCgYEA0NH8CJ9rr3IUptEf8jF1
        5WaX1nHTrlET1Pw+s495cv9mj6miOUE0/K649khccnT9+7BZS64llnsKgddHLj3G
        u9/2lApPW1IvoTDvtAO3v1TT5VEsjEHUXeIVQTO+fH+ckFxRK9StxFPHJqhPTFuz
        aeyBq+k2wBXaeTEDMltZpkMCgYBv/72evapUf81WUZ0PevcTLK1pU3J/4abgXNyu
        pv4XHVreGlb3QzQu/VS3fxOhSz5OyBTtMrIS2sKQrqtsCD/wf+BPO+LjqMMI3xID
        m06v+sZV4GYJfSVlOogzBU1+piKwtnZ4KkHqHH9J3+Mwfy0sFJkJ3IX/XeNdN01m
        ymybgQKBgC2bjJ622m0QEZw4dTlElSCiX1vlNIdkAifIIbJ1eUmrZVjRbeb/g40z
        pU8zxspwvBEfrC72mClf7Y7CguH+36QWXNZisc4fzVqtI49yua/s694sJ6n9V96y
        I26cnfj/v9BxGQvZPLijh+Y7amAVbI8HEQYAK+wS89fhUZg7cdhQ
        -----END RSA PRIVATE KEY-----
