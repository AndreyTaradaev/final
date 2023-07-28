package model

import (
	pb "gateway/internal/rpc"

	"google.golang.org/grpc"
	"google.golang.org/grpc/connectivity"
)

type NewsClient interface {
	Client() *grpc.ClientConn
	Close() error
	GetState() connectivity.State
	AddNews(s *ShortNews) error
	ListPageNews(Page, limit uint32) ([]*pb.ShortNew, error)
	ListNews(n uint64) ([]*pb.ShortNew, error)
	DetailNews(n uint64) (*pb.ShortNew, error)
	SearchNews(word string, paramword string, fieldsort string, typesort string, startDate string, //начальная дата
		endDate string) ([]*pb.ShortNew, error)
}

type CommentClient interface {
	Client() *grpc.ClientConn
	Close() error
	GetState() connectivity.State
	AddComment(c *Comment) (int64, error)
	Comments(idnews int64) (map[int64]*pb.Comment, error)
	DelComment(idnews int64) (bool, error)
}
