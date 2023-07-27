package model

import (
	"google.golang.org/grpc"
	"google.golang.org/grpc/connectivity"
)

type NewsClient interface {
	Client() *grpc.ClientConn
	Close() error
	GetState() connectivity.State
	AddNews(s *ShortNews) error
	ListPageNews(Page, limit uint32) (*ShortNews, error)
	ListNews(n uint64) (*ShortNews, error)
	DetailNews(n uint64) (*Short, error)
	SearchNews(word string, paramword string, fieldsort string, typesort string, startDate string, //начальная дата
		endDate string) (*ShortNews, error)
}

type CommentClient interface {
	Client() *grpc.ClientConn
	Close() error
	GetState() connectivity.State
	AddComment(c *Comment) (int64, error)
}
