# App
APP_SERVICE_NAME="isuda.js.service"
APP_DIRECTORY="/home/isucon/webapp/js"
app.log:
	@ssh $(SSH_USER)@$(SSH_HOST) sudo journalctl -xe -u $(APP_SERVICE_NAME)

app.log.format.short:
	@ssh $(SSH_USER)@$(SSH_HOST) sudo journalctl -xe -u $(APP_SERVICE_NAME) -o short --no-pager

app.log.tail:
	@ssh $(SSH_USER)@$(SSH_HOST) sudo journalctl -xe -f -u $(APP_SERVICE_NAME)

APP_SERVICE_FILE="/etc/systemd/system/isuda.js.service"
app.service.pull:
	@scp -p $(SSH_USER)@$(SSH_HOST):$(APP_SERVICE_FILE) ./etc/systemd/system/isuda.js.service

app.service.push:
	@rsync -av --progress -e ssh --rsync-path='sudo rsync' ./etc/systemd/system/isuda.js.service $(SSH_USER)@$(SSH_HOST):$(APP_SERVICE_FILE)
	@ssh $(SSH_USER)@$(SSH_HOST) sudo systemctl daemon-reload

app.service.status:
	@ssh $(SSH_USER)@$(SSH_HOST) sudo systemctl status $(APP_SERVICE_NAME)

app.service.start:
	@ssh $(SSH_USER)@$(SSH_HOST) sudo systemctl start $(APP_SERVICE_NAME)
	@make app.service.status

app.service.stop:
	@ssh $(SSH_USER)@$(SSH_HOST) sudo systemctl stop $(APP_SERVICE_NAME)
	@make app.service.status

app.service.restart:
	@ssh $(SSH_USER)@$(SSH_HOST) sudo systemctl restart $(APP_SERVICE_NAME)
	@make app.service.status

app.service.enable:
	@ssh $(SSH_USER)@$(SSH_HOST) sudo systemctl enable $(APP_SERVICE_NAME)

app.service.disable:
	@ssh $(SSH_USER)@$(SSH_HOST) sudo systemctl disable $(APP_SERVICE_NAME)

app.pull:
	@rsync -av --progress -e ssh --exclude 'node_modules' $(SSH_USER)@$(SSH_HOST):$(APP_DIRECTORY) ./webapp

app.push:
	@rsync -av --progress --delete -e ssh --exclude 'node_modules' webapp/js $(SSH_USER)@$(SSH_HOST):/home/isucon/webapp/

app.push.with.npm.install:
	@make app.push
	@make node.npm.install.all
