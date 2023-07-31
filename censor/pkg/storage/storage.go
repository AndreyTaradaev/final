package storage

import pb "gateway/internal/model"

type DBInterface interface {
	Close()
	CheckComment(*pb.Comment) (bool, error)
	AddWord(word string) error
}
