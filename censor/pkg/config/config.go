// реализация файла конфигурации создает единственный экземпляр .
package config

import (
	"encoding/json"
	"fmt"
	"gateway/internal/tools"
	"io/ioutil"
	"os"
	"path/filepath"
	"strconv"
	"sync"
)

var once sync.Once
var apiconfig config

// члены структуры закрыты для доступа и изменения , доступ к значениям через геттер
type config struct {
	conf config_imp
}

// пряиой доступ к членам запрещен
type config_imp struct {
	CensorPort int    `json:"censorport,omitempty"` //  port  на котором слушает микросервис цензуры по умолчанию 12347
	Logdir     string `json:"logdir,omitempty"`     //  каталог куда пишем лог ,пустой пишем в stdout
}

// справка по программе.
func Help() string {
	ex, _ := os.Executable()
	var h string
	h = `программма ` + tools.GetBase(ex) + ` является  микросервисем цензуры . 
использование: 
` + tools.GetBase(ex) + ` [-help]  [-config  <path>] [-debug]
параметры командной строки: 
	-help  (-h) --данная справка 
	-config  --   путь до  файла конфигурации				
	-debug  --включить отладку
формат конфиг файла: JSON.
структура файла:
{
"censorport"     port  на котором слушает микросервис цензуры по умолчанию 12347
"censorhost"     адрес  на котором слушает микросервис цензуры  по умолчанию localhost
"Logdir":        каталог сохранения журнала работы приложения   (пустая строка вывод в консоль) 	  	
}
загрузка настроек по умолчанию происходит из файла конфигурации   config.json 
в параметрах командной строки  можно загрузку  альтернативной  конфигурации
также поддерживается загрузка параметров конфигурации из переменных среды окружения:
CENSORPORT, LOGDIR
переменные окружения имеют приоритет перед файлом
запрещенные слова хранятся в БД 
для подключения требуется переменная окружения CENSORDB формат: 
postgres://[user]:[passwd]@[host]:[port]/[database]
	 `
	return h
}

//=====================================================================================

// ctor for config-object
func New() *config {
	once.Do(func() {
		apiconfig = config{
			conf: config_imp{
				CensorPort: 12347,
				Logdir:     "", // в stdout
			},
		}
	})
	return &apiconfig
}

// загрузка переменных в среду оуружения
func (c *config) loadFromEnv() {

	variable := os.Getenv("CENSORPORT")
	if len(variable) != 0 {
		p, err := strconv.Atoi(variable)
		if err == nil {
			c.conf.CensorPort = p
		}
	}
	variable = os.Getenv("Logdir")
	if len(variable) != 0 {
		c.conf.Logdir = variable
	}
}

// загрузка конфигурации из файла или из Переменных окружения
func (c *config) Load(file string) error {
	//если	 file пустой ищем  конфиг  в  директории исполняемого файла
	if len(file) == 0 {
		exe, err := os.Executable()
		if err != nil {
			return err
		}
		file = filepath.Dir(exe) + "/" + tools.FileConfig()
	}
	b, err := ioutil.ReadFile(file)
	if err == nil {
		json.Unmarshal(b, &c.conf)
	} else {
		fmt.Println(err)
	}
	// from env
	c.loadFromEnv()
	// проверка на корректность
	if c.conf.CensorPort == 0 {
		c.conf.CensorPort = 12347
	}
	return nil
}

func (c *config) String() string {
	ret := fmt.Sprintf("CensorPort: %d  \nLogDir: %s",
		c.conf.CensorPort, c.conf.Logdir)
	return ret
}

// геттер порт сервера цензуры.
func (c *config) СensorPort() int {
	return c.conf.CensorPort
}

// каталог логов
func (c *config) Log() string {
	return c.conf.Logdir
}
