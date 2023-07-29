// модель   новостей
// сокращенная новость используется в списке новостей сокращено содержание новости (когда необходим весь список
//
//	весь список).
//
// полная новость когда необходимо вывести страницу новостей
// детальная новость  отдельная новость с коментариями.
package model

import (
	pb "gateway/internal/rpc"
	"hash/crc64"
)

// количество новостей на странице
const Limit int = 20

//структура сокращенной новости

type Short struct {
	ID          int64  `json:"ID"`      // номер записи
	Title       string `json:"Title"`   // заголовок публикации
	Description string `json:"Content"` // содержание публикации
	Time        int64  `json:"PubTime"` // время публикации
	Url         string `json:"Link"`    // ссылка на источник
	Hash        int64  `json:"Guid"`    //uid новости для  контроля дубликатов
}

// конструктор для  новости.
func NewShort(id int64, title, desc string, time int64, url, Uid string) *Short {
	ret := Short{
		ID:          id,
		Title:       title,
		Description: desc,
		Time:        time,
		Url:         url,
	}
	ret.Hash = int64(crc64.Checksum([]byte(Uid), crc64.MakeTable(crc64.ISO)))
	return &ret
}

func CreateShort(id *int64, title, desc *string, time *int64, url *string, hash *int64) *Short {
	sh := Short{}
	if id != nil {
		sh.ID = *id
	} else {
		sh.ID = 0
	}
	if title != nil {
		sh.Title = *title
	} else {
		sh.Title = ""
	}
	if desc != nil {
		sh.Description = *desc
	} else {
		sh.Description = ""
	}
	if time != nil {
		sh.Time = *time
	} else {
		sh.Time = 0
	}
	if url != nil {
		sh.Url = *url
	} else {
		sh.Url = ""
	}
	if hash != nil {
		sh.Hash = *hash
	} else {
		sh.Hash = 0
	}
	return &sh
}

// Конвертирует данные из модели RPC в модель приложения
/* func (s *Short) Convert(i *pb.ShortNew) {
	s.ID = i.GetID()
	s.Title = i.GetTitle()
	s.Description = i.GetDescription()
	s.Time = i.GetTime()
	s.Url = i.GetUrl()
	s.Hash = i.GetHash()
} */

// массив новостей.
type ShortNews struct {
	news []Short
}

// добавление элементов в массив.
func (s *ShortNews) Add(sh ...Short) {
	s.news = append(s.news, sh...)
}

// добавление из данных
func (s *ShortNews) AddFromData(id *int64, title, desc *string, time *int64, url *string, hash *int64) {
	sh := CreateShort(id, title, desc, time, url, hash)
	s.news = append(s.news, *sh)
}

// Добавление новости из  модели RPC.
func (s *ShortNews) Append(i *pb.ShortNew) {
	sh := Short{}
	sh.Convert(i)
	s.news = append(s.news, sh)
}

// размер массива новостей.
func (s *ShortNews) Len() int {
	return len(s.news)
}

// получить сам массив новостей
func (s *ShortNews) Get() []Short {
	return s.news
}

// структура коментариев.
// Структура коментариея для обработки.
type Comment struct {
	IdComment *int64             `json:"id,omitempty"`
	Parent    *int64             `json:"parent,omitempty"`
	Content   string             `json:"content"`
	IdNews    int64              `json:"idnews"`
	AuthorId  int64              `json:"authorid,omitempty"`
	Author    *string            `json:"author,omitempty"`
	Time      int64              `json:"time"`
	Answer    map[int64]*Comment `json:"anwser,omitempty"`
}

// ctor for comment
func CreateComment(Id, Par *int64, Cont string, Aut *string, AutId int64, time int64) *Comment {
	c := new(Comment)
	c.IdComment = Id
	c.Parent = Par
	c.Content = Cont
	c.AuthorId = AutId
	c.Author = Aut
	c.Time = time
	c.Answer = make(map[int64]*Comment)
	return c
}

type Full struct {
	Rss    Short
	Answer []*Comment
}

// add child comment
func (parent *Comment) Add(child ...*Comment) {
	for _, v := range child {
		parent.Answer[*v.IdComment] = v

	}
}

type FullNew struct {
	ID    int64  `json:"ID"`    // номер записи
	Title string `json:"Title"` // заголовок публикации
	//Description string  `json:"Content"`  // содержание публикации
	Time int64  `json:"PubTime"` // время публикации
	Url  string `json:"Link"`    // ссылка на источник
	Hash uint64 `json:"Guid"`    //uid новости для  контроля дубликатов

}
