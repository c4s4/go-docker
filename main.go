package main

import (
	"fmt"
	"net/http"
	"runtime"
)

func setupHandler() *http.ServeMux {
	handler := http.NewServeMux()
	handler.HandleFunc("/hello", func(response http.ResponseWriter, request *http.Request) {
		fmt.Fprintf(response, "Hello from %s/%s!", runtime.GOOS, runtime.GOARCH)
	})
	return handler
}

func main() {
	handler := setupHandler()
	http.ListenAndServe(":8080", handler)
}
