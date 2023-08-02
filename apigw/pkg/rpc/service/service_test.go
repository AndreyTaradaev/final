// формирование RPC Запросов

package service

import (
	pb "gateway/internal/model"
	"testing"
)

const (
	newsserver    = "127.0.0.1:11200"
	commentserver = "127.0.0.1:10001"
	censorserver  = "127.0.0.1:12035"
)

func TestConnect(t *testing.T) {

	_, err := Connect("", 3)
	if err == nil {
		t.Errorf("Connect() error = %v, wantErr %v", err, true)
		return
	}
	_, err = ConnectWithContext("", 3)
	if err == nil {
		t.Errorf("Connect() error = %v, wantErr %v", err, true)
		return
	}

	got, err := ConnectWithContext(newsserver, 3)
	if err != nil {
		t.Errorf("Connect() error = %v, wantErr %v", err, true)
		return

	}
	t.Log(got.GetState())
	got.Close()
	got, err = Connect(newsserver, 3)
	if err != nil {
		t.Errorf("Connect() error = %v, wantErr %v", err, true)
		return
	}
	t.Log(got.GetState())
	got.Close()
}

func TestRPClient_ListPageNews(t *testing.T) {
	got, err := Connect(newsserver, 200)
	if (err != nil) != false {
		t.Errorf("Connect() error = %v, wantErr %v", err, false)
		return
	}
	//t.Log(got.GetState())
	ret, err := got.ListPageNews(1, 20)
	if err != nil {
		t.Fatal(err)
	}
	t.Log("count", ret.Len())

}

func TestRPClient_ListNews(t *testing.T) {
	got, err := Connect(newsserver, 200)
	if (err != nil) != false {
		t.Errorf("Connect() error = %v, wantErr %v", err, false)
		return
	}
	//t.Log(got.GetState())
	ret, err := got.ListNews(1)
	if err != nil {
		t.Fatal(err)
	}
	t.Log("count", ret.Len())
}

func TestRPClient_DetailNews(t *testing.T) {
	got, err := Connect(newsserver, 200)
	if (err != nil) != false {
		t.Errorf("Connect() error = %v, wantErr %v", err, false)
		return
	}
	//t.Log(got.GetState())
	_, err = got.DetailNews(0)
	if err == nil {
		t.Fatal(err)
	}
	t.Log(err)
	ret, err := got.DetailNews(65222)
	if err != nil {
		t.Fatal(err)
	}
	t.Log(ret)
}

func TestRPClient_SearchNews(t *testing.T) {

	var filter pb.Filter = *pb.CreateFilter("go", "1", "", "", "0", "0")
	got, err := Connect(newsserver, 200)
	if (err != nil) != false {
		t.Errorf("Connect() error = %v, wantErr %v", err, false)
		return
	}
	ret, err := got.SearchNews(&filter)
	if err != nil {
		t.Fatal(err)
	}
	t.Log(ret.Len())
}

func TestRPClient_AddComment(t *testing.T) {
	id := int64(123)
	c := pb.Comment{Id: &id, Parent: nil, Content: "content", Idnews: 1235}

	got, err := Connect(commentserver, 200)
	if (err != nil) != false {
		t.Errorf("Connect() error = %v, wantErr %v", err, false)
		return
	}

	ret, err := got.AddComment(&c)
	if err != nil {
		t.Errorf("RPClient.AddComment() error = %v", err)
		return
	}
	t.Log(ret)
}

func TestRPClient_Comments(t *testing.T) {
	got, err := Connect(commentserver, 200)
	if (err != nil) != false {
		t.Errorf("Connect() error = %v, wantErr %v", err, false)
		return
	}

	ret, err := got.Comments(1235)
	if err != nil {
		t.Errorf("RPClient.Comments() error = %v", err)
		return
	}
	t.Log(ret)
}

func TestRPClient_DelComment(t *testing.T) {
	got, err := Connect(commentserver, 200)
	if (err != nil) != false {
		t.Errorf("Connect() error = %v, wantErr %v", err, false)
		return
	}
	ret, err := got.DelComment(0)
	if err == nil {
		t.Errorf("RPClient.Comments() error = %v", err)
		return
	}
	t.Log(err)
	ret, err = got.DelComment(20)
	if err != nil {
		t.Errorf("RPClient.Comments() error = %v", err)
		return
	}
	t.Log(ret)

}
