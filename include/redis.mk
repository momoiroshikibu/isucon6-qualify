redis.install.ubuntu:
	@ssh ${SSH_USER}@${SSH_HOST} sudo apt install redis-server

redis.install.centos7:
	@ssh ${SSH_USER}@${SSH_HOST} sudo yum -y install epel-release
	@ssh ${SSH_USER}@${SSH_HOST} sudo yum search redis
	@ssh ${SSH_USER}@${SSH_HOST} sudo yum info redis
	@ssh ${SSH_USER}@${SSH_HOST} sudo yum install -y redis
	@$(MAKE) redis.version



redis.version:
	@echo '[redis-server]'
	@ssh ${SSH_USER}@${SSH_HOST} redis-server --version
	@echo '[redis-cli]'
	@ssh ${SSH_USER}@${SSH_HOST} redis-cli --version



redis.service.status:
	@ssh ${SSH_USER}@${SSH_HOST} systemctl status redis

redis.service.enable:
	@ssh ${SSH_USER}@${SSH_HOST} systemctl enable redis

redis.service.restart:
	@ssh ${SSH_USER}@${SSH_HOST} sudo systemctl restart redis

redis.service.stop:
	@ssh ${SSH_USER}@${SSH_HOST} sudo systemctl stop redis



redis.cli:
	@ssh -t ${SSH_USER}@${SSH_HOST} redis-cli

redis.cli.keys:
	@ssh -t ${SSH_USER}@${SSH_HOST} redis-cli keys "\*"

redis.cli.flushall:
	@ssh -t ${SSH_USER}@${SSH_HOST} redis-cli flushall



REDIS_LOG_FILE='/var/log/redis/redis-server.log'
redis.log.cat:
	@ssh ${SSH_USER}@${SSH_HOST} cat ${REDIS_LOG_FILE}

redis.log.less:
	@ssh -t ${SSH_USER}@${SSH_HOST} less ${REDIS_LOG_FILE}

redis.log.tail:
	@ssh ${SSH_USER}@${SSH_HOST} tail -f ${REDIS_LOG_FILE}



REDIS_CONF_FILE='/etc/redis/redis.conf'
redis.conf.cat:
	@ssh ${SSH_USER}@${SSH_HOST} sudo cat ${REDIS_CONF_FILE}

redis.conf.less:
	@ssh -t ${SSH_USER}@${SSH_HOST} sudo less ${REDIS_CONF_FILE}

redis.conf.pull:
	@rsync -av --progress -e ssh --rsync-path='sudo rsync' $(SSH_USER)@$(SSH_HOST):/etc/redis/ ./etc/redis

redis.conf.push:
	@rsync -av --progress -e ssh --rsync-path='sudo rsync' ./etc/redis/ $(SSH_USER)@$(SSH_HOST):/etc/redis
	@ssh ${SSH_USER}@${SSH_HOST} sudo chmod -R 777 /etc/redis



redis.dbsize:
	@ssh ${SSH_USER}@${SSH_HOST} redis-cli dbsize

redis.bgsave:
	@ssh ${SSH_USER}@${SSH_HOST} redis-cli bgsave

redis.lastsave:
	$(eval time := $(shell ssh ${SSH_USER}@${SSH_HOST} redis-cli lastsave))
	@echo $(shell date -r ${time})
	@echo "unixtime: " ${time}



REDIS_RDB_FILE='/var/lib/redis/dump.rdb'
redis.dump:
	$(MAKE) redis.bgsave
	@-ssh ${SSH_USER}@${SSH_HOST} cp -p ${REDIS_RDB_FILE} /tmp/dump.rdb.$(DATETIME)
	@ssh ${SSH_USER}@${SSH_HOST} ls -lah /tmp/dump.rdb.$(DATETIME)
	@echo "backup: /tmp/dump.rdb.$(DATETIME)"
	$(MAKE) redis.dump.list.update

redis.dump.list:
	@cat /tmp/redis_dumps

redis.dump.list.update:
	@-ssh ${SSH_USER}@${SSH_HOST} rm -rf /tmp/redis_dumps
	@ssh ${SSH_USER}@${SSH_HOST} ls "/tmp/dump.rdb.*" > /tmp/redis_dumps

redis.dump.restore:
	@$(MAKE) redis.dump.list.update
	$(eval restore_from := $(shell cat /tmp/redis_dumps | peco))
	@if [ -z "${restore_from}" ]; then \
	    echo 'restore canceled'; \
	    exit 1; \
	fi
	@echo 'start restore from ${restore_from}'
	@-ssh ${SSH_USER}@${SSH_HOST} ls -la ${REDIS_RDB_FILE}
	@$(MAKE) redis.service.stop
	@ssh ${SSH_USER}@${SSH_HOST} sudo rm -f ${REDIS_RDB_FILE}
	@ssh ${SSH_USER}@${SSH_HOST} sudo cp -p ${restore_from} ${REDIS_RDB_FILE}
	@$(MAKE) redis.service.restart
	@ssh ${SSH_USER}@${SSH_HOST} ls -la ${REDIS_RDB_FILE}
