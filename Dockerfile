# Build
FROM golang:1.22.6-alpine AS builder
RUN apk add build-base libpcap-dev
WORKDIR /app
COPY . /app
WORKDIR /app/v2
RUN go mod download
RUN go build ./cmd/naabu

# Release
FROM alpine:3.19.1
RUN apk add nmap libpcap-dev bind-tools ca-certificates nmap-scripts
COPY --from=builder /app/v2/naabu /usr/local/bin/
ENTRYPOINT ["naabu"]
