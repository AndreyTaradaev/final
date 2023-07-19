package main

import (
	"fmt"
	logs "gateway/internal/log"
	"gateway/internal/tools"
	"gateway/news/pkg/config"
	"gateway/news/pkg/storage"
)

func main() {
	// парсим командную строку
	a, err := tools.ParseFile()
	if err != nil {
		fmt.Println("Parse file: ",err)
		return
	}	
	if a.Help { // если есть help
		
		fmt.Println(config.Help())
		return
	}
	// файл конфигурации
	conf := config.New()	
	err = conf.Load(&a.Fileconfig) // загрузка конфигурации
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
	log.Info("подключение к Базе Данных")
	// инициализация подключения к БД
	db, err := storage.New()
	if err != nil {
		fmt.Println(err)
		log.Fatal(err)
	}
	defer db.Close()

}
