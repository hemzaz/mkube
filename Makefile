.PHONY: setup demo bootstrap-minikube deploy-minikube bootstrap-helm fetch-redis-chart deploy-redis deploy-redis-client redis-set redis-get

setup: bootstrap-minikube bootstrap-helm

demo: redis-set redis-get

bootstrap-minikube:
	@chmod +x ./scripts/bootstrap_minikube.sh
	@./scripts/bootstrap_minikube.sh

run-minikube:
	@python3 ./scripts/run_minikube.py

bootstrap-helm:
	@chmod +x ./scripts/bootstrap_helm.sh
	@./scripts/bootstrap_helm.sh

fetch-redis-chart:
	@chmod +x ./scripts/fetch_redis_chart.sh
	@./scripts/fetch_redis_chart.sh

deploy-redis:
	@python3 ./scripts/deploy_redis.py

deploy-redis-client:
	@python3 ./scripts/deploy_redis_client.py

redis-set:
	@python3 ./scripts/redis_operations.py set

redis-get:
	@python3 ./scripts/redis_operations.py get
