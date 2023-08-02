// реализация файла конфигурации создает единственный экземпляр .
package config

import (
	"encoding/json"
	"fmt"
	"gateway/internal/tools"
	"io/ioutil"
	"os"
	"path/filepath"	
	"strings"
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
	Urls        []string `json:"rss,omitempty"`            // список ссылок на сервера  по умолчанию пустой
	Period      int      `json:"request_period,omitempty"` // врямя через какое  нужно обновлять новости  по умолчанию 300 сек.
	Port        int      `json:"port,omitempty"`           // порт который прослушивает gateway по умолчанию 8080
	NewsHost    string   `json:"newshost,omitempty"`       //  адрес  на котором слушает микросервис новостей  по умолчанию localhost
	NewsPort    int      `json:"newsport,omitempty"`       //  port  на котором слушает микросервис новостей  по умолчанию 12345
	CommentHost string   `json:"commenthost,omitempty"`    //  адрес  на котором слушает микросервис коментариев  по умолчанию localhost
	CommentPort int      `json:"commentport,omitempty"`    //  port  на котором слушает микросервис комментариев  по умолчанию 12346
	CensorPort  int      `json:"censorport,omitempty"`     //  port  на котором слушает микросервис цензуры по умолчанию 12347
	CensorHost  string   `json:"censorhost,omitempty"`     //  адрес  на котором слушает микросервис цензуры  по умолчанию localhost
	Logdir      string   `json:"logdir,omitempty"`         //  каталог куда пишем лог ,пустой пишем в stdout
}

// справка по программе.
func Help() string {
	ex, _ := os.Executable()
	var h string
	h = `программма ` + tools.GetBase(ex) + ` является  маршрутизатором между клиентом и и микросервисами новостей
и комментариев. 
использование: 
` + tools.GetBase(ex) + ` [-help]  [-config  <path>] [-debug]
параметры командной строки: 
	-help  (-h) --данная справка 
	-config  --   путь до  файла конфигурации				
	-debug  --включить отладку
формат конфиг файла: JSON.
структура файла:
{
"rss":[
  		<список  серверов новостей> по умолчанию пустой
	  ],
"period":         период обновления (число секунд между обновлениями) по умолчанию 300
"port":           порт  прослушиваения (число ,необязательный ) по умолчанию 8080
"newshost":       адрес   микросервиса новостей  (строка ,необязательный ) 
				  по умолчанию "localhost"
"newsport":       port  на котором слушает микросервис новостей (число ,необязательный )
	  			  по умолчанию 12345
"commenthost":    адрес  на котором слушает микросервис коментариев  (строка ,необязательный )
	  			  по умолчанию "localhost"
"commentport":   port  на котором слушает микросервис комментариев(число ,необязательный )
 	 			  по умолчанию 12346
"censorport"     port  на котором слушает микросервис цензуры по умолчанию 12347
"censorhost"     адрес  на котором слушает микросервис цензуры  по умолчанию localhost
"Logdir":        каталог сохранения журнала работы приложения   (пустая строка вывод в консоль) 	  	
}
загрузка настроек по умолчанию происходит из файла конфигурации   config.json 
в параметрах командной строки  можно загрузку  альтернативной  конфигурации
также поддерживается загрузка параметров конфигурации из переменных среды окружения:
URLS, PERIOD,PORT, NEWSHOST,NEWSPORT,COMMENTHOST,COMMENTPORT,LOGDIR, CENSORHOST,CENSORPORT
переменные окружения имеют приоритет перед файлом
	 `
	return h
}

//=====================================================================================

// ctor for config-object
func New() *config {
	once.Do(func() {
		apiconfig = config{
			conf: config_imp{Urls: []string{},
				Period:      300,
				Port:        8080,
				NewsHost:    "localhost",
				NewsPort:    12345,
				CommentHost: "localhost",
				CommentPort: 12346,
				CensorPort:  12347,
				CensorHost:  "localhost",
				Logdir:      "", // в stdout
			},
		}
	})
	return &apiconfig
}

