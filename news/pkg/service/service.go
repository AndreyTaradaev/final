package service

import  (
	pb "gateway/internal/rpc"
	"context"
	//logs "gateway/internal/log"
)


type RssServiceServer struct{
	pb.UnimplementedRssServiceServer
}

func (s *RssServiceServer) AddNew(ctx context.Context,sn * pb.ShortNew)  (*pb.Result,error){
	
	return &pb.Result{Ret:1,},nil
}


func (s *RssServiceServer) AddNews(pb.RssService_AddNewsServer) error {
		return nil
}
// list news
	func (s *RssServiceServer) 	List(*pb.Forlist, pb.RssService_ListServer) error{
		return nil
	}
// вернуть  список новостей на странице
	func (s *RssServiceServer)	ListPage(*pb.Page, pb.RssService_ListPageServer) error