splunk_group:
  group.present:
    - name: splunk
    {% if pillar['splunkforwarder']['gid'] is defined %}
    - uid: {{ pillar['splunkforwarder']['gid'] }}
    {% endif %}

splunk_user:
  user.present:
    - name: splunk
    - home: /opt/splunkforwarder
    - groups:
      - splunk
    - require:
      - group: splunk_group
    {% if pillar['splunkforwarder']['uid'] is defined %}
    - uid: {{ pillar['splunkforwarder']['uid'] }}
    {% endif %}
