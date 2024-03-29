package controllers

import (
	"fmt"
	"github.com/gin-gonic/gin"
	"os"
)

var REDIS_SET_KEY = os.Getenv("REDIS_SET_KEY")

func GetList(c *gin.Context) {
	redis := FetchRedisFromContext(c)
	lol := redis.SMembers(REDIS_SET_KEY)
	c.JSON(200, lol.Val())
}

func AddItem(c *gin.Context) {
	redis := FetchRedisFromContext(c)
	err := redis.SAdd(REDIS_SET_KEY, c.Param("id"))
	fmt.Println(err)
	c.JSON(200, err)
}

func RemoveItem(c *gin.Context) {
	redis := FetchRedisFromContext(c)
	err := redis.SRem(REDIS_SET_KEY, c.Param("id"))
	fmt.Println(err)
	c.JSON(200, err)
}
