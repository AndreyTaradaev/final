package rss

import (
	"gateway/apigw/pkg/rpc"
	"gateway/apigw/pkg/rpc/service"
	logs "gateway/internal/log"
	pb "gateway/internal/model"
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

	f := func(client rpc.LoadClient, url string) {
		nw, err := loadRss(url)
		if err != nil {
			logger.Error("urls: " + url + ", " + err.Error())
			return
		}
		if nw.Len() == 0 {
			logger.Debug("array is emply")
			return
		}
		logger.Debugf("urls: %s , loaded %d news", url, nw.Len())
		err = writeNews(client, nw)
		if err != nil {
			logger.Error("Load news on server  " + rpctarget + ", " + err.Error())
		}
	}

	for {
		select {
		case <-time.After(time.Second * time.Duration(sec)): // time.After вызывается 1 раз поэтому в цикле
			c, err := createClient(rpctarget)
			if err != nil {
				logger.Error("Error create connect", err)
				continue
			}
			defer c.Close()
			for _, v := range urls {
				go f(c, v)
			}
		}
	}

}

func createClient(target string) (rpc.LoadClient, error) {
	D, err := service.ConnectWithContext(target, 150)
	if err != nil {
		return nil, err
	}
	return D, nil
}

// отправка новостей на сервис, передача по RPC
func writeNews(client rpc.LoadClient, news *pb.ArrayShortNews) error {
	//создаем  клиента RPC

	//отправляем массив новостей на сервер
	err := client.AddNews(news)
	if err != nil {
		return err
	}
	return nil
}

// загрузка новостей с сервера
func loadRss(u string) (*pb.ArrayShortNews, error) {
	feed, err := rss.Fetch(u)
	if err != nil {
		return nil, err
	}
	a := pb.ArrayShortNews{Array: make([]*pb.ShortNew, 0)}

	for _, v := range feed.Items {
		n := pb.NewShort(0, v.Title, tags.StripTags(v.Summary), v.Date.Unix(), v.Link, v.ID)
		a.Array = append(a.Array, n)
	}
	return &a, nil
}
