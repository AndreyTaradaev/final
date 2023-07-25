package main

import (
	"fmt"
	"gateway/apigw/pkg/api"
	"gateway/apigw/pkg/config"
	"gateway/apigw/pkg/rss"
	logs "gateway/internal/log"
	tools "gateway/internal/tools"
	"net/http"
	//"gateway/apigw/pkg/api"
	//"net/http"
	//"log"
)

// программа является  машрутизатором от клиентов к микросервисам
// получается  сервер HTTP от клиентов -> клиент в нашем случае RPC

func main() {
	//парсим командную строку
	a, err := tools.ParseFile()
	if err != nil {
		fmt.Println(err)
		return
	}
	if a.Help {
		fmt.Println(config.Help())
		return
	}
	// загрузка конфига
	conf := config.New()
	err = conf.Load(a.Fileconfig)
	if err != nil {
		fmt.Println(err)
		return
	}

	//инициализация логирования
	log := logs.New()
	logs.InitConfig(conf.Log(), a.Debug)
	defer logs.Close()
	log.Info("config loaded, start program....")
	log.Infoln("cmdline: ", a)

	log.Debugln("loaded config ", conf)
	// запускаем загрузку новостей
	newstarget := fmt.Sprintf("%s:%d", conf.Newshost(), conf.Newsport())
	go rss.LoadNews(newstarget, conf.Urls(), conf.Period())

	comenttarget := fmt.Sprintf("%s:%d", conf.СommentHost(), conf.СommentPort())

	log.Info("Start thread dowload rss")
	// инициализация маршрутизатора HTTP и  RPc соединения
	log.Info("Init Http router")
	api, err := api.New(newstarget, comenttarget)
	if err != nil {
		log.Fatal(err)
	}

	Port := fmt.Sprintf(":%d", conf.Port())
	log.Info("Init Http server")
	err = http.ListenAndServe(Port, api.Router())
	if err != nil {
		log.Fatal(err)
	}
}
