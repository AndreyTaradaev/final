// пакет работы с БД Postgres

package postgres

import (
	pb "gateway/internal/model"

	"testing"
)

func TestDB_List(t *testing.T) {
	db, err := New()
	if err != nil {
		t.Fatal(err)
	}
	defer db.Close()
	id := pb.Forlist{Id: 65222}
	ret, err := db.GetNews(65222)
	if err != nil {
		t.Fatal(err)
	}
	t.Log(ret)
	id.Id = 25
	r1, err := db.ListPage(20,1)
	if err != nil {
		t.Fatal(err)
	}
	t.Log(r1)
	r2, err := db.List(20,)
	if err != nil {
		t.Fatal(err)
	}
	t.Log(r2)
	f := pb.Filter{Word: &pb.FindWord{Search: "go",Option: pb.OptionSearch_WordPart}}
	r3,err := db.Search(&f)
	if err != nil {
		t.Fatal(err)
	}
	t.Log(r3)

}
