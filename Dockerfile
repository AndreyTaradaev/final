FROM golang:latest
RUN mkdir -p /go/src/final
RUN mkdir -p /go/src/final/apigw
RUN mkdir -p /go/src/final/internal
LABEL version="1.0.0"
WORKDIR /go/src/final
ADD apigw/  .
ADD internal/ .
ADD go.mod .
RUN go mod  tidy
RUN go install  apigw/ .
ADD  apigw/config.json /go/bin/
ADD  apigw/webapp /go/bin/
ENTRYPOINT ./website
EXPOSE 8080


# FROM alpine:latest
#LABEL version="1.0.0"
#LABEL maintainer="Ivan Ivanov<test@test.ru>"
#WORKDIR /root/
#COPY --from=0 /go/bin/website .
#ENTRYPOINT ./website
#EXPOSE 8080