package service

import (
	"context"
	logs "gateway/internal/log"
	pb "gateway/internal/model"
	"gateway/news/pkg/storage"
	"gateway/news/pkg/storage/postgres"
	"io"
	"net"

	"google.golang.org/grpc"
)

type RssServiceServer struct {
	pb.UnimplementedRssServiceServer
	db storage.DBInterface
}

// запуск микросервиса новостей.
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

// конструктор RPC сервера закрытый.
func newServer() (*RssServiceServer, error) {
	dbpost, err := postgres.New()
	if err != nil {
		return nil, err
	}
	ret := RssServiceServer{db: dbpost}
	return &ret, nil
}

// добавить новости.
func (s *RssServiceServer) AddNews(stream pb.RssService_AddNewsServer) error {
	logger := logs.New()
	var StrErr []string
	var i int64 = 0
	logs.New().Debugln("router  send ")
	for {
		sh, err := stream.Recv()
		if err == io.EOF {
			// дошли до конца  отправляем клиенту результат
			logger.Debugln("client's data has been processed count:", i, "error", len(StrErr))
			return stream.SendAndClose(&pb.Result{Ret: i, Error: StrErr})
		}
		if err != nil {
			logger.Errorln(err)
			return err
		}
		err = s.db.AddNew(sh) // ошибки добавления отправим роутеру
		if err != nil {
			StrErr = append(StrErr, sh.GetLink()+" "+err.Error())
		}
		i++
	}
}

// вернуть  список новостей на странице.
func (s *RssServiceServer) ListPage(ctx context.Context, page *pb.Page) (*pb.ArrayShortNews, error) {
	logger := logs.New()
	logger.Debugln("client send command list page")
	sh, err := s.db.ListPage(page.GetLimit(), page.GetPage())
	if err != nil {
		logs.New().Errorln(err)
		return nil, err
	}
	logger.Debugln("client send command list proccesed count: ", sh.Len())
	return sh, nil
}

// вернуть список последних новостей  для веб-интефейса.
func (s *RssServiceServer) List(ctx context.Context, list *pb.Forlist) (*pb.ArrayShortNews, error) {
	logger := logs.New()
	logger.Debugln("client send command list for web")
	sh, err := s.db.List(list.GetId())
	if err != nil {
		logger.Errorln(err)
		return nil, err
	}

	logger.Debugln("client send command list proccesed count: ", sh.Len())
	return sh, nil
}

// детальная новость.
func (s *RssServiceServer) GetNews(ctx context.Context, list *pb.Forlist) (*pb.ShortNew, error) {
	logger := logs.New()
	logger.Debugln("client send command  full news ")
	v, err := s.db.GetNews(list.GetId())
	if err != nil {
		logger.Errorln(err)
		return nil, err
	}
	logger.Debugln("client send command full news  proccesed ")
	return v, nil
}

// поиск новостей
func (s *RssServiceServer) Search(ctx context.Context, f *pb.Filter) (*pb.ArrayShortNews, error) {
	logger := logs.New()
	logger.Debugln("client send command search")
	//logger.Debugf("struct Filter : %#v", f)

	sh, err := s.db.Search(f)
	if err != nil {
		logger.Errorln(err)
		return nil, err
	}
	logs.New().Debugln("client send command search proccesed count: ", sh.Len())
	return sh, nil
}
