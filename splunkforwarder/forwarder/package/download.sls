{%- set download_base_url = pillar['splunkforwarder']['download_base_url'] %}
{%- set package_filename = pillar['splunkforwarder']['package_filename'] %}
{%- set source_hash = pillar['splunkforwarder']['source_hash'] %}

include:
  - splunkforwarder.forwarder.service

get-splunkforwarder-package:
  file.managed:
    - name: /usr/local/src/{{ package_filename }}
    - source: {{ download_base_url }}{{ package_filename }}
    - source_hash: {{ source_hash }}

is-splunkforwarder-package-outdated:
  cmd.run:
    - cwd: /usr/local/src
    - stateful: True
    - names:
      - new=$(dpkg-deb --showformat='${Package} ${Version}\n' -W {{ package_filename }});
        old=$(dpkg-query --showformat='${Package} ${Version}\n' -W splunkforwarder);
        if test "$new" != "$old";
          then echo; echo "changed=true comment='new($new) vs old($old)'";
          else echo; echo "changed=false";
        fi;
    - require:
      - pkg: splunkforwarder

splunkforwarder:
  pkg.installed:
    - sources:
      - splunkforwarder: /usr/local/src/{{ package_filename }}
    - require:
      - user: splunk_user
      - file: get-splunkforwarder-package
  cmd.watch:
    - cwd: /usr/local/src/
    - name: dpkg -i {{ package_filename }}
    - watch:
      - cmd: is-splunkforwarder-package-outdated
