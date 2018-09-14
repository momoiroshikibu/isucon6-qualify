# https://oxynotes.com/?p=7566

dstat.all:
	@ssh -t $(SSH_USER)@$(SSH_HOST) sudo dstat -ta --top-io-adv --top-bio-adv -i --unix --ipc --lock -rp --top-cpu-adv
