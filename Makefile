.DEFAULT_GOAL := help

SSH_USER="isucon"
SSH_HOST="isucon7-qualify"
DATETIME=$(shell date "+%Y%m%d-%H%M%S")

include include/nginx.mk
include include/app.mk
include include/dstat.mk
include include/mysql.mk
include include/mysqldumpslow.mk
include include/htop.mk
include include/iotop.mk
include include/alp.mk
include include/system.mk
include include/ssh.mk
include include/redis.mk
include include/curl.mk
include include/bench.mk
include include/node.mk
