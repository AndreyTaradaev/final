package storage

import (
	"context"
	"errors"
	logs "gateway/internal/log"
	"gateway/internal/model"
	"os"
	"time"	
	"github.com/jackc/pgx/v4/pgxpool"
	
)

// База данных.
type DB struct {
	pool *pgxpool.Pool
}

// Конструктор  создания подключения к БД.
func New() (*DB, error) {
	os.Setenv("NEWSDB", "postgres://postgres:1C_Db_post@172.16.0.44:5432/gonews")

	connstr := os.Getenv("NEWSDB")
	if connstr == "" {
		logs.New().Error("переменная окружения \"NEWSDB\" не указана")
		return nil, errors.New("не указано подключение к БД")
	}
	//Выставим таймаут
	ctx, _ := context.WithTimeout(context.Background(), 10*time.Second)
	pool, err := pgxpool.Connect(ctx, connstr)
	if err != nil {
		return nil, err
	}
	db := DB{
		pool: pool,
	}
	return &db, nil
}

// закрытие соединения с БД
func (db *DB) Close() {
	if db.pool != nil {
		db.pool.Close()
		logs.New().Debug("Закрыли подключение к БД")
	}
}

// сохранение новостей в БД
func (db *DB) AddNews(news []model.Short) {

	for _, post := range news {
		_, err := db.addNew(post)
		if err != nil {
			//если ошибка пишем в лог
			logs.New().Errorf("Ошибка записи в БД хеш %d, ссылка %s, %s", post.Hash, post.Url, err)
		}
	}
}

func (db *DB) addNew(news model.Short) (int64, error) {
	var id int64
	err := db.pool.QueryRow(context.Background(), `
	INSERT INTO "NewsRss"
		(title, description, "time", url, hashrss)
		VALUES($1, $2, $3, $4,$5)
		ON CONFLICT DO nothing RETURNING "id";
		`,
		news.Title,
		news.Description,
		news.Time,
		news.Url,
		int64(news.Hash),
	).Scan(&id)
	return id, err
}

// News возвращает последние новости из БД. по страницам
// limit -- количество на выводимых новостей
// offset -- номер страницы с 1 начинается
// если лимит 0 тогда все выводим содержание новости обрезаем если длина больше 100 символов
func (db *DB) List(limit, offset uint) ([]model.Short, error) {
	var i  = 1<<63-1
	

	if limit == 0 {
		limit = uint(i)
		offset = 0
	} else {
		if offset != 0 {
			offset--
		}
		offset = offset * limit
	}
	rows, err := db.pool.Query(context.Background(), `
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
		when len>100  then substring(description,0,100+space_ ) ||'...'
		else description
	end description,
	title, url , "time",hashrss
	from i
	)
	select * from ii;
`,
		limit,
		offset,
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
		ret.Append(id, time, hash, title, desc, url)

	}
	return ret.Get(), rows.Err()
}

/* */
