include:
  - splunkforwarder.user
{% if salt['pillar.get']('splunkforwarder:package:name', False) %}
  - splunkforwarder.forwarder.package.repo
{% else %}
  - splunkforwarder.forwarder.package.download
{% endif %}
  - splunkforwarder.forwarder.service
  - splunkforwarder.forwarder.config
