{% set custom_repo = salt['pillar.get']('splunkforwarder:package:repo', False) %}
{% set custom_version = salt['pillar.get']('splunkforwarder:package:version', False) %}

splunkforwarder:
  pkg.latest:
    - name: {{ salt['pillar.get']('splunkforwarder:package:name') }}
{% if custom_repo %}
    - fromrepo: {{ custom_repo }}
{% endif %}
{% if custom_version %}
    - version: {{ custom_version }}
{% endif %}
