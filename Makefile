test:
	docker compose down
	docker compose up -d
	npm i
	npm run test || true
	docker compose down
