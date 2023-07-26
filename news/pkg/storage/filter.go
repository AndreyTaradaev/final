// блок для формирования запроса к БД по функции поиска
package storage

import (
	"fmt"
	pb "gateway/internal/rpc"
)

func getLike(w *pb.FindWord) string {
	if w == nil {
		return " ILIKE "
	}
	ops := w.GetOption()
	switch ops {
	case pb.OptionSearch_WholeWord:
		fallthrough
	case pb.OptionSearch_WordPart:
		return " ILIKE "
	case pb.OptionSearch_WordExclude:
		fallthrough
	case pb.OptionSearch_WordPartExclude:
		return " NOT ILIKE "
	default:
		return " ILIKE "
	}
}

// создание SQL запроса  из параметров фильтра.
func FormatSQl(f *pb.Filter) (string, error) {
	if f == nil {
		return "", fmt.Errorf("filter is null")
	}
	w := f.GetWord()
	s := f.GetSort()
	like := getLike(w)
	sort := getSort(s)
	return fmt.Sprintf(searchSql, like, like, like, sort), nil
}

func getSort(s *pb.OptionSort) string {
	if s == nil {
		return ` order by "time" desc`
	}
	ret := " order by "
	switch s.GetField() {
	case pb.FIELD_SORT_FIELD_ID:
		ret += " id "
	case pb.FIELD_SORT_FIELD_TITLE:
		ret += " title "
	case pb.FIELD_SORT_FIELD_DESC:
		ret += " description "
	case pb.FIELD_SORT_FIELD_DATE:
		ret += ` "time" `
	case pb.FIELD_SORT_FIELD_URL:
		ret += " url "
	default:
		ret += ` "time" `
	}
	switch s.GetSort() {
	case pb.OrderSORT_SORT_ASC:
		ret += " ASC "
	default:
		ret += " DESC "
	}
	return ret
}

// создание параметра для SQL запроса.
func FormatWord(w *pb.FindWord) string {

	if w == nil || len(w.GetSearch()) == 0 {
		return "" // нет поиска по слову
	}
	word := w.GetSearch()
	switch w.GetOption() {
	case pb.OptionSearch_WordExclude:
		fallthrough
	case pb.OptionSearch_WholeWord:
		return " " + word + " "
	case pb.OptionSearch_WordPartExclude:
		fallthrough
	case pb.OptionSearch_WordPart:
		return word
	default:
		return word
	}
}
