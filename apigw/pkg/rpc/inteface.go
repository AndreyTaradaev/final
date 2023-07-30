//реализвция интерфесов для различных клиентов rpc

package rpc

import (
	pb "gateway/internal/model"

	"google.golang.org/grpc"
	"google.golang.org/grpc/connectivity"
)

type NewsClient interface {
	Client() *grpc.ClientConn
	Close() error
	GetState() connectivity.State
	ListPageNews(Page, limit int64) (*pb.ArrayShortNews, error)
	ListNews(n int64) (*pb.ArrayShortNews, error)
	DetailNews(n int64) (*pb.ShortNew, error)
	SearchNews(filter *pb.Filter) (*pb.ArrayShortNews, error)
}

type CommentClient interface {
	Client() *grpc.ClientConn
	Close() error
	GetState() connectivity.State
	AddComment(c *pb.Comment) (int64, error)
	Comments(idnews int64) (map[int64]*pb.Comment, error)
	DelComment(id int64) (bool, error)
}

type LoadClient interface {
	Client() *grpc.ClientConn
	Close() error
	GetState() connectivity.State
	AddNews(s *pb.ArrayShortNews) error
}
