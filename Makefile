postgres:
	sudo docker run --name golang-course --network bank-network -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=4200 -d postgres
createdb:
	sudo docker exec -it golang-course createdb --username=root --owner=root simple-bank
dropdb:
	sudo docker exec -it golang-course dropdb simple-bank
migrateup:
	migrate -path db/migration -database "postgresql://root:4200@localhost:5432/simple-bank?sslmode=disable" -verbose up
migrateup1:
	migrate -path db/migration -database "postgresql://root:4200@localhost:5432/simple-bank?sslmode=disable" -verbose up 1
migratedown:
	migrate -path db/migration -database "postgresql://root:4200@localhost:5432/simple-bank?sslmode=disable" -verbose down
migratedown1:
	migrate -path db/migration -database "postgresql://root:4200@localhost:5432/simple-bank?sslmode=disable" -verbose down 1
sqlc:
	sqlc generate
test:
	go test -v -cover ./...
server:
	go run main.go
mock:
	mockgen --package mockdb --destination db/mock/store.go course-youtube/db/sqlc Store 
proto:
	protoc --proto_path=proto --go_out=pb --go_opt=paths=source_relative \
		--go-grpc_out=pb --go-grpc_opt=paths=source_relative \
		proto/*.proto
.PHONY: postgres createdb dropdb migrateup migratedown migrateup1 migratedown1 sqlc test server mock proto
