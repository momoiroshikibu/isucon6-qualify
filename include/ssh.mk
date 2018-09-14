ssh:
	@ssh -t $(SSH_USER)@$(SSH_HOST) bash
ssh.keygen:
	@ssh-keygen -t rsa -b 4096 -f ~/.ssh/isucon -C "" -N ""

ssh.copy.id:
	@ssh-copy-id -i ~/.ssh/isucon.pub isucon@$(SSH_HOST)

ssh.publickey:
	@cat ~/.ssh/isucon.pub

ssh.publickey.pbcopy:
	@cat ~/.ssh/isucon.pub | pbcopy
