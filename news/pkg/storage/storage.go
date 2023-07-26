// пакет работы с БД новостей
package storage

import (
	"context"
	"errors"
	"gateway/internal/model"
	"os"
	"github.com/jackc/pgx/v4/pgxpool"
)

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
	case 
	when $1<$3 then  description 
	else
	   case 
	    when len>100  then substring(description,0,100+space_ ) ||'...'
	    else description
        end	   
    end  description,

	title, url , "time",hashrss
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
func (db *DB) AddNew(news model.Short) error {
	_, err := db.pool.Exec(context.Background(), addSQL,
		news.Title,
		news.Description,
		news.Time,
		news.Url,
		int64(news.Hash),
	)
	if err != nil {
		return err
	}
	return nil
}

// вернуть список последних новостей  для веб-интефейса. сокращенно.
func (db *DB) List(n int) ([]model.Short, error) {
	rows, err := db.pool.Query(context.Background(), listSQL,
		n,
		0,   // c первой новости
		n-1, // сокращенно
	)
	if err != nil {
		return nil, err
	}
	var ret model.ShortNews
	for rows.Next() {
		var id, time, hash *int64
		var title, desc, url *string
		err = rows.Scan(
			&id,
			&desc,
			&title,
			&url,
			&time,
			&hash,
		)
		if err != nil {
			return nil, err
		}
		ret.AddFromData(id, title, desc, time, url, hash)
	}
	return ret.Get(), rows.Err()
}

// возвращает последние новости из БД. по страницам
// limit -- количество  выводимых новостей
// offset -- номер страницы  начинается с 1
func (db *DB) ListPage(limit, Page int) ([]model.Short, error) {

	if limit == 0 {
		limit = model.Limit
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
	var ret model.ShortNews
	for rows.Next() {
		var id, time, hash *int64
		var title, desc, url *string
		err = rows.Scan(
			&id,
			&desc,
			&title,
			&url,
			&time,
			&hash,
		)
		if err != nil {
			return nil, err
		}
		ret.AddFromData(id, title, desc, time, url, hash)
	}
	return ret.Get(), rows.Err()
}

// получение новости по ИД.
func (db *DB) GetNews(i int) (model.Short, error) {
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
		return model.Short{}, err
	}
	mod := model.CreateShort(id, title, desc, time, url, hash)
	return *mod, nil
}

// получение новостей по Фильтру.
func (db *DB) Search(sql string, word string, startdate, enddate int64) ([]model.Short, error) {
	rows, err := db.pool.Query(context.Background(), sql,
		word,
		startdate,
		enddate,
	)
	if err != nil {
		return nil, err
	}
	var ret model.ShortNews
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
		ret.AddFromData(id, title, desc, time, url, hash)
	}
	return ret.Get(), rows.Err()
}
