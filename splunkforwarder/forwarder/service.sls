splunkforwarder-service-enable:
  cmd.wait:
    - name: /opt/splunkforwarder/bin/splunk enable boot-start --answer-yes --no-prompt --accept-license
    - cwd: /root/
    - watch:
      - pkg: splunkforwarder

splunkforwarder-service-start:
  cmd.wait:
    - name: /opt/splunkforwarder/bin/splunk start
    - cwd: /root/
    - watch:
      - pkg: splunkforwarder

splunkforwader-service:
  service.running:
    - name: splunk
    - enable: True
    - restart: True
    - require:
      - pkg: splunkforwarder
      - file: /opt/splunkforwarder/etc/system/local/outputs.conf
      - file: /opt/splunkforwarder/etc/apps/search/local/inputs.conf
    - watch:
      - file: /opt/splunkforwarder/etc/system/local/outputs.conf
      - file: /opt/splunkforwarder/etc/apps/search/local/inputs.conf