// загрузка переменных в среду оуружения
func (c *config) loadFromEnv() {
	variable := os.Getenv("URLS")
	if len(variable) != 0 {
		splitFunc := func(r rune) bool {
			return strings.ContainsRune(" ;,", r)
		}
		c.conf.Urls = strings.FieldsFunc(variable, splitFunc)
	}
	variable = os.Getenv("PERIOD")
	if len(variable) != 0 {
		c.conf.Period = int(tools.GetIntDef(variable, int64(c.conf.Period)))
	}
	variable = os.Getenv("PORT")
	if len(variable) != 0 {
		c.conf.Port = int(tools.GetIntDef(variable, int64(c.conf.Port)))
	}

	variable = os.Getenv("NEWSHOST")
	if len(variable) != 0 {
		c.conf.NewsHost = variable
	}
	variable = os.Getenv("NEWSPORT")
	if len(variable) != 0 {		
			c.conf.NewsPort = int(tools.GetIntDef(variable, int64(c.conf.NewsPort)))		
	}

	variable = os.Getenv("COMMENTHOST")
	if len(variable) != 0 {
		c.conf.CommentHost = variable
	}
	variable = os.Getenv("COMMENTPORT")
	if len(variable) != 0 {		
			c.conf.CommentPort = int(tools.GetIntDef(variable, int64(c.conf.CommentPort)))		
	}
	variable = os.Getenv("CENSORHOST")
	if len(variable) != 0 {
		c.conf.CensorHost = variable
	}
	variable = os.Getenv("CENSORPORT")
	if len(variable) != 0 {	
			c.conf.CensorPort = int(tools.GetIntDef(variable, int64(c.conf.CensorPort)))		
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
	if c.conf.Port == 0 {
		c.conf.Port = 8080
	}
	if len(c.conf.NewsHost) == 0 {
		c.conf.NewsHost = "localhost"
	}
	if c.conf.NewsPort == 0 {
		c.conf.NewsPort = 12345
	}
	if len(c.conf.CommentHost) == 0 {
		c.conf.CommentHost = "localhost"
	}
	if c.conf.CommentPort == 0 {
		c.conf.CommentPort = 12346
	}
	if len(c.conf.CensorHost) == 0 {
		c.conf.CensorHost = "localhost"
	}
	if c.conf.CensorPort == 0 {
		c.conf.CensorPort = 12347
	}
	return nil
}

func (c *config) String() string {
	var ret string = "Urls: "
	for _, v := range c.conf.Urls {
		ret += "\n\t" + v
	}
	ret += fmt.Sprintf("\nPeriod: %d\nPort: %d,\nNewsHost: %s\n NewsPort: %d\nCommentHost: %s\nCommmentPort: %d, \nCensorHost: %s\nCensorPort: %d  \nLogDir: %s",
		c.conf.Period, c.conf.Port, c.conf.NewsHost, c.conf.NewsPort, c.conf.CommentHost, c.conf.CommentPort, c.conf.CensorHost, c.conf.CensorPort, c.conf.Logdir)
	return ret
}

// геттер списка серверов .
func (c *config) Urls() []string {
	return c.conf.Urls
}

// геттер  время обновления.
func (c *config) Period() int {
	return c.conf.Period
}

// геттер  порт сервера .
func (c *config) Port() int {
	return c.conf.Port
}

// геттер адрес сервера новостей.
func (c *config) Newshost() string {
	return c.conf.NewsHost
}

// геттер порт сервера новостей .
func (c *config) Newsport() int {
	return c.conf.NewsPort
}

// геттер адрес сервера коментов .
func (c *config) СommentHost() string {
	return c.conf.CommentHost
}

// геттер порт сервера коментов .
func (c *config) СommentPort() int {
	return c.conf.CommentPort
}

// геттер адрес сервера цензуры .
func (c *config) CensorHost() string {
	return c.conf.CensorHost
}

// геттер порт сервера цензуры.
func (c *config) СensorPort() int {
	return c.conf.CensorPort
}

// каталог логов
func (c *config) Log() string {
	return c.conf.Logdir
}
