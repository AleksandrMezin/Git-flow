FROM golang:1.22 as builder

ENV GO111MODULE=on \
    CGO_ENABLED=0 \
    GOOS=linux \
    GOARCH=amd64

WORKDIR /app

COPY go.mod .
COPY go.sum .
RUN go mod download

COPY . .

RUN go build -o main .

FROM alpine:latest  

COPY --from=builder /app/main .

EXPOSE 8080

CMD ["./main"]