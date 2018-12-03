zabbix-agent:
  pkg.installed:
    - name: zabbix22-agent
  file.managed:
    - name: /etc/zabbix_agentd.conf
    - source: salt://init/files/zabbix_agentd.conf
    - template: jinja
    - defaults:
      ZABBIX-SERVER: {{ pillar['zabbix-agent']['Zabbix_Server'] }}   # define in ../pillar/base/zabbix.sls
      HOSTNAME: {{ grains['fqdn'][0] }} 
    - require:
      - pkg: zabbix-agent
  service.running:
    - enable: True
    - watch:
      - pkg: zabbix-agent
      - file: zabbix-agent
zabbix_agentd.conf.d:
  file.directory:
    - name: /etc/zabbix_agentd.conf.d
    - watch_in:
      - service: zabbix-agent
    - require:
      - pkg: zabbix-agent
      - file: zabbix-agent


#../pillar/base/zabbix.sls
#zabbix-agent
#  Zabbix_Server: 192.168.122.55
