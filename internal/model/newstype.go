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

// Конвертирует данные из модели RPC в модель приложения
func (s *Short) Convert(i *pb.ShortNew) {
	s.ID = i.GetID()
	s.Title = i.GetTitle()
	s.Description = i.GetDescription()
	s.Time = i.GetTime()
	s.Url = i.GetUrl()
	s.Hash = i.GetHash()
}

// массив новостей.
type ShortNews struct {
	news []Short
}

// добавление элементов в массив.
func (s *ShortNews) Add(sh ...Short) {
	s.news = append(s.news, sh...)
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
	IdComment int64      `json:"id"`
	Parent    int64      `json:"parent"`
	Content   string     `json:"content"`
	AuthorId  int64      `json:"authorid"`
	Author    string     `json:"author"`
	Timestamp int64      `json:"time"`
	Answer    []*Comment `json:"anwser"`
}

// ctor for comment
func CreateComment(Id, Par int64, Cont, Aut string, AutId, time int64) *Comment {
	c := new(Comment)
	c.IdComment = Id
	c.Parent = Par
	c.Content = Cont
	c.AuthorId = AutId
	c.Author = Aut
	c.Timestamp = time
	return c
}

type Full struct {
	Rss    Short
	Answer []*Comment
}

// add child comment
func (parent *Comment) Add(child ...*Comment) {
	parent.Answer = append(parent.Answer, child...)
}

type FullNew struct {
	ID    int64  `json:"ID"`    // номер записи
	Title string `json:"Title"` // заголовок публикации
	//Description string  `json:"Content"`  // содержание публикации
	Time int64  `json:"PubTime"` // время публикации
	Url  string `json:"Link"`    // ссылка на источник
	Hash uint64 `json:"Guid"`    //uid новости для  контроля дубликатов

}
