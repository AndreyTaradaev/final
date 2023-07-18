package main

import (
	"fmt"
	"gateway/internal/tools"
	"gateway/news/pkg/config"
)

func main (){
	a, err := tools.ParseFile()
	if err != nil {
		fmt.Println(err)
		return
	}
	fmt.Println(a)
	if a.Help {
		fmt.Println(config.Help())
		return
	}


	
}