bench.execute:
	@ssh $(SSH_USER)@$(SSH_HOST) 'cd /home/isucon/isubata/bench && ./bin/bench --remotes=127.0.0.1 -output result_$(DATETIME).json'
