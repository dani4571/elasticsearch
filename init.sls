# Install mysql, a mysql client, and run a brief attempt at tuning based on
# available system memory.

include:
  - salt-java

elasticsearch_repo:
    pkgrepo.managed:
        - humanname: Elasticsearch Repo
        - name: deb http://packages.elasticsearch.org/elasticsearch/1.2/debian stable main
        - dist: stable
        - key_url: salt://elasticsearch/GPG-KEY-elasticsearch
        - file: /etc/apt/sources.list.d/elasticsearch.list

elasticsearch:
    pkg:
        - installed
        - require:
            - pkg: openjdk-7-jdk
            - pkgrepo: elasticsearch_repo
    service:
        - running
        - enable: True
        - require:
            - pkg: elasticsearch
            - file: /etc/elasticsearch/elasticsearch.yml

/etc/elasticsearch/elasticsearch.yml:
  file:
    - managed
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - source: salt://elasticsearch/elasticsearch.yml