package storage

import pb "gateway/internal/model"

type DBInterface interface {
	Close()
	AddNew(news *pb.ShortNew) error
	List(n int64) (*pb.ArrayShortNews, error)
	ListPage(limit, Page int64) (*pb.ArrayShortNews, error)
	GetNews(i int64) (*pb.ShortNew, error)
	Search(f *pb.Filter) (*pb.ArrayShortNews, error)
}
