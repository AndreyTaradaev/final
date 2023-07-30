// формирование RPC Запросов
package service

import (
	"context"
	"fmt"
	logs "gateway/internal/log"
	pb "gateway/internal/model"
	"time"

	"google.golang.org/grpc"
	"google.golang.org/grpc/connectivity"
	"google.golang.org/grpc/credentials/insecure"
	"google.golang.org/grpc/keepalive"
)

var kacp = keepalive.ClientParameters{
	Time:                120 * time.Second, // send pings every 120 seconds if there is no activity
	Timeout:             3 * time.Second,   // wait 1 second for ping back
	PermitWithoutStream: true,              // send pings even without active streams
}

type RPClient struct {
	client  *grpc.ClientConn
	timeout int
}

// конструктор для соединения по RPC
// создает соединение с микросервисем
func Connect(target string, time_out int) (*RPClient, error) {

	if len(target) == 0 {
		return nil, fmt.Errorf("server RPC is emply")
	}
	ret := RPClient{timeout: time_out}
	logs.New().Debug(" RPC connect  server: ", target)
	client, err := grpc.Dial(target, grpc.WithTransportCredentials(insecure.NewCredentials()) /*grpc.WithBlock()  ,*/, grpc.WithKeepaliveParams(kacp))
	if err != nil {
		return nil, err
	}
	ret.client = client
	return &ret, nil
}

// // создает соединение с микросервисем c контекстом  по таймауту для загрузки RSS новостей
func ConnectWithContext(target string, time_out int) (*RPClient, error) {

	if len(target) == 0 {
		return nil, fmt.Errorf("server RPC is emply")
	}
	ret := RPClient{timeout: time_out}
	ctx, _ := context.WithTimeout(context.Background(), time.Second*time.Duration(ret.timeout))
	client, err := grpc.DialContext(ctx, target, grpc.WithTransportCredentials(insecure.NewCredentials()), grpc.WithBlock())
	if err != nil {
		return nil, err
	}
	ret.client = client
	return &ret, nil
}

// геттер клиента.
func (d *RPClient) Client() *grpc.ClientConn {
	return d.client
}

// закрытие соединения.
func (d *RPClient) Close() error {
	return d.client.Close()
}

// статус состояния соединения.
func (d *RPClient) GetState() connectivity.State {
	return d.client.GetState()
}

// Загрузка RSS
func (d *RPClient) AddNews(s *pb.ArrayShortNews) error {
	client := pb.NewRssServiceClient(d.client)
	ctx, cancel := context.WithTimeout(context.Background(), time.Duration(d.timeout)*time.Second)
	defer cancel()
	stream, err := client.AddNews(ctx)
	if err != nil {
		logs.New().Error(err)
		return err
	}
	for _, v := range s.GetArray() {
		if err := stream.Send(v); err != nil {
			logs.New().Error(err)
			return err
		}
	}
	reply, err := stream.CloseAndRecv()
	if err != nil {
		logs.New().Error(err)
		return err
	}
	logs.New().Debug("server return result, count error: ", len(reply.GetError()), " processed ", reply.GetRet())
	return nil
}

// получение списка новостей по RPC
// вернуть  список новостей на странице
func (d *RPClient) ListPageNews(Page, limit int64) ([]*pb.ShortNew, error) {

	client := pb.NewRssServiceClient(d.client)
	ctx, cancel := context.WithTimeout(context.Background(), time.Duration(d.timeout)*time.Second)
	defer cancel()
	pbPage := pb.Page{Limit: limit, Page: Page}
	array, err := client.ListPage(ctx, &pbPage)
	if err != nil {
		return nil, err
	}

	return array.GetArray(), nil
}

// вернуть список последних новостей  для веб-интефейса
func (d *RPClient) ListNews(n int64) ([]*pb.ShortNew, error) {

	client := pb.NewRssServiceClient(d.client)
	ctx, cancel := context.WithTimeout(context.Background(), time.Duration(d.timeout)*time.Second)
	defer cancel()
	l := pb.Forlist{Id: n}
	array, err := client.List(ctx, &l)
	if err != nil {
		return nil, err
	}
	return array.GetArray(), nil
}

// детальная новость
func (d *RPClient) DetailNews(n int64) (*pb.ShortNew, error) {
	client := pb.NewRssServiceClient(d.client)
	ctx, cancel := context.WithTimeout(context.Background(), time.Duration(d.timeout)*time.Second)
	defer cancel()
	l := pb.Forlist{Id: n}
	news, err := client.GetNews(ctx, &l)
	if err != nil {
		return nil, err
	}
	return news, nil
}

// поиск по фильтру
func (d *RPClient) SearchNews(filter *pb.Filter) ([]*pb.ShortNew, error) {

	client := pb.NewRssServiceClient(d.client)
	ctx, cancel := context.WithTimeout(context.Background(), time.Duration(d.timeout)*time.Second)
	defer cancel()
	array, err := client.Search(ctx, filter)
	if err != nil {
		return nil, err
	}
	return array.GetArray(), nil
}

// Добавление коментария
func (d *RPClient) AddComment(c *pb.Comment) (int64, error) {

	client := pb.NewCommentServiceClient(d.client)
	ctx, cancel := context.WithTimeout(context.Background(), time.Duration(d.timeout)*time.Second)
	defer cancel()

	reply, err := client.AddComment(ctx, c)
	if err != nil {
		return 0, err
	}
	return reply.GetRet(), nil
}

// получение дерева коментариев
func (d *RPClient) Comments(idnews int64) (map[int64]*pb.Comment, error) {

	client := pb.NewCommentServiceClient(d.client)
	ctx, cancel := context.WithTimeout(context.Background(), time.Duration(d.timeout)*time.Second)
	defer cancel()
	f := pb.Forlist{Id: idnews}
	ar, err := client.TreeComment(ctx, &f)
	if err != nil {
		return nil, err
	}
	return ar.GetComments(), nil
}

// удаление  соментария ,на деле мы небудем удалять а ставтиь метку.
func (d *RPClient) DelComment(id int64) (bool, error) {
	client := pb.NewCommentServiceClient(d.client)
	ctx, cancel := context.WithTimeout(context.Background(), time.Duration(d.timeout)*time.Second)
	defer cancel()
	f := pb.Forlist{Id: id}
	ret, err := client.DelComment(ctx, &f)
	if err != nil {
		return false, err
	}
	return ret.GetRet() == id, nil
}
