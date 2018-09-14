# htop
htop.install:
	@ssh $(SSH_USER)@$(SSH_HOST) sudo rpm -ivh 'http://dl.fedoraproject.org/pub/epel/7/x86_64/Packages/h/htop-2.2.0-1.el7.x86_64.rpm'

htop:
	@ssh -t $(SSH_USER)@$(SSH_HOST) htop
