package config

// создание  singleton
import (
	"encoding/json"
	"gateway/internal/tools"
	"io/ioutil"
	"os"
	"path/filepath"
	"sync"
)

var once sync.Once
var apiconfig config

// члены структуры закрыты для доступа и изменения , доступ к значениям через геттер
type config struct {
	conf config_imp
}

type config_imp struct {
	Urls        []string `json:"rss"`                   // список ссылок на сервера  по умолчанию пустой
	Period      int      `json:"request_period"`        // врямя через какое  нужно обновлять новости  по умолчанию 300 сек.
	Port        int      `json:"port,omitempty"`        // порт который прослушивает gateway по умолчанию 8080
	NewsHost    string   `json:"newshost,omitempty"`    //  адрес  на котором слушает микросервис новостей  по умолчанию localhost
	NewsPort    int      `json:"newsport,omitempty"`    //  port  на котором слушает микросервис новостей  по умолчанию 12345
	CommentHost string   `json:"commenthost,omitempty"` //  адрес  на котором слушает микросервис коментариев  по умолчанию localhost
	CommentPort int      `json:"commentport,omitempty"` //  port  на котором слушает микросервис комментариев  по умолчанию 12346
	Logdir      string   `json:"logdir,omitempty"`      //  каталог куда пишем лог ,пустой пишем в stdout
}

// имя файла конфига
const filename string = "config.json"

// справка по программе.
func Help() string {
	ex, _ := os.Executable()
	var h string
	h = `программма ` + tools.GetBase(ex) + ` является  маршрутизатором между клиентом и и микросервисами новостей
	 и комментариев 
	 использование  
	 ` + tools.GetBase(ex) + ` [-help]  [-config  <path>] [-debug]
	 параметры командной строки: 
	 -help  (-h) --данная справка 
	 -config  --путь до конфиг файл с которого надо загружаться если параметр не указан то ищет config.json 
	 			ищет его втом же каталоге где и расположен исполняемый файл
	 -debug  --включить отладку
	формат конфиг файла --  JSON.
	структура файла:
	{
		"rss":[
			<список  серверов новостей>
		],
		"period": период обновления (число)
		"port" :  порт  прослушиваения (число ,необязательный ) по умолчанию 8080
		"newshost":   адрес   микросервиса новостей  (строка ,необязательный ) 
				по умолчанию localhost
		"newsport":   port  на котором слушает микросервис новостей (число ,необязательный )
			  по умолчанию 12345
	    "commenthost":   адрес  на котором слушает микросервис коментариев  (строка ,необязательный )
			  по умолчанию localhost
	     "commentport": port  на котором слушает микросервис комментариев(число ,необязательный )
		 	  по умолчанию 12346	
	 }

	 `
	return h
}

//=====================================================================================

// ctor for config-object
func New() *config {
	once.Do(func() {
		apiconfig = config{}
	})
	return &apiconfig
}

// загрузка конфигурации
func (c *config) Load(file *string) error {
	//если	 file пустой ищем  конфиг  в  директории исполняемого файла
	var s string
	if file == nil {
		exe, err := os.Executable()
		if err != nil {
			return err
		}
		s = filepath.Dir(exe) + "/" + filename
	} else {
		s = *file
	}

	b, err := ioutil.ReadFile(s)
	if err != nil {
		return err
	}
	err = json.Unmarshal(b, &c.conf)
	if err != nil {
		return err
	}

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
	return nil
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

// каталог логов
func (c *config) Log() string {
	return c.conf.Logdir
}
