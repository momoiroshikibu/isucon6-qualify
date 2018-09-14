# Nginx
nginx.yum.add.repository:
	@ssh $(SSH_USER)@$(SSH_HOST) sudo curl 'https://gist.githubusercontent.com/momoiroshikibu/ed36c6a355db1174ffd064df3e0505e7/raw/f50af54eee1b27a523b0eadbfe0bab55aafc6769/nginx.repo.centos7' -o /etc/yum.repos.d/nginx.repo

nginx.yum.install:
	@ssh $(SSH_USER)@$(SSH_HOST) sudo yum list nginx
	@ssh $(SSH_USER)@$(SSH_HOST) sudo yum install -y nginx
	@ssh $(SSH_USER)@$(SSH_HOST) sudo nginx -v

nginx.log.tail:
	@ssh $(SSH_USER)@$(SSH_HOST) sudo tail -f /var/log/nginx/access.log

nginx.log:
	@ssh $(SSH_USER)@$(SSH_HOST) sudo cat /var/log/nginx/access.log

nginx.log.error:
	@ssh $(SSH_USER)@$(SSH_HOST) sudo cat /var/log/nginx/error.log

nginx.log.pull:
	@rsync -av --progress -e ssh --rsync-path='sudo rsync' $(SSH_USER)@$(SSH_HOST):/var/log/nginx .logs/
	@\cp -R .logs/nginx .logs/nginx_$(DATETIME)

nginx.log.remove:
	@ssh $(SSH_USER)@$(SSH_HOST) sudo rm -f /var/log/nginx/access.log

nginx.log.rotate:
	@ssh $(SSH_USER)@$(SSH_HOST) sudo mv /var/log/nginx /var/log/nginx_$(DATETIME)
	@ssh $(SSH_USER)@$(SSH_HOST) sudo mkdir -p /var/log/nginx
	@rsync -av --progress -e ssh --rsync-path='sudo rsync' $(SSH_USER)@$(SSH_HOST):/var/log/nginx_$(DATETIME) .logs/
	@rm -rf .logs/nginx
	@\cp -R  .logs/nginx_$(DATETIME) .logs/nginx

nginx.service.status:
	@ssh $(SSH_USER)@$(SSH_HOST) sudo systemctl status nginx

nginx.service.restart:
	@make -s nginx.log.rotate
	@ssh $(SSH_USER)@$(SSH_HOST) sudo systemctl restart nginx

nginx.service.enable:
	@ssh $(SSH_USER)@$(SSH_HOST) sudo systemctl enable nginx

nginx.service.log:
	@ssh $(SSH_USER)@$(SSH_HOST) sudo journalctl -xe -u nginx

nginx.etc.pull:
	@scp -pr $(SSH_USER)@$(SSH_HOST):/etc/nginx ./etc/nginx

nginx.etc.push:
	@rsync -av -e ssh --rsync-path='sudo rsync' ./etc/nginx/ $(SSH_USER)@$(SSH_HOST):/etc/nginx

nginx.which:
	@ssh $(SSH_USER)@$(SSH_HOST) which nginx

nginx.test:
	@ssh $(SSH_USER)@$(SSH_HOST) sudo nginx -t
