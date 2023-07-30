// пакет работы с БД Postgres
package postgres

import (
	"context"
	"errors"
	"fmt"
	pb "gateway/internal/model"
	"os"

	"github.com/jackc/pgx/v4/pgxpool"
)

const Limit int64 = 20
const (
	addSQL  string = `INSERT INTO "NewsRss" (title, description, "time", url, hashrss) VALUES($1, $2, $3, $4,$5)	ON CONFLICT DO nothing;	`
	listSQL string = `
	with  repl as( SELECT id , trim( regexp_replace(description, '^[\\r\\n\\t ]*|[\\r\\n\\t ]*$', ''))as  description , title, url , "time",hashrss
	FROM "NewsRss" order by "time" desc limit $1 offset $2
	), i as( 
	select id,
	description,
	length(description) len ,
	char_length(split_part( substr (description,100,200 ),' ',1)) space_,
	title, url , "time",hashrss
	from repl
	), ii as ( select id,
	title,
	case 
	when $1<$3 then  description 
	else
	   case 
	    when len>100  then substring(description,0,100+space_ ) ||'...'
	    else description
        end	   
    end  description,
	"time",
	 url , hashrss
	from i
	)
	select * from ii;
`
	getNews string = `SELECT id, title, description, "time", url, hashrss
FROM "NewsRss" where id = $1;`
	searchSql string = `SELECT id, title, description, "time", url, hashrss
FROM "NewsRss" where 
( $1 ='' or   ( -- поиск по слову
title %s '%%'||$1||'%%' 
or description %s '%%'||$1||'%%'
or url %s '%%'||$1||'%%'
))
and ($2=0 or "time" >=$2 )
and ($3=0 or "time" <=$3 )
%s
; `
)

// объект для работы с  База данных новостей.
type DB struct {
	pool *pgxpool.Pool
}

// Конструктор  создания и подключения к БД.
func New() (*DB, error) {
	os.Setenv("NEWSDB", "postgres://postgres:1C_Db_post@172.16.0.44:5432/gonews")

	connstr := os.Getenv("NEWSDB")
	if connstr == "" {
		return nil, errors.New("не указано подключение к БД в  переменной NEWSDB, формат  postgres://[user]:[passwd]@[host]:[port]/[database]")
	}
	pool, err := pgxpool.Connect(context.Background(), connstr)
	if err != nil {
		return nil, err
	}
	db := DB{
		pool: pool,
	}
	return &db, nil
}

// закрытие соединения с БД.
func (db *DB) Close() {
	if db.pool != nil {
		db.pool.Close()
	}
}

// сохранение новости в БД.
func (db *DB) AddNew(news *pb.ShortNew) error {
	_, err := db.pool.Exec(context.Background(), addSQL,
		news.GetTitle(),
		news.GetContent(),
		news.GetPubTime(),
		news.GetLink(),
		news.GetHash(),
	)
	if err != nil {
		return err
	}
	return nil
}

func isNulInt(i *int64) int64 {
	if i == nil {
		return 0
	}
	return *i
}
func isNullString(s *string) string {
	if s == nil {
		return ""
	}
	return *s
}

func createNews(id *int64, title, desc *string, time *int64, url *string, hash *int64) *pb.ShortNew {
	ret := new(pb.ShortNew)
	ret.ID = isNulInt(id)
	ret.Title = isNullString(title)
	ret.Content = isNullString(desc)
	ret.PubTime = isNulInt(time)
	ret.Link = isNullString(url)
	ret.Hash = isNulInt(hash)
	return ret
}

// вернуть список последних новостей  для веб-интефейса. сокращенно.
func (db *DB) List(n int64) (*pb.ArrayShortNews, error) {

	rows, err := db.pool.Query(context.Background(), listSQL,
		n,
		0,   // c первой новости
		n-1, // сокращенно
	)
	if err != nil {
		return nil, err
	}
	ret := pb.ArrayShortNews{Array: make([]*pb.ShortNew, 0)}
	for rows.Next() {
		var id, time, hash *int64
		var title, desc, url *string
		err = rows.Scan(
			&id,
			&title,
			&desc,
			&time,
			&url,
			&hash,
		)
		if err != nil {
			return nil, err
		}
		n := createNews(id, title, desc, time, url, hash)

		ret.Array = append(ret.Array, n)
	}
	return &ret, rows.Err()
}

// возвращает последние новости из БД. по страницам
// limit -- количество  выводимых новостей
// offset -- номер страницы  начинается с 1
func (db *DB) ListPage(limit, Page int64) (*pb.ArrayShortNews, error) {

	if limit == 0 {
		limit = Limit
	}
	if Page != 0 {
		Page--
	}
	offset := Page * limit
	rows, err := db.pool.Query(context.Background(), listSQL,
		limit,
		offset,  // c первой новости
		limit-1, // сокращенно
	)
	if err != nil {
		return nil, err
	}
	ret := pb.ArrayShortNews{Array: make([]*pb.ShortNew, 0)}
	for rows.Next() {
		var id, time, hash *int64
		var title, desc, url *string
		err = rows.Scan(
			&id,
			&title,
			&desc,
			&time,
			&url,
			&hash,
		)
		if err != nil {
			return nil, err
		}
		n := createNews(id, title, desc, time, url, hash)
		ret.Array = append(ret.Array, n)
	}
	return &ret, rows.Err()
}

// получение новости по ИД.
func (db *DB) GetNews(i int64) (*pb.ShortNew, error) {
	row := db.pool.QueryRow(context.Background(),
		getNews,
		i)
	var id, time, hash *int64
	var title, desc, url *string
	err := row.Scan(
		&id,
		&title,
		&desc,
		&time,
		&url,
		&hash,
	)
	if err != nil {
		return nil, err
	}
	mod := createNews(id, title, desc, time, url, hash)
	return mod, nil
}

// получение новостей по Фильтру.
func (db *DB) Search(f *pb.Filter) (*pb.ArrayShortNews, error) {

	sql, err := formatSQl(f)
	if err != nil {
		return nil, err
	}
	wordsearch := FormatWord(f.GetWord())

	rows, err := db.pool.Query(context.Background(), sql,
		wordsearch,
		f.Period.GetStartdate(),
		f.GetPeriod().GetEnddate(),
	)
	if err != nil {
		return nil, err
	}
	ret := pb.ArrayShortNews{Array: make([]*pb.ShortNew, 0)}
	for rows.Next() {
		var id, time, hash *int64
		var title, desc, url *string
		err = rows.Scan(
			&id,
			&title,
			&desc,
			&time,
			&url,
			&hash,
		)
		if err != nil {
			return nil, err
		}
		n := createNews(id, title, desc, time, url, hash)
		ret.Array = append(ret.Array, n)
	}
	return &ret, rows.Err()
}

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
func formatSQl(f *pb.Filter) (string, error) {
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
