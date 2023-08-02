// пакет работы с БД postgres

package postgres

import (
	pb "gateway/internal/model"
	"testing"
)

func TestDB_Comments(t *testing.T) {
	db, err := New()
	if err != nil {
		t.Fatal(err)
	}
	defer db.Close()
	id := pb.Forlist{Id: 65222}
	ret, err := db.Comments(&id)
	if err != nil {
		t.Fatal(err)
	}
	t.Log(ret)
	id.Id = 25
	r, err := db.DelComment(&id)
	t.Log(r)

}
