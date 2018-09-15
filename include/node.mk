# Node
node.repl:
	@ssh -t $(SSH_USER)@$(SSH_HOST) /home/isucon/.nodebrew/current/bin/node

node.version:
	@ssh $(SSH_USER)@$(SSH_HOST) /home/isucon/.nodebrew/current/bin/node --version

## Node.nodebrew
node.nodebrew.install:
	@ssh $(SSH_USER)@$(SSH_HOST) 'sudo curl -L git.io/nodebrew | perl - setup'

node.nodebrew.execute:
	@echo "nodebrew ${COMMAND}"
	@ssh $(SSH_USER)@$(SSH_HOST) /home/isucon/.nodebrew/current/bin/nodebrew ${COMMAND}

node.nodebrew.version:
	@make node.nodebrew.execute COMMAND="--version"

node.nodebrew.ls:
	@make node.nodebrew.execute COMMAND="ls"

node.nodebrew.use:
	@make node.nodebrew.execute COMMAND="use ${VERSION}"

node.nodebrew.use.latest:
	@make node.nodebrew.execute COMMAND="use latest"

node.nodebrew.install.binary:
	@make node.nodebrew.execute COMMAND="install-binary ${VERSION}"

node.nodebrew.install.binary.latest:
	@make node.nodebrew.execute COMMAND="install-binary latest"

## Node.npm
APP_DIRECTORY="/home/isucon/webapp/js"
node.npm.version:
	@ssh $(SSH_USER)@$(SSH_HOST) /home/isucon/.nodebrew/current/bin/npm --version

node.npm.install.all:
	@make node.npm.execute COMMAND="cd ${APP_DIRECTORY} && npm install && npm ls --depth=0"

node.npm.install:
	@make node.npm.execute COMMAND="cd ${APP_DIRECTORY} && npm install ${PACKAGE}"

node.npm.uninstall:
	@make node.npm.execute COMMAND="cd ${APP_DIRECTORY} && npm uninstall ${PACKAGE}"

node.npm.clean:
	@ssh $(SSH_USER)@$(SSH_HOST) rm -rf ${APP_DIRECTORY}/node_modules

node.npm.cache.clean:
	@make node.npm.execute COMMAND="npm cache clean --force"

node.npm.ls:
	@make node.npm.execute COMMAND='npm ls'

node.npm.ls.by.depth:
	@make node.npm.execute COMMAND="npm ls --depth=${DEPTH}"

node.npm.execute:
	@make node.npm.enable
	@echo "npm ${COMMAND}"
	@ssh $(SSH_USER)@$(SSH_HOST) "cd ${APP_DIRECTORY} && ${COMMAND}"

node.npm.enable:
	@ssh $(SSH_USER)@$(SSH_HOST) sudo ln -sf /home/isucon/.nodebrew/current/bin/npm /usr/bin/npm
	@ssh $(SSH_USER)@$(SSH_HOST) sudo ln -sf /home/isucon/.nodebrew/current/bin/node /usr/bin/node
	@ssh $(SSH_USER)@$(SSH_HOST) echo 'node --version'
	@ssh $(SSH_USER)@$(SSH_HOST) node --version
	@ssh $(SSH_USER)@$(SSH_HOST) echo 'npm --version'
	@ssh $(SSH_USER)@$(SSH_HOST) npm --version

node.npm.disable:
	@ssh $(SSH_USER)@$(SSH_HOST) sudo rm -rf /usr/bin/npm
	@ssh $(SSH_USER)@$(SSH_HOST) sudo rm -rf /usr/bin/node
