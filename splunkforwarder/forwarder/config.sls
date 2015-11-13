{%- set self_cert = salt['pillar.get']('splunk:self_cert_filename', 'selfsignedcert.pem') %}

/opt/splunkforwarder/etc/apps/search/local:
  file.directory:
    - user: splunk
    - group: splunk
    - dir_mode: 0755
    - file_mode: 0600
    - recurse:
      - user
      - group
      - mode

/opt/splunkforwarder/etc/apps/search/local/inputs.conf:
  file.managed:
    - name: /opt/splunkforwarder/etc/apps/search/local/inputs.conf
    - source: salt://splunkforwarder/files/etc/apps/search/local/inputs.conf.template
    - template: jinja
    - user: splunk
    - group: splunk
    - mode: 644
    - context:
      self_cert: {{ self_cert }}
    - require:
      - pkg: splunkforwarder
      - file: /opt/splunkforwarder/etc/apps/search/local
      - file: /opt/splunkforwarder/etc/certs/{{ self_cert }}
    - require_in:
      - service: splunk
    - watch_in:
      - service: splunk

/opt/splunkforwarder/etc/system/local/outputs.conf:
  file.managed:
    - name: /opt/splunkforwarder/etc/system/local/outputs.conf
    - source: salt://splunkforwarder/files/etc/system/local/outputs.conf.template
    - template: jinja
    - user: splunk
    - group: splunk
    - mode: 600
    - context:
      self_cert: {{ self_cert }}
    - require:
      - pkg: splunkforwarder
      - file: /opt/splunkforwarder/etc/certs/{{ self_cert }}
