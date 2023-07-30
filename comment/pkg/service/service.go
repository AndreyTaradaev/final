package service

import (
	"context"
	"gateway/comment/pkg/storage"
	"gateway/comment/pkg/storage/postgres"
	logs "gateway/internal/log"
	pb "gateway/internal/model"
	"net"

	"google.golang.org/grpc"
)

type CommentServer struct {
	pb.CommentServiceServer
	db storage.DBInterface
}

// запуск микросервиса коментариев.
func RunServer(lis *net.Listener) error {
	var opts []grpc.ServerOption
	grpcServer := grpc.NewServer(opts...)
	NS, err := newServer()
	if err != nil {
		grpcServer.Stop()
		return err
	}
	pb.RegisterCommentServiceServer(grpcServer, NS)
	logs.New().Debug(grpcServer.GetServiceInfo())
	grpcServer.Serve(*lis)
	return nil
}

// конструктор RPC сервера.
func newServer() (*CommentServer, error) {
	db, err := postgres.New()

	if err != nil {
		return nil, err
	}
	ret := CommentServer{db: db}
	return &ret, nil
}

// добавить комментарий.
func (s *CommentServer) AddComment(ctx context.Context, c *pb.Comment) (*pb.Result, error) {
	id, err := s.db.AddComment(c)
	if err != nil {
		logs.New().Errorln(err)
		return nil, err
	}
	return &pb.Result{Ret: id}, nil
}

// добавить комментарий.
func (s *CommentServer) TreeComment(ctx context.Context, f *pb.Forlist) (*pb.TreeComments, error) {
	ar, err := s.db.Comments(f)
	if err != nil {
		logs.New().Errorln(err)
		return nil, err
	}
	return ar, nil
}

func (s *CommentServer) DelComment(ctx context.Context, f *pb.Forlist) (*pb.Result, error) {
	id, err := s.db.DelComment(f)
	if err != nil {
		logs.New().Errorln(err)
		return nil, err
	}
	return &pb.Result{Ret: id}, nil
}

// вернуть  список новостей на странице.
/* func (s *RssServiceServer) ListPage(ctx context.Context, page *pb.Page) (*pb.ArrayShortNews, error) {
	logs.New().Debugln("client send command list page")
	sh, err := s.db.ListPage(int(page.GetLimit()),
		int(page.GetPage()))
	if err != nil {
		logs.New().Errorln(err)
		return nil, err
	}
	var RPCNews pb.ArrayShortNews
	for _, v := range sh {
		sendnews := pb.ShortNew{ID: v.ID,
			Title:       v.Title,
			Description: v.Description,
			Url:         v.Url,
			Time:        v.Time,
			Hash:        int64(v.Hash)}
		RPCNews.Sl = append(RPCNews.Sl, &sendnews)
	}
	logs.New().Debugln("client send command list proccesed count: ", len(RPCNews.GetSl()))
	return &RPCNews, nil
}

// вернуть список последних новостей  для веб-интефейса.
func (s *RssServiceServer) List(ctx context.Context, list *pb.Forlist) (*pb.ArrayShortNews, error) {
	logs.New().Debugln("client send command list")
	sh, err := s.db.List(int(list.GetCount()))
	if err != nil {
		logs.New().Errorln(err)
		return nil, err
	}
	var RPCNews pb.ArrayShortNews
	for _, v := range sh {
		sendnews := pb.ShortNew{ID: v.ID,
			Title:       v.Title,
			Description: v.Description,
			Url:         v.Url,
			Time:        v.Time,
			Hash:        int64(v.Hash)}
		RPCNews.Sl = append(RPCNews.Sl, &sendnews)
	}
	logs.New().Debugln("client send command list proccesed count: ", len(RPCNews.GetSl()))
	return &RPCNews, nil

}

// детальная новость.
func (s *RssServiceServer) GetNews(ctx context.Context, list *pb.Forlist) (*pb.ShortNew, error) {
	logs.New().Debugln("client send command  full news ")
	v, err := s.db.GetNews(int(list.GetCount()))
	if err != nil {
		logs.New().Errorln(err)
		return nil, err
	}
	sendnews := pb.ShortNew{ID: v.ID,
		Title:       v.Title,
		Description: v.Description,
		Url:         v.Url,
		Time:        v.Time,
		Hash:        int64(v.Hash)}

	logs.New().Debugln("client send command full news  proccesed ")
	return &sendnews, nil
}

// поиск новостей
func (s *RssServiceServer) Search(ctx context.Context, f *pb.Filter) (*pb.ArrayShortNews, error) {

	logs.New().Debugln("client send command search")
	sql, err := storage.FormatSQl(f)
	if err != nil {
		logs.New().Error(err)
		return nil, err
	}
	logs.New().Debugln(sql)
	word := storage.FormatWord(f.GetWord())
	startdate := f.GetPeriod().GetStartDate()
	enddate := f.GetPeriod().GetEndDate()
	logs.New().Debugln("Parametrs: ", word, startdate, enddate)
	sh, err := s.db.Search(sql,
		word,
		startdate,
		enddate)
	if err != nil {
		logs.New().Errorln(err)
		return nil, err
	}
	var RPCNews pb.ArrayShortNews
	for _, v := range sh {
		sendnews := pb.ShortNew{ID: v.ID,
			Title:       v.Title,
			Description: v.Description,
			Url:         v.Url,
			Time:        v.Time,
			Hash:        int64(v.Hash)}
		RPCNews.Sl = append(RPCNews.Sl, &sendnews)
	}
	logs.New().Debugln("client send command search proccesed count: ", len(RPCNews.GetSl()))
	return &RPCNews, nil
}
*/
