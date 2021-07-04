# Parent makefile for Golang (https://github.com/c4s4/make)

BUILD_DIR = build
VERSION = 1.0.0

clean: # Clean generated files and test cache
	rm -rf $(BUILD_DIR)
	go clean -testcache
	go clean -cache

build: clean # Build go binary for docker
	mkdir -p $(BUILD_DIR)
	CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -ldflags "-X main.Version=$(VERSION) -s -f" -o $(BUILD_DIR)/go-docker .

docker: build # Build docker image
	docker build -t casa/go-docker .

run: docker # Run docker image
	docker run -p 8080:8080 casa/go-docker

client: # Run a client
	curl http://localhost:8080/hello

size: # Print image and binary sizes
	@docker inspect casa/go-docker | grep '"Size":'
	@ls -l build/go-docker
