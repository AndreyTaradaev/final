package main

import (
	"fmt"
	"gateway/apigw/pkg/config"
	"gateway/apigw/pkg/rss"
	logs "gateway/internal/log"
	tools "gateway/internal/tools"
	"gateway/apigw/pkg/api"
	"net/http"
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
	err = conf.Load(&a.Fileconfig)
	if err != nil {
		fmt.Println(err)
		return
	}
	//инициализация логирования
	log := logs.New()
	defer logs.Close()
	logs.InitConfig(conf.Log(), a.Debug)
	log.Info("config loaded, start program....")
	log.Debugln("cmdline ", fmt.Sprintf("%#v", a))

	log.Debugln("loaded config ", fmt.Sprintf("%#v", conf))
	// запускаем загрузку новостей

	rss.LoadNews(conf.Urls() , conf.Period())
	api := api.New() 

	Port := fmt.Sprintf(":%d",conf.Port())
	err  =http.ListenAndServe(Port, api.Router())
    if err != nil {
       log.Fatal(err)
    }	
	
	log.Info("Exit app...")
}
