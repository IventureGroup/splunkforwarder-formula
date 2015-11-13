splunk:
  service.running:
    - enable: True
    - restart: True
    - require:
      - pkg: splunkforwarder
      - file: /opt/splunkforwarder/etc/system/local/outputs.conf
      - file: /opt/splunkforwarder/etc/apps/search/local/inputs.conf
    - watch:
      - file: /opt/splunkforwarder/etc/system/local/outputs.conf
      - file: /opt/splunkforwarder/etc/apps/search/local/inputs.conf
