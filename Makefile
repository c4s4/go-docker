BUILD_DIR = build
GOOS = linux
GOARCH = amd64
IMAGE = casa/go-docker

clean: # Clean generated files and caches
	rm -rf $(BUILD_DIR)
	go clean -cache
	go clean -testcache

build: clean # Build go binary for docker
	mkdir -p $(BUILD_DIR)
	GOOS=$(GOOS) GOARCH=$(GOARCH) go build -ldflags "-w -s" -o $(BUILD_DIR)/go-docker .

docker: build # Build docker image
	docker buildx build --platform=$(GOOS)/$(GOARCH) -t $(IMAGE) .

run: docker # Run docker image
	docker run -p 8080:8080 $(IMAGE)

client: # Run a client
	curl http://localhost:8080/hello

size: # Print image and binary sizes
	@docker inspect $(IMAGE) | grep '"Size":'
	@ls -l build/go-docker
