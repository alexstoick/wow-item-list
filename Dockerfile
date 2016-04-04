FROM golang

# Setting up working directory
WORKDIR /go/src/github.com/alexstoick/wow-item-list/
ADD . /go/src/github.com/alexstoick/wow-item-list/

RUN go get github.com/gin-gonic/gin
RUN go get gopkg.in/redis.v3

RUN CGO_ENABLED=0 GOOS=linux go build -ldflags "-s" -a -installsuffix cgo -o item_list

