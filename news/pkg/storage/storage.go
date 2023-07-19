package storage

import (
	"context"
	"errors"
	"os"
	"github.com/jackc/pgx/v4/pgxpool"
	logs "gateway/internal/log"
	"time"
	//rpc "gateway/internal/rpc"
	//"fmt"
)


// База данных.
type DB struct {
	pool *pgxpool.Pool
}

//Конструктор  создания подключения к БД. 
func New() (*DB, error) {	
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
	time.Sleep(time.Second*time.Duration(11))
	return &db, nil
}

func (db *DB)Close() {
	if db.pool != nil {		
		db.pool.Close()
		logs.New().Debug("Закрыли подключение к БД")
	}
}

// сохранение новостей в БД
/* func (db *DB) StoreNews(news []rpc.ShortNew) error {
	for _, post := range news {
		_, err := db.pool.Exec(context.Background(), `
		INSERT INTO news(title, content, pub_time, link)
		VALUES ($1, $2, $3, $4)`,
			post.Title,
			post.Content,
			post.PubTime,
			post.Link,
		)
		if err != nil {
			return err
		}
	}
	return nil
}

// News возвращает последние новости из БД.
func (db *DB) News(n int) ([]Post, error) {
	if n == 0 {
		n = 10
	}
	rows, err := db.pool.Query(context.Background(), `
	SELECT id, title, content, pub_time, link FROM news
	ORDER BY pub_time DESC
	LIMIT $1
	`,
		n,
	)
	if err != nil {
		return nil, err
	}
	var news []Post
	for rows.Next() {
		var p Post
		err = rows.Scan(
			&p.ID,
			&p.Title,
			&p.Content,
			&p.PubTime,
			&p.Link,
		)
		if err != nil {
			return nil, err
		}
		news = append(news, p)
	}
	return news, rows.Err()
}
 */
