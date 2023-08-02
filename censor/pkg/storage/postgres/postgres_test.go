// пакет работы с БД postgres

package postgres

import (
	pb "gateway/internal/model"
	"testing"
)

func TestDB_CheckComment(t *testing.T) {
	db, err := New()

	if err != nil {
		t.Fatal(err)
	}
	defer db.Close()
	type tt struct {
		C    pb.Comment
		want bool
	}

	ttt := []tt{tt{C: pb.Comment{Content: "sdfsdqwertyfsdf"}, want: false},
		tt{C: pb.Comment{Content: "sdfsdqweryfsdf"}, want: true},
		tt{C: pb.Comment{Content: "sdfsdQweRTYfsdf"}, want: false},
	}

	for _, v := range ttt {
		t.Run("1", func(t *testing.T) {
			got, err := db.CheckComment(&v.C)
			if err != nil {
				t.Error(v.C)
				t.Errorf("DB.CheckComment() error = %v", err)
				return
			}
			if got != v.want {
				t.Errorf("DB.CheckComment() = %v, want %v", got, v.want)
			}
		})
	}
}
