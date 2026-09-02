.PHONY: lint format db-up db-down

db-up:
	docker compose up -d db

db-down:
	docker compose down

lint:
	cd frontend && npm run lint
	cd backend && golangci-lint run ./...

format:
	cd frontend && npm run format
	cd backend && gofmt -l -w .

.PHONY: migrate-up migrate-down sqlc-gen

migrate-up:
	cd backend && goose -dir migrations postgres "$$DATABASE_URL" up

migrate-down:
	cd backend && goose -dir migrations postgres "$$DATABASE_URL" down

sqlc-gen:
	cd backend && sqlc generate
