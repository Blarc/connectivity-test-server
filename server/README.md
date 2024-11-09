# Connectivity test server
The server is written in Go, and it responds only on path `/ping` with response `pong`.

## Environment
- go 1.22.7
- Docker engine

## Build, test and run
1. Move to server directory
   ```bash
   cd server
   ```
2. Build the app:
   ```bash
   go build
   ```
3. Run tests:
   ```bash
   go test
   ```
4. For running locally you have two options:
   1. run the built binary:
      ```bash
      ./connectivity-test-server
      ```
   2. run with go:
      ```bash
      go run main.go
      ```
   
