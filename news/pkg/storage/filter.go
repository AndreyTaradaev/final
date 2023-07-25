package storage

/* func (f *Filter) SQL() string {
	var regul string
	switch f.filterword.parametr {
	case wholeWord:
		fallthrough
	case wordPart:
		regul = " ILIKE "
	case wordExclude:
		fallthrough
	case wordPartExclude:
		regul = " NOT ILIKE "
	default:
		regul = " ILIKE "
	}
	sql := fmt.Sprintf(searchSql, regul, regul, regul, f.createOrder())
	return sql
}


 func (f *Filter) createOrder() string {
	ord := " order by " + f.filterword.word
	if f.sort.order {
		ord += " asc"
	} else {
		ord += " desc"
	}
	return ord
}

func (f *Filter) SQL() string {
	var regul string
	switch f.filterword.parametr {
	case wholeWord:
		fallthrough
	case wordPart:
		regul = " ILIKE "
	case wordExclude:
		fallthrough
	case wordPartExclude:
		regul = " NOT ILIKE "
	default:
		regul = " ILIKE "
	}
	sql := fmt.Sprintf(searchSql, regul, regul, regul, f.createOrder())
	return sql
}
*/
