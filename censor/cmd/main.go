// программа является  машрутизатором от клиентов к микросервисам
// получается  сервер HTTP от клиентов -> клиент в нашем случае RPC
package main

import (
	"fmt"
	"gateway/censor/pkg/api"
	"gateway/censor/pkg/config"

	logs "gateway/internal/log"
	tools "gateway/internal/tools"
	"net/http"
)

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
	// инициализация маршрутизатора HTTP
	log.Info("Init Http router")
	api, err := api.New()
	if err != nil {
		log.Fatal(err)
	}

	Port := fmt.Sprintf(":%d", conf.СensorPort())
	log.Info("Init Http server")
	err = http.ListenAndServe(Port, api.Router())
	if err != nil {
		log.Fatal(err)
	}
}
