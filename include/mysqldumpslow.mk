LOCAL_MYSQL_SLOW_LOG_FILE=".logs/mysql/mysql-slow.log"
mysqldumpslow.sort.by.average.lock.time:
	@mysqldumpslow -s -al $(LOCAL_MYSQL_SLOW_LOG_FILE)

mysqldumpslow.sort.by.average.lock.time.reverse:
	@mysqldumpslow -s -al -r $(LOCAL_MYSQL_SLOW_LOG_FILE)

mysqldumpslow.sort.by.average.rows.sent:
	@mysqldumpslow -s -ar $(LOCAL_MYSQL_SLOW_LOG_FILE)

mysqldumpslow.sort.by.average.rows.sent.reverse:
	@mysqldumpslow -s -ar -r $(LOCAL_MYSQL_SLOW_LOG_FILE)

mysqldumpslow.sort.by.average.query.time:
	@mysqldumpslow -s -at $(LOCAL_MYSQL_SLOW_LOG_FILE)

mysqldumpslow.sort.by.average.query.time.reverse:
	@mysqldumpslow -s -at -r $(LOCAL_MYSQL_SLOW_LOG_FILE)

mysqldumpslow.sort.by.count:
	@mysqldumpslow -s -c $(LOCAL_MYSQL_SLOW_LOG_FILE)

mysqldumpslow.sort.by.count.reverse:
	@mysqldumpslow -s -c -r $(LOCAL_MYSQL_SLOW_LOG_FILE)

mysqldumpslow.sort.by.lock.time:
	@mysqldumpslow -s -l $(LOCAL_MYSQL_SLOW_LOG_FILE)

mysqldumpslow.sort.by.lock.time.reverse:
	@mysqldumpslow -s -l -r $(LOCAL_MYSQL_SLOW_LOG_FILE)

mysqldumpslow.sort.by.rows.sent:
	@mysqldumpslow -s -r $(LOCAL_MYSQL_SLOW_LOG_FILE)

mysqldumpslow.sort.by.rows.sent.reverse:
	@mysqldumpslow -s -r -r $(LOCAL_MYSQL_SLOW_LOG_FILE)

mysqldumpslow.sort.by.query.time:
	@mysqldumpslow -s -t $(LOCAL_MYSQL_SLOW_LOG_FILE)

mysqldumpslow.sort.by.query.time.reverse:
	@mysqldumpslow -s -t -r $(LOCAL_MYSQL_SLOW_LOG_FILE)

pt-query-digest.analyze:
	@pt-query-digest .logs/mysql/mysql-slow.log > .logs/mysql/pt-query-digest-result.txt
	@less .logs/mysql/pt-query-digest-result.txt

pt-query-digest.result.show:
	@less .logs/mysql/pt-query-digest-result.txt

