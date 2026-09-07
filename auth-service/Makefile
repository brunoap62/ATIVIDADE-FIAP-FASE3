.PHONY: test test-cover build tidy clean

test:
	go test -v ./...

test-cover:
	go test -v -coverprofile=coverage.out ./...
	go tool cover -func=coverage.out

build:
	CGO_ENABLED=0 go build -v -o auth-service .

tidy:
	go mod tidy

clean:
	rm -f auth-service coverage.out
