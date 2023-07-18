// загрузка новостей с серверов новостей

package model 
import (
"hash/crc64"

)


//краткая новость для списка  новостей

type  Short struct{
	ID          int64  `json:"ID"` // номер записи
	Title       string `json:"Title"`  // заголовок публикации
	Description string  `json:"Content"`  // содержание публикации
	Time        int64  `json:"PubTime"`   // время публикации
	Url         string `json:"Link"`   // ссылка на источник
	Hash        uint64 `json:"Guid"`   //uid новости для  контроля дубликатов
}

// конструктор для записи новости
func NewShort(id int64, title, desc string, time int64,url, Uid string ) *Short{
	ret := Short{
		ID :id, 
		Title : title,
		Description : desc,
		Time :time,
		Url  : url , 	
	}
	ret.Hash =  crc64.Checksum([]byte(Uid),crc64.MakeTable(crc64.ISO))
	return &ret
	}



type ShortNews struct{
  News	[]Short
}

func (s  *ShortNews) Add ( sh ...Short) {
	s.News = append(s.News,sh...)	 	
}

func (s  *ShortNews) Len () int {
	return len(s.News)
}



// Структура коментариея для обработки.
type Comment struct{
	Id        int64    `json:"id"`
	Parent     int64    `json:"parent"`	
	Content   string `json:"content"`
	AuthorId  int64    `json:"authorid"`
	Author string    `json:"author"`
	Timestamp int64    `json:"time"`
	Answer [] * Comment `json:"anwser"`
}

// ctor for comment
func CreateComment(Id,Par int64, Cont, Aut string, AutId, time int64  ) *Comment {
	c := new (Comment)
	c.Id = Id
	c.Parent = Par
	c.Content = Cont
	c.AuthorId =  AutId
	c.Author = Aut
	c.Timestamp = time	
	return c
}
//add child comment
func (parent* Comment ) Add(child ... *Comment){
	parent.Answer = append(parent.Answer,child... )
}

type FullNew struct{
	ID          int64  `json:"ID"` // номер записи
	Title       string `json:"Title"`  // заголовок публикации
	//Description string  `json:"Content"`  // содержание публикации
	Time        int64  `json:"PubTime"`   // время публикации
	Url         string `json:"Link"`   // ссылка на источник
	Hash        uint64 `json:"Guid"`   //uid новости для  контроля дубликатов

}




