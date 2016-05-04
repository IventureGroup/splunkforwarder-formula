{% set download_base_url  = pillar.get('splunkforwarder:download_base_url') %}
{% set package_filename   = pillar.get('splunkforwarder:package_filename') %}
{% set source_hash        = pillar.get('splunkforwarder:source_hash') %}

get-splunkforwarder-package:
  file.managed:
    - name: /usr/local/src/{{ package_filename }}
    - source: {{ download_base_url }}{{ package_filename }}
    - source_hash: {{ source_hash }}

splunkforwarder:
  pkg.installed:
    - sources:
      - splunkforwarder: /usr/local/src/{{ package_filename }}
    - require:
      - user: splunk_user
      - file: get-splunkforwarder-package
