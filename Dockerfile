FROM scratch

ADD build/go-docker /

ENTRYPOINT ["/go-docker"]
