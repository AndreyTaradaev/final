// конфигурация для микросервиса новостей
package config

// создание  singleton
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

type config_imp struct {
	Port   int    `json:"newsport,omitempty"` // port  на котором слушает микросервис новостей  по умолчанию 12345
	Logdir string `json:"logdir,omitempty"`   //  каталог куда пишем лог ,пустой пишем в stdout
	//	connstr string `json:"-"`
}

// справка по программе.
func Help() string {
	ex, _ := os.Executable()
	var h string = `программма ` + tools.GetBase(ex) + ` является  микросервисем новостей	 
	 использование  
	 ` + tools.GetBase(ex) + ` [-help]  [-config  <path>] [-debug]
	 параметры командной строки: 
	 -help  (-h) --данная справка 
	 -config  --путь до конфиг файл с которого надо загружаться если параметр не указан то ищет config.json 
	 			ищет его втом же каталоге где и расположен исполняемый файл
	 -debug  --включить отладку
	формат конфиг файла  JSON.
	структура файла:
	{		
		"newsport" :  порт  прослушиваения (число ,необязательный ) по умолчанию 12345		
		"logdir":       каталог куда пишем лог ,пустой пишем в stdout
	 }
	 необходима переменная среды окружения :
	 "NEWSDB=", формат  "postgres://<user>:<password>@<Host>:<Port>/<Database>
	 возможно загрузка параметров из переменнах среды окружения (имеет приоритет) 
	 NEWSPORT, LOGDIR
	 `
	return h
}

//=====================================================================================

// ctor for config-object
func New() *config {
	once.Do(func() {
		apiconfig = config{conf: config_imp{Port: 12345, Logdir: ""}}
	})
	return &apiconfig
}

// загрузка конфигурации из ENV

func (c *config) loadFromEnv() {
	variable := os.Getenv("NEWSPORT")
	if len(variable) != 0 {
		p, err := strconv.Atoi(variable)
		if err == nil {
			c.conf.Port = p
		}
	}
	variable = os.Getenv("LOGDIR")
	if len(variable) != 0 {
		c.conf.Logdir = variable
	}
}

// interface stringer
func (c *config) String() string {
	ret := fmt.Sprintf("newsport: %d, logdir: %s ", c.conf.Port, c.conf.Logdir)
	return ret
}

// загрузка конфигурации из файла
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
	}

	c.loadFromEnv()

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
