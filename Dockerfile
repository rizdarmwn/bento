FROM golang:1.26.1-alpine

RUN mkdir -p /home/bento

WORKDIR /home/bento

COPY go.mod go.sum ./
RUN go mod download

COPY . .
RUN go build -o /home/bento ./...

EXPOSE 3000

RUN apk add dumb-init
ENTRYPOINT ["/usr/bin/dumb-init", "--"]

CMD ["./bento"]
