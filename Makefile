postgres:
	sudo docker run --name golang-course -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=4200 -d postgres
createdb:
	sudo docker exec -it golang-course createdb --username=root --owner=root simple-bank
dropdb:
	sudo docker exec -it golang-course dropdb simple-bank
migrateup:
	migrate -path db/migration -database "postgresql://root:4200@localhost:5432/simple-bank?sslmode=disable" -verbose up
migratedown:
	migrate -path db/migration -database "postgresql://root:4200@localhost:5432/simple-bank?sslmode=disable" -verbose down
sqlc:
	sqlc generate
test:
	go test -v -cover ./...
.PHONY: postgres createdb dropdb migrateup migratedown sqlc test
