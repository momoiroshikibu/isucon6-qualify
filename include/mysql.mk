# MySQL
MYSQL_SLOW_LOG_FILE="/var/log/mysql/mysql-slow.log"
mysql.log.error:
	@make mysql.log.pull
	@cat .logs/mysql/error.log

mysql.log.pull:
	@rsync -av --progress -e ssh --rsync-path='sudo rsync' $(SSH_USER)@$(SSH_HOST):/var/log/mysql .logs/
	@\cp -R .logs/mysql .logs/mysql_$(DATETIME)

mysql.query.log.tail:
	@ssh $(SSH_USER)@$(SSH_HOST) sudo tail -f $(MYSQL_SLOW_LOG_FILE)

mysql.query.log.remove:
	@ssh $(SSH_USER)@$(SSH_HOST) rm -f $(MYSQL_SLOW_LOG_FILE)

mysql.log.rotate:
	@ssh $(SSH_USER)@$(SSH_HOST) sudo mv /var/log/mysql /var/log/mysql_$(DATETIME)
	@ssh $(SSH_USER)@$(SSH_HOST) sudo mkdir -p /var/log/mysql
	@ssh $(SSH_USER)@$(SSH_HOST) sudo chown mysql:mysql /var/log/mysql
	@rsync -av --progress -e ssh --rsync-path='sudo rsync' $(SSH_USER)@$(SSH_HOST):/var/log/mysql_$(DATETIME) .logs/
	@rm -rf .logs/mysql
	@\cp -R  .logs/mysql_$(DATETIME) .logs/mysql

mysql.log.query:
	@cat .logs/mysql/mysql-slow.log

mysql.service.status:
	@ssh $(SSH_USER)@$(SSH_HOST) sudo systemctl status mysql

mysql.service.restart:
	@make -s mysql.log.rotate
	@ssh $(SSH_USER)@$(SSH_HOST) sudo systemctl restart mysql

mysql.service.log:
	@ssh $(SSH_USER)@$(SSH_HOST) sudo journalctl -xe -u mysql

mysql.etc.pull:
	@rsync -av --progress -e ssh --rsync-path='sudo rsync' $(SSH_USER)@$(SSH_HOST):/etc/mysql/ ./etc/mysql

mysql.etc.push:
	@rsync -av --progress -e ssh --rsync-path='sudo rsync' ./etc/mysql/ $(SSH_USER)@$(SSH_HOST):/etc/mysql


MYSQL_USER="isucon"
MYSQL_PASSWORD="isucon"
MYSQL_DB_NAME="isubata"
mysql:
	@ssh -t $(SSH_USER)@$(SSH_HOST) mysql -u$(MYSQL_USER) -p$(MYSQL_PASSWORD) $(MYSQL_DB_NAME)

mysql.command.show.databases:
	@make mysql.execute SQL='show databases;'

mysql.execute:
	@echo $$SQL
	@ssh $(SSH_USER)@$(SSH_HOST) mysql -u$(MYSQL_USER) -p$(MYSQL_PASSWORD) $(MYSQL_DB_NAME) -e "'$$SQL'"


mysql.slowlog.enable:
	@make mysql.execute SQL='set global slow_query_log_file = "/var/log/mysql/mysql-slow.log"';
	@make mysql.execute SQL="set global slow_query_log = 1";
	@make mysql.execute SQL="set global long_query_time = 0";
	@make mysql.execute SQL="set global log_queries_not_using_indexes = 1";

mysql.slowlog.disable:
	@make mysql.execute SQL="set global slow_query_log = 0";
	@make mysql.execute SQL="set global log_queries_not_using_indexes = 0";

mysql.command.show.variables:
	@make mysql.execute SQL='show variables;'

mysql.command.show.variables.of.slowlog:
	@make mysql.execute SQL="show variables;" | grep -e slow_query -e long_query -e log_queries | sort -r

mysql.command.show.tables:
	@make mysql.execute SQL='show tables;'

mysql.command.show.table.status:
	@make mysql.execute SQL='show table status;'

mysql.command.show.processlist:
	@make mysql.execute SQL='show full processlist;'

mysql.command.show.benchmark:
	@echo "ex) make mysql.command.show.benchmark BENCHMARK_SQL='select * from user;' TIMES=10000"
	@ssh $(SSH_USER)@$(SSH_HOST) mysql -u$(MYSQL_USER) -p$(MYSQL_PASSWORD) $(MYSQL_DB_NAME) -e "\"SELECT BENCHMARK($(TIMES), '$(BENCHMARK_SQL)') \G;\""
#	@$(MAKE) mysql.execute SQL="SELECT BENCHMARK($(TIMES), '$(BENCHMARK_SQL)');"

mysql.dump.all:
	@-mkdir -p .dump/mysql
	@ssh $(SSH_USER)@$(SSH_HOST) mysqldump -u$(MYSQL_USER) -p$(MYSQL_PASSWORD) -A > .dump/mysql/mysql.all.dump

mysql.local.import.all:
	@mysql -uroot -ppassword < .dump/mysql/mysql.all.dump
