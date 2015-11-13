splunk_group:
  group.present:
    - name: splunk

splunk_user:
  user.present:
    - name: splunk
    - home: /opt/splunkforwarder
    - groups:
      - splunk
    - require:
      - group: splunk_group
    {% if salt['pillar.get'][splunkforwarder][uid] is defined %}
    - uid: {{ pillar['splunkforwarder']['uid'] }}
    {% endif %}
