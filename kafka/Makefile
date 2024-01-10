.PHONY: list
list:
	@echo "up -> inicia o docker compose com a strutura do kafka"
	@echo "down -> finaliza o docker compose removendo volumes"

up:
	@echo startando kafka ...
	docker compose up -d
	@echo inserindo registros schema ...
	cd /tmp/ && \
	rm -rf /tmp/pay-configuration && \
	git clone --branch develop git@bitbucket.org:bexstech/pay-configuration.git && \
	echo "**************************************" && \
	echo "Aguardando 1 minuto para estabilizar o registry ..." && \
	echo "**************************************" && \
	sleep 1m && \
	cd /tmp/pay-configuration/avro/ && \
	bash -c ./script_to_push_local.sh
	@echo "**************************************"
	@echo topicos http://localhost:8000/#/
	@echo schema registry http://localhost:8001/#/
	@echo kafka manager   http://localhost:9000
	@echo "**************************************"

down:
	@echo baixando o kafka ...
	docker compose down --remove-orphans
	docker volume prune -f
	rm -rf /tmp/pay-configuration
