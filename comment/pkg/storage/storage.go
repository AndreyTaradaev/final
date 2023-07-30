package storage

import pb "gateway/internal/model"

type DBInterface interface {
	Close()
	AddComment(comment *pb.Comment) (int64, error)
	DelComment(id *pb.Forlist) (int64, error)
	Comments(id *pb.Forlist) (*pb.TreeComments, error)
}
