// пакет работы с БД postgres
package postgres

import (
	"context"
	"errors"
	"fmt"
	pb "gateway/internal/model"
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
		where parent is null and not  deleted and id_news=$1 
		union all 
		select  com2.id, com2.parent,com2.id_news,com2."Content"  , com2."time",com2."authorId" ,cast (temp1.path||'.'||com2.id as varchar(50)),level+1
		from gocomments.public.newscomments com2 inner join temp1 on (temp1.id = com2.parent  and not deleted))
		select * from temp1
		order by level,path;	 	
`
	updateSQL string = `UPDATE newscomments
SET  deleted=true
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
		return nil, errors.New("не указано подключение к БД в  переменной COMMENTDB, формат  postgres://[user]:[passwd]@[host]:[port]/[database]")
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
		comment.GetIdnews(),
		comment.GetContent(),
		comment.Parent,
		comment.GetTime(),
		comment.GetAuthorid(),
	).Scan(&id)
	if err != nil {
		return 0, err
	}
	return id, nil
}

// Дерево коментариев.
func (db *DB) Comments(id *pb.Forlist) (*pb.TreeComments, error) {
	rows, err := db.pool.Query(context.Background(), listSQL,
		id.GetId(),
	)
	if err != nil {
		return nil, err
	}

	tree := pb.TreeComments{Comments: make(map[int64]*pb.Comment)}
	mapb := tree.Comments

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
		var c string = ""
		if Content != nil {
			c = *Content // in DB maybe null
		}

		var t int64 = 0
		if Time != nil {
			t = *Time
		}

		if Parent == nil {
			mapb[*Id] = &pb.Comment{Parent: Parent, Content: c, Time: t, Idnews: *IdNews}
		} else {
			value := getMap(mapb, *Parent)
			if value == nil {
				fmt.Println(" value is null error,skip...")
				continue
			}
			value[*Id] = &pb.Comment{Parent: Parent, Content: c, Time: t, Idnews: *IdNews}
		}

	}
	//fmt.Println(mapb)
	return &tree, rows.Err()

}

func getMap(m map[int64]*pb.Comment, id int64) map[int64]*pb.Comment {

	for key, v := range m {
		if key == id {
			if v.Child == nil {
				v.Child = make(map[int64]*pb.Comment)
			}
			return v.Child
		}
		value := getMap(v.Child, id)
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
		id.GetId(),
	).Scan(&i)
	if err != nil {
		return 0, err
	}
	return i, nil
}
