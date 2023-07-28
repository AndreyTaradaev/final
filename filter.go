package model

import (
	pb "gateway/internal/rpc"
	"strconv"
	"strings"
)

// возвращает параметр поиска .
func WordParam(Param string /* число в виде строки*/) pb.OptionSearch {

	ParamInt := GetIntDef(Param, 1)
	switch ParamInt  {
	case 0:
		return pb.OptionSearch_WholeWord
	case 1:
		return pb.OptionSearch_WordPart
	case 2:
		return pb.OptionSearch_WordExclude
	case 3:
		return pb.OptionSearch_WordPartExclude
	}
	return pb.OptionSearch_WordPart
}

// возвращает поле сортировки.
func FieldSort(sort string) pb.FIELD_SORT {
	lowersort := strings.ToLower(sort)
	switch lowersort {
	case "id":
		return pb.FIELD_SORT_FIELD_ID
	case "title":
		return pb.FIELD_SORT_FIELD_TITLE
	case "desc":
		return pb.FIELD_SORT_FIELD_DESC
	case "date":
		return pb.FIELD_SORT_FIELD_DATE
	case "url":
		return pb.FIELD_SORT_FIELD_URL
	}
	return pb.FIELD_SORT_FIELD_DATE
}

// возвращает вид сортировки .
func TypeSort(typesort string) pb.OrderSORT {

	if strings.EqualFold(typesort, "asc") {
		return pb.OrderSORT_SORT_ASC
	}
	return pb.OrderSORT_SORT_DESC
}

// конвертирует строку в число если ошибка возвращает значение по умолчанию.
func GetIntDef(value string, def int64) int64 {
	v, err := strconv.ParseInt(value, 10, 64)
	if err != nil {
		return def
	}
	return v
}

/* // перечисления.
// параметры поиска по слову.
type wordoption int32

// поле сортировки.
type fiedSort string

// вид сортировки.
type orderSort bool

//-------------Структура поиска----------------------------------------------

// поиск по слову
const (
	//  полность слово
	wholeWord wordoption = 0
	// часть слова
	wordPart wordoption = 1
	// не включая слово
	wordExclude wordoption = 2
	// не включая часть слова
	wordPartExclude wordoption = 3
)

type searchWord struct {
	//само слово
	word string
	//как ищем
	parametr wordoption
}

// поиск по дате
type period struct {
	startDate int64
	endDate   int64
}

// поле сортировки
const (
	fiedSort_id          fiedSort = "id"
	fiedSort_title       fiedSort = "title" // по заголовку
	fiedSort_description fiedSort = "description"
	fiedSort_time        fiedSort = `"time"`
	fiedSort_url         fiedSort = "url"
)

const (
	Asc  orderSort = true
	Desc orderSort = false
)

// структура сортировки
type structSort struct {
	field fiedSort
	order orderSort
}

type Filter struct {
	filterword searchWord
	filterDate period
	sort       structSort
}

func parametrSearch(fw *pb.FindWord) wordoption {
	switch fw.GetOption() {
	case pb.OptionSearch_WholeWord:
		return wholeWord
	case pb.OptionSearch_WordPart:
		return wordPart
	case pb.OptionSearch_WordExclude:
		return wordExclude
	case pb.OptionSearch_WordPartExclude:
		return wordPartExclude
	}
	return wordPart
}

func fieldSort(fs *pb.OptionSort) fiedSort {
	switch fs.GetField() {
	case pb.FIELD_SORT_FIELD_ID:
		return fiedSort_id
	case pb.FIELD_SORT_FIELD_TITLE:
		return fiedSort_title
	case pb.FIELD_SORT_FIELD_DESC:
		return fiedSort_description
	case pb.FIELD_SORT_FIELD_DATE:
		return fiedSort_time
	case pb.FIELD_SORT_FIELD_URL:
		return fiedSort_url
	}
	return fiedSort_time
}

// кончтрукторы фильтра
func Convert(f *pb.Filter) *Filter {
	fdb := new(Filter)
	fw := f.GetWord()
	fs := f.GetSort()
	fdb.filterword.word = fw.GetSearch()
	fdb.filterword.parametr = parametrSearch(fw)
	fdb.sort.field = fieldSort(fs)
	fdb.sort.order = (fs.GetSort() == pb.OrderSORT_SORT_ASC)
	fdb.filterDate.startDate = f.GetPeriod().GetStartDate()
	fdb.filterDate.endDate = f.GetPeriod().GetEndDate()
	return fdb
}

func parametrToPb(fw wordoption) pb.OptionSearch {
	switch fw {
	case wholeWord:
		return pb.OptionSearch_WholeWord
	case wordPart:
		return pb.OptionSearch_WordPart
	case wordExclude:
		return pb.OptionSearch_WordExclude
	case wordPartExclude:
		return pb.OptionSearch_WordPartExclude
	}
	return pb.OptionSearch_WordPart
}

func fieldToPB(fs fiedSort) pb.FIELD_SORT {
	switch fs {
	case fiedSort_id:
		return pb.FIELD_SORT_FIELD_ID
	case fiedSort_title:
		return pb.FIELD_SORT_FIELD_TITLE
	case fiedSort_description:
		return pb.FIELD_SORT_FIELD_DESC
	case fiedSort_time:
		return pb.FIELD_SORT_FIELD_DATE
	case fiedSort_url:
		return pb.FIELD_SORT_FIELD_URL
	}
	return pb.FIELD_SORT_FIELD_DATE
}

func sortToPB(o orderSort) pb.OrderSORT {
	if o == Asc {
		return pb.OrderSORT_SORT_ASC
	}
	return pb.OrderSORT_SORT_DESC
}

func (f *Filter) ToPB() *pb.Filter {
	pbf := pb.Filter{
		Word: &pb.FindWord{
			Search: f.filterword.word,
			Option: parametrToPb(f.filterword.parametr)},
		Sort: &pb.OptionSort{Field: fieldToPB(f.sort.field),
			Sort: sortToPB(f.sort.order)},
		Period: &pb.FilterDate{StartDate: f.filterDate.startDate,
			EndDate: f.filterDate.endDate},
	}

	return &pbf

}

func New() *Filter {
	fdb := new(Filter)
	/* fw := f.GetWord()
	fs := f.GetSort()
	fdb.filterword.word = fw.GetSearch()
	fdb.filterword.parametr = parametrSearch(fw)
	fdb.sort.field = fieldSort(fs)
	fdb.sort.order = (fs.GetSort() == pb.OrderSORT_SORT_ASC)
	fdb.filterDate.startDate = f.GetPeriod().GetStartDate()
	fdb.filterDate.endDate = f.GetPeriod().GetEndDate()
	return fdb
}
*/
