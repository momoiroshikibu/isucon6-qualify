bench.execute:
	@ssh $(SSH_USER)@$(SSH_HOST) 'cd /home/isucon/isucon6q && ./isucon6q-bench http:127.0.0.1'
