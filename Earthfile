FROM golang:1.17-alpine3.13
WORKDIR /

build:
    COPY main.go .
    RUN go build -ldflags "-w -s" -o go-docker main.go
    SAVE ARTIFACT go-docker / AS LOCAL go-docker

docker:
    FROM scratch
    WORKDIR /
    COPY +build/go-docker .
    ENTRYPOINT ["/go-docker"]
    SAVE IMAGE go-docker:latest
