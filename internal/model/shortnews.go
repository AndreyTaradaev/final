// пакет  model был сформирован автоматически утилитой  protoc(protobuf)
// здесь находятся вспмогательные функции
package model

import "hash/crc64"

// создание новости
// первый агрумент функции это ид в нашей БД , последний это приходит с сервера RSS
func NewShort(id int64, title string, content string, time int64, link string, idNews string) *ShortNew {
	ret := ShortNew{
		ID:      id,
		Title:   title,
		Content: content,
		PubTime: time,
		Link:    link,
	}
	ret.Hash = int64(crc64.Checksum([]byte(idNews), crc64.MakeTable(crc64.ISO)))
	return &ret
}

func (a *ArrayShortNews) Len() int {
	return len(a.GetArray())
}
