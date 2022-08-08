FROM golang:1.18 as builder
WORKDIR /app
RUN go mod init myserver
COPY . .
RUN CGO_ANABLED=0 GOOS=linux GOARCH=amd64 go build -o server

FROM scratch
COPY --from=builder /app/server /server
ENTRYPOINT [ "/server" ]