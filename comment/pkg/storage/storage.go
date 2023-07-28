// пакет работы с БД комментариев
package storage

import (
	"context"
	"errors"
	"fmt"

	//"gateway/internal/model"
	//"fmt"

	pb "gateway/internal/rpc"
	"os"

	"github.com/jackc/pgx/v4/pgxpool"
)

const (
	addComment string = `INSERT INTO newscomments
	(id_news, "Content", parent, "time",  "authorId")
	VALUES($1, $2, $3, $4 ,$5 ) RETURNING id; `
	listSQL string = `with recursive temp1 (id,parent,id_news,	"Content" ,"time" ,	"authorId",path,level ) as (
		select id,parent,id_news, "Content" ,"time" ,	"authorId", cast (id as varchar(50)),1
		from gocomments.public.newscomments com1 
		where parent is null and not  banned and id_news=$1 
		union all 
		select com2.id, com2.parent,com2.id_news,com2."Content"  , com2."time",com2."authorId" ,cast (temp1.path||'.'||com2.id as varchar(50)),level+1 
		from gocomments.public.newscomments com2 inner join temp1 on (temp1.id = com2.parent  and not com2.banned ))
		select * from temp1
		order by level,path;	 	
`
	updateSQL string = `UPDATE newscomments
SET  banned=true
WHERE id=$1 RETURNING id; 
`
)

// объект для работы с  База данных новостей.
type DB struct {
	pool *pgxpool.Pool
}

// Конструктор  создания и подключения к БД.
func New() (*DB, error) {
	os.Setenv("COMMENTDB", "postgres://postgres:1C_Db_post@172.16.0.44:5432/gocomments")

	connstr := os.Getenv("COMMENTDB")
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
func (db *DB) AddComment(comment *pb.Comment) (int64, error) {
	var id int64
	//fmt.Println(comment)
	err := db.pool.QueryRow(context.Background(), addComment, // 	(id_news, "Content", parent, "time",  "authorId")
		comment.IdNews,
		comment.GetContent(),
		comment.Parent,
		comment.GetTime(),
		comment.AuthorId,
	).Scan(&id)
	if err != nil {
		return 0, err
	}
	return id, nil
}

// Дерево коментариев.
func (db *DB) Comments(id *pb.Forlist) (map[int64]*pb.Comment, error) {
	rows, err := db.pool.Query(context.Background(), listSQL,
		id.GetCount(),
	)
	if err != nil {
		return nil, err
	}

	//parent := map[int64]*model.Comment{}
	//currentlevel := int64(1)
	mapb := map[int64]*pb.Comment{}

	for rows.Next() {
		var Id, Parent, IdNews, AuthorId, Time, level *int64
		var Content, path *string
		err = rows.Scan(
			&Id,
			&Parent,
			&IdNews,
			&Content,
			&Time,
			&AuthorId,
			&path,
			&level,
		)
		if err != nil {
			return nil, err
		}
		if Content == nil {
			*Content = ""
		}

		//fmt.Println(Id, Parent, IdNews, AuthorId, Time, level, Content, path)
		var c string = ""
		if Content != nil {
			c = *Content // in DB maybe null
		}

		var t int64 = 0
		if Time != nil {
			t = *Time
		}

		if Parent == nil {
			mapb[*Id] = &pb.Comment{Parent: Parent, Content: c, Time: t, IdNews: *IdNews}
		} else {
			value := getMap(mapb, *Parent)
			if value == nil {
				fmt.Println(" value is null error,skip...")
				continue
			}
			value[*Id] = &pb.Comment{Parent: Parent, Content: c, Time: t, IdNews: *IdNews}
		}

	}
	//fmt.Println(mapb)
	return mapb, rows.Err()

}

func getMap(m map[int64]*pb.Comment, id int64) map[int64]*pb.Comment {

	for key, v := range m {
		if key == id {
			if v.Answer == nil {
				v.Answer = make(map[int64]*pb.Comment)
			}
			return v.Answer
		}
		value := getMap(v.Answer, id)
		if value != nil {
			return value
		}
	}
	return nil
}

// установка метки  banned  новости в БД.
func (db *DB) DelComment(id *pb.Forlist) (int64, error) {
	var i int64
	//fmt.Println(comment)
	err := db.pool.QueryRow(context.Background(), updateSQL, // 	(id_news, "Content", parent, "time",  "authorId")
		id.GetCount(),
	).Scan(&i)
	if err != nil {
		return 0, err
	}
	return i, nil
}

// вернуть список последних новостей  для веб-интефейса. сокращенно.
/* func (db *DB) List(n int) ([]model.Short, error) {
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
*/
