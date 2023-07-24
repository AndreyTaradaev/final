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

func RunServer(lis *net.Listener) error {
	var opts []grpc.ServerOption
	grpcServer := grpc.NewServer(opts...)
	NS, err := newServer()
	if err != nil {
		return err
	}
	pb.RegisterRssServiceServer(grpcServer, NS)
	grpcServer.Serve(*lis)
	return nil
}

func newServer() (*RssServiceServer, error) {
	db, err := storage.New()
	if err != nil {
		return nil, err
	}
	ret := RssServiceServer{db: db}
	return &ret, nil
}

type RssServiceServer struct {
	pb.UnimplementedRssServiceServer
	db *storage.DB
}

func (s *RssServiceServer) AddNew(ctx context.Context, sn *pb.ShortNew) (*pb.Result, error) {

	return &pb.Result{Ret: 1}, nil
}

func (s *RssServiceServer) AddNews(stream pb.RssService_AddNewsServer) error {

	var sh model.ShortNews
	logs.New().Debug("client send  data")
	for {
		S, err := stream.Recv()
		var m model.Short
		if err == io.EOF {
			// дошли до конца  запись в БД
			logs.New().Debug("client end send data count", sh.Len())
			logs.New().Info("Write news to database")
			go s.db.AddNews(sh.Get())
			return stream.SendAndClose(&pb.Result{Ret: int32(sh.Len()), Error: []string{}})
		}
		if err != nil {
			return err
		}
		m.Convert(S)
		sh.Add(m)
	}	
}

//handler rpc  list news
func (s *RssServiceServer) List(l *pb.Forlist, stream pb.RssService_ListServer) error {
	logs.New().Debug("client send command list")
	sh, err := s.db.List(0, 0)
	if err != nil {
		logs.New().Error(err)
		return err
	}
	for _, v := range sh {
		sendnews := pb.ShortNew{ID: v.ID,
			Title:       v.Title,
			Description: v.Description,
			Url:         v.Url,
			Time:        v.Time,
			Hash:        int64(v.Hash)}
		err = stream.Send(&sendnews)
		if err != nil {
			logs.New().Error(err)
			return err
		}

	}
	return nil
}

// вернуть  список новостей на странице
func (s *RssServiceServer) ListPage(page *pb.Page, stream pb.RssService_ListPageServer) error {
	logs.New().Debug("client send command list page")
	sh, err := s.db.List(uint(page.Limit), uint(page.Offset))
	if err != nil {
		logs.New().Error(err)
		return err
	}
	for _, v := range sh {
		sendnews := pb.ShortNew{ID: v.ID,
			Title:       v.Title,
			Description: v.Description,
			Url:         v.Url,
			Time:        v.Time,
			Hash:        int64(v.Hash)}
		err = stream.Send(&sendnews)
		if err != nil {
			logs.New().Error(err)
			return err
		}

	}
	return nil
}
