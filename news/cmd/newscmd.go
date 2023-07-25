package main

import (
	"fmt"
	logs "gateway/internal/log"
	"gateway/internal/tools"
	"gateway/news/pkg/config"
	"gateway/news/pkg/service"
	"net"
)

func main() {
	// парсим командную строку
	a, err := tools.ParseFile()
	if err != nil {
		fmt.Println("Parse file: ", err)
		return
	}
	if a.Help { // если есть help
		fmt.Println(config.Help())
		return
	}
	// файл конфигурации
	conf := config.New()
	err = conf.Load(a.Fileconfig) // загрузка конфигурации
	if err != nil {
		fmt.Println(conf)
		fmt.Println("Load config", err)
		return
	}
	//инициализация логгирования
	log := logs.New()
	logs.InitConfig(conf.Log(), a.Debug)
	defer logs.Close()
	log.Info("запуск приложения")
	log.Infoln("командная строка ", a)
	log.Debug(" Параметры конфигурации ", conf)
	log.Debug("настрока параметров соединения  сервера")
	lis, err := net.Listen("tcp", fmt.Sprintf("localhost:%d", conf.Port()))
	if err != nil {
		log.Fatalf("failed to listen: %v", err)
	}
	//подключение БД и страт сервера RPC
	err = service.RunServer(&lis)
	if err != nil {
		log.Fatalf("failed to listen: %v", err)
	}

}
