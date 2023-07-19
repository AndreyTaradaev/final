package tools
import (
	"os"
	"path/filepath"
	"flag"
	"strings"
)

//имя файла конфига.
const filename string = "config.json"

// Вспомогательная структура парсинг командной строки.
type Arg struct{
	Fileconfig string
	Help bool
	Debug bool
}



// =================работа с командной строкой=======================================
// парсим командную строку возвращаем путь до конфиг файла, debug, help.
func ParseFile () (Arg,error){	
	var a Arg
	exe,err := os.Executable()
	if(err!=nil){
		return a, err
	}
	// получаем каталог и добавляем имя конф-файла по умолчанию
	s := filepath.Dir(exe)+"/"+filename	

	flag.StringVar(&a.Fileconfig,"config",s,"Path  config file")
	flag.BoolVar( &a.Help,"help",false,"man for app")	
	flag.BoolVar( &a.Help,"h",false,"man for app")	
	flag.BoolVar (&a.Debug,"debug",false,"enable debug")
	flag.BoolVar (&a.Debug,"d",false,"enable debug")
	flag.Parse()	
	return a,nil
}





// выводим  последний элемент пути.
func GetBase(path string) string{
	return filepath.Base(path)
}

//Имя файла без расширения
func FileNamewithoutExt(path string) string{
	f := filepath.Base(path)
if strings.HasSuffix(f,".exe"){
	f = strings.TrimSuffix(f,".exe")
}	
return f
}


func FileExists(path string) bool {
    _, err := os.Stat(path)
    return !os.IsNotExist(err)
}









