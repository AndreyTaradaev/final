package rss

import (
	"gateway/internal/model"
	"gateway/apigw/pkg/service"
	logs "gateway/internal/log"
	"time"

	"github.com/SlyMarbo/rss"
	tags "github.com/grokify/html-strip-tags-go"
)

// создает  цикл периодически загружает новости из массива urls в отдельных потоках.
func LoadNews(urls []string, min int,rpctarget string  ) {
	logger := logs.New()
	logger.Info("запуск потока загрузки новостей")
	if len(urls) == 0 {
		logger.Warn("список серверов новостей пуст!")
		return
	}

	for {
		select {
		case <-time.After(time.Minute * time.Duration(min)): // time.After вызывается 1 раз поэтому в цикле
			for _, v := range urls {
				go loadrss(v,rpctarget)
			}
		}
	}

}

// загрузка новостей с сервера  и передача по RPC
func loadrss(u string , rpctarget string) {
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
	//создаем  клиента RPC
	D, err := service.Init(rpctarget)
	if err != nil {
		logger.Error(err)
		return
	}
	defer D.Close()
	//отправляем массив новостей на сервер
	err = D.RunRssServiceAddNews(news)
	if err != nil {
		logger.Error(err)
	}
}
