splunkforwarder-service-enable:
  cmd.run:
    - name: /opt/splunkforwarder/bin/splunk enable boot-start --answer-yes --no-prompt --accept-license
    - cwd: /root/

splunkforwarder-service-start:
  cmd.wait:
    - name: /opt/splunkforwarder/bin/splunk start
    - cwd: /root/
    - watch:
      - pkg: splunkforwarder

splunkforwarder-service:
  service.running:
    - name: splunk
    - enable: True
    - restart: True
    - require:
      - pkg: splunkforwarder
