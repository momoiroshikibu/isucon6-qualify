# http://man7.org/linux/man-pages/man1/systemd.1.html
systemd.loglevel:
	@ssh $(SSH_USER)@$(SSH_HOST) sudo systemctl show -pLogLevel
systemd.loglevel.emerg:
	@ssh $(SSH_USER)@$(SSH_HOST) sudo systemd-analyze set-log-level emerg
systemd.loglevel.alert:
	@ssh $(SSH_USER)@$(SSH_HOST) sudo systemd-analyze set-log-level alert
systemd.loglevel.crit:
	@ssh $(SSH_USER)@$(SSH_HOST) sudo systemd-analyze set-log-level crit
systemd.loglevel.err:
	@ssh $(SSH_USER)@$(SSH_HOST) sudo systemd-analyze set-log-level err
systemd.loglevel.warning:
	@ssh $(SSH_USER)@$(SSH_HOST) sudo systemd-analyze set-log-level warning
systemd.loglevel.notice:
	@ssh $(SSH_USER)@$(SSH_HOST) sudo systemd-analyze set-log-level notice
systemd.loglevel.info:
	@ssh $(SSH_USER)@$(SSH_HOST) sudo systemd-analyze set-log-level info
systemd.loglevel.debug:
	@ssh $(SSH_USER)@$(SSH_HOST) sudo systemd-analyze set-log-level debug



journald.log.pid:
	@ssh $(SSH_USER)@$(SSH_HOST) sudo journalctl _PID=$$PID
journald.log.pid.tail:
	@ssh $(SSH_USER)@$(SSH_HOST) sudo journalctl -f _PID=$$PID
journald.log.by.service.pid:
	@if [ -z "${SERVICE}" ]; then \
	    echo 'variable SERVICE is required'; \
	    echo 'ex) make journald.log.by.service.pid SERVICE=isubata.nodejs'; \
	    exit 1; \
	fi
	$(eval PID := $(shell ssh ${SSH_USER}@${SSH_HOST} sudo systemctl status ${SERVICE} | grep PID | awk '{print $$3}'))
	@echo "PID of ${SERVICE} is ${PID}.\n"
	@$(MAKE) journald.log.pid PID=${PID}
journald.log.by.service.unit:
	@if [ -z "${SERVICE}" ]; then \
	    echo 'variable SERVICE is required'; \
	    echo 'ex) make journald.log.by.service.unit SERVICE=isubata.nodejs'; \
	    exit 1; \
	fi
	@ssh $(SSH_USER)@$(SSH_HOST) sudo journalctl -xe -u ${SERVICE}



editor.change:
	@echo 'not work in CentOS'
	@ssh -t $(SSH_USER)@$(SSH_HOST) sudo update-alternatives --config editor



visudo:
	@echo "add this line"
	@echo "isucon ALL=NOPASSWD: ALL"
	@ssh -t $(SSH_USER)@$(SSH_HOST) sudo visudo



ulimit:
	@ssh $(SSH_USER)@$(SSH_HOST) ulimit -a
	@ssh $(SSH_USER)@$(SSH_HOST) ulimit -n
	@echo "\n[Soft]"
	@ssh $(SSH_USER)@$(SSH_HOST) ulimit -Sn
	@echo "\n[Hard]"
	@ssh $(SSH_USER)@$(SSH_HOST) ulimit -Hn
ulimit.append:
	@echo 'append these lines as root'
	@echo 'echo -e "*    soft nofile 65536\n*    hard nofile 65536\nroot soft nofile 65536\nroot hard nofile 65536" >> /etc/security/limits.conf'



ps:
	@echo "Notice: not found process makes Error 2"
	@-make ps.aux.grep.node
	@echo ""
	@-make ps.aux.grep.nginx
	@echo ""
	@-make ps.aux.grep.mysql
	@echo ""
	@-make ps.aux.grep.redis
	@echo ""
	@-make ps.aux.grep.memcached
ps.aux.grep.node:
	@echo "[Node.js]"
	@-ssh $(SSH_USER)@$(SSH_HOST) ps aux | grep -i node
ps.aux.grep.nginx:
	@echo "[Nginx]"
	@-ssh $(SSH_USER)@$(SSH_HOST) ps aux | grep -i nginx
ps.aux.grep.mysql:
	@echo "[MySQL]"
	@-ssh $(SSH_USER)@$(SSH_HOST) ps aux | grep -i nginx
ps.aux.grep.redis:
	@echo "[Redis]"
	@-ssh $(SSH_USER)@$(SSH_HOST) ps aux | grep -i redis
ps.aux.grep.memcached:
	@echo "[Memcached]"
	@-ssh $(SSH_USER)@$(SSH_HOST) ps aux | grep -i memcached



lsof:
	@echo 'Notice: closed ports make Error 1'
	@echo ""
	@-make lsof.nginx
	@echo ""
	@-make lsof.mysql
	@echo ""
	@-make lsof.node
	@echo ""
	@-make lsof.node.inspect
	@echo ""
	@-make lsof.redis
	@echo ""
	@-make lsof.memcached
lsof.nginx:
	@echo "[80 - Nginx]"
	@-ssh $(SSH_USER)@$(SSH_HOST) sudo lsof -i:80
	@echo "[443 - Nginx]"
	@-ssh $(SSH_USER)@$(SSH_HOST) sudo lsof -i:443
lsof.mysql:
	@echo "[3306 - MySQL]"
	@-ssh $(SSH_USER)@$(SSH_HOST) sudo lsof -i:3306
lsof.node:
	@echo "[5000 - Node.js]"
	@-ssh $(SSH_USER)@$(SSH_HOST) sudo lsof -i:5000
lsof.node.inspect:
	@echo "[9229 - Node.js --inspect]"
	@-ssh $(SSH_USER)@$(SSH_HOST) sudo lsof -i:9229
lsof.redis:
	@echo "[6379 - Redis]"
	@-ssh $(SSH_USER)@$(SSH_HOST) sudo lsof -i:6379
lsof.memcached:
	@echo "[11211 - Memcached]"
	@-ssh $(SSH_USER)@$(SSH_HOST) sudo lsof -i:11211

lsof.yum.install:
	@ssh $(SSH_USER)@$(SSH_HOST) sudo yum install -y lsof

lsof.all.listening.ports:
	@ssh $(SSH_USER)@$(SSH_HOST) sudo lsof -i -P | grep "LISTEN"




cpuinfo:
	@ssh $(SSH_USER)@$(SSH_HOST) cat /proc/cpuinfo
cpuinfo.processors:
	@ssh $(SSH_USER)@$(SSH_HOST) cat /proc/cpuinfo | grep processor

meminfo:
	@ssh $(SSH_USER)@$(SSH_HOST) cat /proc/meminfo

redhatrelease:
	@ssh $(SSH_USER)@$(SSH_HOST) cat /etc/redhat-release



uptime:
	@ssh $(SSH_USER)@$(SSH_HOST) sudo uptime


dmesg:
	@ssh $(SSH_USER)@$(SSH_HOST) sudo dmesg


iostat:
	@ssh $(SSH_USER)@$(SSH_HOST) sudo iostat -xtc 1

netstat:
	@ssh $(SSH_USER)@$(SSH_HOST) sudo netstat
netstat.listener:
	@ssh $(SSH_USER)@$(SSH_HOST) sudo netstat -ltunp
