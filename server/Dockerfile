# start a golang base image, version 1.8
FROM golang:1.22.7-alpine as build
#switch to our app directory
WORKDIR /app
#copy the source files
COPY go.mod ./

RUN go mod download

COPY *.go ./
#disable crosscompiling
ENV CGO_ENABLED=0
#compile linux only
ENV GOOS=linux
#build the binary with debug information removed
RUN go build -ldflags '-w -s' -a -installsuffix cgo -o /main main.go

# start with a scratch (no layers)
FROM scratch
# copy the ca certificates from the build image
COPY --from=build /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
# copy our static linked library
COPY --from=build main main
# tell we are exposing our service on port 9393
EXPOSE 8080
# run it!
ENTRYPOINT ["/main"]
