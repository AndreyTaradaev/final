package log

// создание  singleton

import (
	"fmt"
	"os"
	"path"
	"runtime"
	"sync"
	"github.com/sirupsen/logrus"
	"gateway/internal/tools"
)

/* type Level int 

const (
Info Level = iota
Warning
Error
Debug
)
// для каналов
type LogChannel struct{
	ChLevel Level
	Message string
}
 */


var once sync.Once
var logger *logrus.Logger

// init setting log 

func InitConfig(dir string, debug bool) {
	exename := tools.FileNamewithoutExt(os.Args[0])	
	tf := logrus.TextFormatter{}
	tf.TimestampFormat ="02-Jan-2006 15:04:05.00"
	if len(dir) == 0 { // 
		logger.SetOutput(os.Stdout)
		tf.ForceColors = true
		tf.FullTimestamp = true

	} else {
		f, err := os.OpenFile(dir+"/"+exename +".log", os.O_RDWR|os.O_CREATE|os.O_APPEND, 0755)
		if err != nil {
			logger.SetOutput(os.Stdout)
			tf.ForceColors = true
			tf.FullTimestamp = true
		} else {
			logger.SetOutput(f)
			tf.DisableColors = true
			}
	}

	if debug {
		logger.SetLevel(logrus.DebugLevel)
		logger.SetReportCaller(true)
		tf.CallerPrettyfier = func(frame *runtime.Frame) ( string, string) {
			filename := path.Base(frame.File)
			return fmt.Sprintf("%s()", frame.Function), fmt.Sprintf("%s:%d", filename, frame.Line)
		}

	} else {
		logger.SetLevel(logrus.InfoLevel)
	}
	logger.SetFormatter(&tf)
}


// ctor for log singleton
func New() *logrus.Entry {
	exename := tools.FileNamewithoutExt(os.Args[0])		
	once.Do(func() {
		logger = logrus.New()
		//initConfig (dir, exename, debug)
	})
	
	return logger.WithField("app",exename )	
}

func Close() {
	logger.Writer().Close()
}

//func generateNameFile() string

//var logr  =
