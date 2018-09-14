iotop:
	@ssh -t $(SSH_USER)@$(SSH_HOST) sudo iotop

iotop.all:
	@ssh -t $(SSH_USER)@$(SSH_HOST) sudo iotop

iotop.active.only:
	@ssh -t $(SSH_USER)@$(SSH_HOST) sudo iotop -o

iotop.active.processes:
	@ssh -t $(SSH_USER)@$(SSH_HOST) sudo iotop -P -o

iotop.install:
	@ssh $(SSH_USER)@$(SSH_HOST) sudo yum install -y iotop


