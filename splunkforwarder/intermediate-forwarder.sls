{%- set self_cert = salt['pillar.get']('splunk:self_cert_filename', 'selfsignedcert.pem') %}

include:
  - splunkforwarder.forwarder

/opt/splunkforwarder/etc/system/local/inputs.conf:
  file.managed:
    - name: /opt/splunkforwarder/etc/system/local/inputs.conf
    - source:
      salt://splunkforwarder/files/etc/system/local/inputs.conf.template
    - template: jinja
    - user: splunk
    - group: splunk
    - mode: 600
    - context:
      self_cert: {{ self_cert }}
    - require:
      - pkg: splunkforwarder
      - file: /opt/splunkforwarder/etc/certs/{{ self_cert }}
    - watch_in:
      - service: splunkforwarder-service

/opt/splunkforwarder/etc/apps/search/metadata:
  file.directory:
    - user: splunk
    - group: splunk
    - mode: 0755
    - makedirs: True

/opt/splunkforwarder/etc/apps/search/metadata/local.metadata:
  file.managed:
    - name: /opt/splunkforwarder/etc/apps/search/metadata/local.metadata
    - source: salt://splunkforwarder/files/etc/apps/search/metadata/local.metadata.template
    - template: jinja
    - user: splunk
    - group: splunk
    - mode: 600
    - require:
      - pkg: splunkforwarder
      - file: /opt/splunkforwarder/etc/apps/search/metadata
    - watch_in:
      - service: splunkforwarder-service
