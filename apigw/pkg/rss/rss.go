package rss

import (
	"gateway/apigw/pkg/rpcclient"
	logs "gateway/internal/log"
	"gateway/internal/model"
	"time"

	"github.com/SlyMarbo/rss"
	tags "github.com/grokify/html-strip-tags-go"
)

// создает  цикл периодически загружает новости из массива urls в отдельных потоках.
func LoadNews(rpctarget string, urls []string, sec int) {
	logger := logs.New()
	logger.Info("запуск потока загрузки новостей")
	if len(urls) == 0 {
		logger.Warn("список серверов новостей пуст!")
		return
	}

	f := func(url, target string) {
		nw, err := loadrss(url)
		if err != nil {
			logger.Error("urls: " + url + ", " + err.Error())
			return
		}
		if nw.Len() == 0 {
			logger.Debug("not found load news")
			return
		}
		logger.Debugf("urls: %s , loaded %d news", url, nw.Len())
		err = writeNews(rpctarget, nw)
		if err != nil {
			logger.Error("Load news on server  " + rpctarget + ", " + err.Error())
		}
	}

	for {
		select {
		case <-time.After(time.Second * time.Duration(sec)): // time.After вызывается 1 раз поэтому в цикле
			for _, v := range urls {
				go f(v, rpctarget)
			}
		}
	}

}

// отправка новостей на сервис, передача по RPC
func writeNews(target string, news *model.ShortNews) error {
	//создаем  клиента RPC
	D, err := rpcclient.ConnectWithContext(target, 150)
	if err != nil {
		return err
	}
	defer D.Close()
	//отправляем массив новостей на сервер
	err = D.AddNews(news)
	if err != nil {
		return err
	}
	return nil
}

// загрузка новостей с сервера
func loadrss(u string) (*model.ShortNews, error) {
	feed, err := rss.Fetch(u)
	if err != nil {
		return nil, err
	}
	var news model.ShortNews

	for _, v := range feed.Items {
		n := model.NewShort(0, v.Title, tags.StripTags(v.Summary), v.Date.Unix(), v.Link, v.ID)
		news.Add(*n)
	}
	return &news, nil
}
