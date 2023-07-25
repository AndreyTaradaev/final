package service

import (
	"context"
	logs "gateway/internal/log"
	"gateway/internal/model"
	pb "gateway/internal/rpc"
	"gateway/news/pkg/storage"
	"io"
	"net"

	"google.golang.org/grpc"
)

type RssServiceServer struct {
	pb.UnimplementedRssServiceServer
	db *storage.DB
}

// запуск микросервиса новостей
func RunServer(lis *net.Listener) error {
	var opts []grpc.ServerOption
	grpcServer := grpc.NewServer(opts...)
	NS, err := newServer()
	if err != nil {
		grpcServer.Stop()
		return err
	}
	pb.RegisterRssServiceServer(grpcServer, NS)
	logs.New().Debug(grpcServer.GetServiceInfo())
	grpcServer.Serve(*lis)
	return nil
}

// конструктор RPC сервера
func newServer() (*RssServiceServer, error) {
	db, err := storage.New()
	if err != nil {
		return nil, err
	}
	ret := RssServiceServer{db: db}
	return &ret, nil
}

// добавить новости
func (s *RssServiceServer) AddNews(stream pb.RssService_AddNewsServer) error {
	var StrErr []string
	var i int32 = 0
	var m model.Short
	logs.New().Debug("client send  data")
	for {
		S, err := stream.Recv()
		if err == io.EOF {
			// дошли до конца  отправляем клиенту результат
			logs.New().Debug("client's data has been processed")
			return stream.SendAndClose(&pb.Result{Ret: i, Error: StrErr})
		}
		if err != nil {
			logs.New().Error(err)
			return err
		}
		m.Convert(S)
		err = s.db.AddNew(m) // ошибки добавления отправим роутеру
		if err != nil {
			StrErr = append(StrErr, m.Url+" "+err.Error())
		}
		i++
	}
	return nil
}

// вернуть  список новостей на странице
func (s *RssServiceServer) ListPage(ctx context.Context, page *pb.Page) (*pb.ArrayShortNews, error) {
	logs.New().Debug("client send command list page")
	sh, err := s.db.ListPage(int(page.GetLimit()),
		int(page.GetPage()))

	if err != nil {
		logs.New().Error(err)
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
	logs.New().Debug("client send command list proccesed count: ", len(RPCNews.GetSl()))
	return &RPCNews, nil
}

// вернуть список последних новостей  для веб-интефейса
func (s *RssServiceServer) List(ctx context.Context, list *pb.Forlist) (*pb.ArrayShortNews, error) {
	logs.New().Debug("client send command list")
	sh, err := s.db.List(int(list.GetCount()))
	if err != nil {
		logs.New().Error(err)
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
	logs.New().Debug("client send command list proccesed count: ", len(RPCNews.GetSl()))
	return &RPCNews, nil

}

// детальная новость
func (s *RssServiceServer) GetNews(ctx context.Context, list *pb.Forlist) (*pb.ShortNew, error) {
	logs.New().Debug("client send command  full news ")
	v, err := s.db.GetNews(int(list.GetCount()))
	if err != nil {
		logs.New().Error(err)
		return nil, err
	}
	sendnews := pb.ShortNew{ID: v.ID,
		Title:       v.Title,
		Description: v.Description,
		Url:         v.Url,
		Time:        v.Time,
		Hash:        int64(v.Hash)}

	logs.New().Debug("client send command full news  proccesed ")
	return &sendnews, nil
}

// поиск новостей
func (s *RssServiceServer) Search(ctx context.Context, f *pb.Filter) (*pb.ArrayShortNews, error) {

	logs.New().Debug("client send command search")
	fdb := model.Convert(f)
	sh, err := s.db.Search(fdb)
	if err != nil {
		logs.New().Error(err)
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
	logs.New().Debug("client send command search proccesed count: ", len(RPCNews.GetSl()))
	return &RPCNews, nil
}
