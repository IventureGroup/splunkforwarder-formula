include:
  - splunkforwarder.forwarder

/opt/splunkforwarder/etc/auth:
  file.directory:
    - user: splunk
    - group: splunk
    - mode: 700
    - makedirs: True

/opt/splunkforwarder/etc/auth/splunk.secret:
  file.managed:
    - user: splunk
    - group: splunk
    - mode: 400
    - replace: False
    - contents_pillar: splunk:secret
    - require:
      - file: /opt/splunkforwarder/etc/auth
    - require_in:
      - service: splunk
    - watch_in:
      - service: splunk
