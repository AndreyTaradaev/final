package rss

import (
	"github.com/SlyMarbo/rss"
	tags "github.com/grokify/html-strip-tags-go"

	"gateway/apigw/pkg/model"
	logs "gateway/internal/log"
	"time"
)

// загружает новости из массива urls.
func LoadNews(urls []string, min int) {
	logger := logs.New()
	logger.Info("запуск загрузки новостей")
	if len(urls) == 0 {
		logger.Warn("список серверов новостей пуст!")
		return
	}
	chTime := time.After(time.Second * time.Duration(min))

	func() {
		for {
			select {
			case <-chTime:
				for _, v := range urls {
					go Rss(v)
				}
			}
		}
	}()
}

// загрузка новостей с сервера  и передача по RPC
func Rss(u string) {
	logger := logs.New()
	logger.Debug("Загрузка новостей по адресу: " + u)
	feed, err := rss.Fetch(u)
	if err != nil {
		logger.Error("urls: " + u + ", " + err.Error())
		return
	}
	var news model.ShortNews

	for _, v := range feed.Items {
		n := model.NewShort(0, v.Title, tags.StripTags(v.Summary), v.Date.Unix(), v.Link, v.ID)
		news.Add(*n)
	}
	logger.Debugf("urls: %s , loaded %d news", u, news.Len())
}
