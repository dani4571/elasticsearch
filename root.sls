{% if 1 == salt['cmd.retcode']('test -f /root/my.cnf') %}
{% set pw = salt['mysql.query']('', 'select md5(rand())')['results'][0][0] %}

root_db_user:
  mysql_user.present:
    - name: root
    - password: {{ pw }}
    - host: localhost

/root/.my.cnf:
  file.managed:
    - source: salt://mysql/files/root.cnf
    - template: jinja
    - mode: 700
    - defaults:
        user: root
        password: {{ pw }}

{% endif %}
