curl.all:
	@$(MAKE) curl.80
	@echo ""
	@$(MAKE) curl.5000
curl.80:
	@echo "[Port 80]"
	@ssh $(SSH_USER)@$(SSH_HOST) curl -s localhost:80 | head -n 5| tr -d '\n'
curl.5000:
	@echo "[Port 5000]"
	@ssh $(SSH_USER)@$(SSH_HOST) curl -s localhost:5000 | head -n 5| tr -d '\n'

curl.initialize:
	@curl -s localhost:8080:/initialize | head -n 5| tr -d '\n'
