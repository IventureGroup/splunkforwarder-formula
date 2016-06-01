{% if pillar['splunk'] is defined and pillar['splunk']['self_cert_name'] is defined %}
{% set check_self_cert = True %}
{%- set self_cert = salt['pillar.get']('splunk:self_cert_filename', 'selfsignedcert.pem') %}
{% else %}
{% set check_self_cert = False %}
{% endif %}

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
    {% if check_self_cert %}
    - context:
      self_cert: {{ self_cert }}
    {% endif %}
    - require:
      - pkg: splunkforwarder
      - file: /opt/splunkforwarder/etc/apps/search/local
      {% if check_self_cert %}
      - file: /opt/splunkforwarder/etc/certs/{{ self_cert }}
      {% endif %}
    - require_in:
      - service: splunkforwarder-service
    - watch_in:
      - service: splunkforwarder-service

/opt/splunkforwarder/etc/system/local/outputs.conf:
  file.managed:
    - name: /opt/splunkforwarder/etc/system/local/outputs.conf
    - source: salt://splunkforwarder/files/etc/system/local/outputs.conf.template
    - template: jinja
    - user: splunk
    - group: splunk
    - mode: 600
    {% if check_self_cert %}
    - context:
      self_cert: {{ self_cert }}
    {% endif %}
    - require:
      - pkg: splunkforwarder
      {% if check_self_cert %}
      - file: /opt/splunkforwarder/etc/certs/{{ self_cert }}
      {% endif %}
