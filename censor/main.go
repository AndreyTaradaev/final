// микросервис проверки комментариев
package main

import (
	"fmt"
	_ "gateway/censor/docs"
	"gateway/censor/pkg/api"
	"gateway/censor/pkg/config"
	logs "gateway/internal/log"
	tools "gateway/internal/tools"
	"net/http"
)

// @title Check Comment API
// @version 1.0
// @description  Проверка Коментариев на запрещенные слова
// @tag.name  CheckedComment
// @termsOfService http://swagger.io/terms/
// @contact.name API Support
// @contact.email ataradaev@swagger.io
// @license.name Apache 2.0
// @license.url http://www.apache.org/licenses/LICENSE-2.0.html
// @BasePath /

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

	log.Info("Init Http server on ", Port)
	err = http.ListenAndServe(Port, api.Router())
	if err != nil {
		log.Fatal(err)
	}
}
