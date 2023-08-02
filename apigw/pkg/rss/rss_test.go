package rss

import (
	"testing"
)

func Test_loadRss(t *testing.T) {
	arg := []string{"https://habr.com/ru/rss/hub/go/all/?fl=ru"}

	for _, v := range arg {
		ret, err := loadRss(v)
		if err != nil {
			t.Fatal(err)
		}
		if ret.Len() == 0 {
			t.Log("получено 0 новостей")

		}
		t.Logf("получено %d новостей\n %+v", ret.Len(), ret)
	}
}

func Test_createClient(t *testing.T) {
	type args struct {
		target string
	}
	tests := []struct {
		name    string
		args    args
		wantErr bool
	}{struct {
		name    string
		args    args
		wantErr bool
	}{name: "1",
		args:    args{target: "localhost:11200"},
		wantErr: false,
	},
	// TODO: Add test cases.
	}
	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			got, err := createClient(tt.args.target)
			if (err == nil) == tt.wantErr {
				t.Errorf("createClient() error = %v, wantErr %v", err, tt.wantErr)
				return
			}
			got.Close()
		})
	}
}

func Test_addnews(t *testing.T) {

	got, err := createClient("localhost:11200")
	if err != nil {
		t.Fatal(err)
	}
	t.Run("1", func(t *testing.T) {
		addnews(got, "https://habr.com/ru/rss/hub/go/all/?fl=ru")
	})

}
