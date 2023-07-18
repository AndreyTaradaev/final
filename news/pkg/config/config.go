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
	Port   int    `json:"port,omitempty"`   // port  на котором слушает микросервис новостей  по умолчанию 12345
	Logdir string `json:"logdir,omitempty"` //  каталог куда пишем лог ,пустой пишем в stdout
}

// имя файла конфига
const filename string = "config.json"

// справка по программе.
func Help() string {
	ex, _ := os.Executable()
	var h string
	h = `программма ` + tools.GetBase(ex) + ` является  микросервисем новостей	 
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
		"port" :  порт  прослушиваения (число ,необязательный ) по умолчанию 12345		
		"logdir":       каталог куда пишем лог ,пустой пишем в stdout
	 }
	 необходима переменная среды окружения :
	 NEWS_DB, формат  "postgres://<user>:<password>@<Host>:<Port>/<Database>
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
		c.conf.Port = 12345
	}
	return nil
}

// геттер  порт сервера .
func (c *config) Port() int {
	return c.conf.Port
}

// каталог логов
func (c *config) Log() string {
	return c.conf.Logdir
}
