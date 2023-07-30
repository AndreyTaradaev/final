// / Блок формирования структуры для фильтра по ней формируется SQL запрос
package model

import (
	"gateway/internal/tools"
	"strings"
)

// возвращает параметр поиска по слову .
// 0 слово целиком
// 1 часть слова
// 2 не включает слово
// 3 не включает часть слова
func wordParam(Param string /* число в виде строки*/) OptionSearch {

	ParamInt := tools.GetIntDef(Param, 1)
	switch ParamInt {
	case 0:
		return OptionSearch_WholeWord // слово целиком
	case 1:
		return OptionSearch_WordPart
	case 2:
		return OptionSearch_WordExclude
	case 3:
		return OptionSearch_WordPartExclude
	}
	return OptionSearch_WordPart
}

// возвращает вид сортировки .
func typeSort(typesort string) OrderSORT {

	if strings.EqualFold(strings.TrimSpace(typesort), "asc") {
		return OrderSORT_SORT_ASC
	}
	return OrderSORT_SORT_DESC
}

// возвращает поле сортировки.
func fieldSort(sort string) FIELD_SORT {
	lowersort := strings.ToLower(sort)
	switch lowersort {
	case "id":
		return FIELD_SORT_FIELD_ID
	case "title":
		return FIELD_SORT_FIELD_TITLE
	case "desc":
		return FIELD_SORT_FIELD_DESC
	case "date":
		return FIELD_SORT_FIELD_DATE
	case "url":
		return FIELD_SORT_FIELD_URL
	}
	return FIELD_SORT_FIELD_DATE
}

// создает структуру фильтра
func CreateFilter(word string, // слово для поиска
	paramword string, // параметр для поиска
	fieldsort string, //поле для сортировки
	typesort string, //тип сортировки
	startDate string, //начальная дата
	endDate string) *Filter {
	filter := Filter{
		Word:   &FindWord{Search: word, Option: wordParam(paramword)},
		Sort:   &OptionSort{Field: fieldSort(fieldsort), Sort: typeSort(typesort)},
		Period: &FilterDate{Startdate: tools.GetIntDef(startDate, 0), Enddate: tools.GetIntDef(endDate, 0)},
	}
	return &filter
}
