// формирование RPC Запросов
package rpcclient

import (
	"context"
	"fmt"
	logs "gateway/internal/log"
	"gateway/internal/model"
	pb "gateway/internal/rpc"
	"time"

	"google.golang.org/grpc"
	"google.golang.org/grpc/connectivity"
	"google.golang.org/grpc/credentials/insecure"
	"google.golang.org/grpc/keepalive"
)

var kacp = keepalive.ClientParameters{
	Time:                240 * time.Second, // send pings every 240 seconds if there is no activity
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
	ctx, cancel := context.WithTimeout(context.Background(), time.Second*time.Duration(ret.timeout))
	defer cancel()
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

// закрытие соединения
func (d *RPClient) Close() error {
	return d.client.Close()
}

// статус состояния соединения
func (d *RPClient) GetState() connectivity.State {
	return d.client.GetState()
}

// Загрузка RSS
func (d *RPClient) AddNews(s *model.ShortNews) error {
	client := pb.NewRssServiceClient(d.client)
	ctx, cancel := context.WithTimeout(context.Background(), time.Duration(d.timeout)*time.Second)
	defer cancel()
	stream, err := client.AddNews(ctx)
	if err != nil {
		logs.New().Error(err)
		return err
	}
	for _, v := range s.Get() {
		sh := pb.ShortNew{ID: v.ID, Title: v.Title, Description: v.Description, Time: v.Time, Hash: int64(v.Hash), Url: v.Url}
		if err := stream.Send(&sh); err != nil {
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
func (d *RPClient) ListPageNews(Page, limit uint32) ([]*pb.ShortNew, error) {

	client := pb.NewRssServiceClient(d.client)
	ctx, cancel := context.WithTimeout(context.Background(), time.Duration(d.timeout)*time.Second)
	defer cancel()
	pbPage := pb.Page{Limit: limit, Page: Page}
	array, err := client.ListPage(ctx, &pbPage)
	if err != nil {
		return nil, err
	}

	return array.GetSl(), nil
}

// вернуть список последних новостей  для веб-интефейса
func (d *RPClient) ListNews(n uint64) ([]*pb.ShortNew, error) {

	client := pb.NewRssServiceClient(d.client)
	ctx, cancel := context.WithTimeout(context.Background(), time.Duration(d.timeout)*time.Second)
	defer cancel()
	l := pb.Forlist{Count: n}
	array, err := client.List(ctx, &l)
	if err != nil {
		return nil, err
	}

	return array.GetSl(), nil
}

// детальная новость
func (d *RPClient) DetailNews(n uint64) (*pb.ShortNew, error) {
	client := pb.NewRssServiceClient(d.client)
	ctx, cancel := context.WithTimeout(context.Background(), time.Duration(d.timeout)*time.Second)
	defer cancel()
	l := pb.Forlist{Count: n}
	news, err := client.GetNews(ctx, &l)
	if err != nil {
		return nil, err
	}
	return news, nil
}

// поиск по фильтру
func (d *RPClient) SearchNews(word string, // слово для поиска
	paramword string, // параметр для поиска
	fieldsort string, //поле для сортировки
	typesort string, //тип сортировки
	startDate string, //начальная дата
	endDate string) ([]*pb.ShortNew, error) {
	//формируем структуру фильтра поиска
	pbFilter := pb.Filter{
		Word: &pb.FindWord{
			Search: word,
			Option: model.WordParam(paramword)},
		Sort: &pb.OptionSort{
			Field: model.FieldSort(fieldsort),
			Sort:  model.TypeSort(typesort)},
		Period: &pb.FilterDate{
			StartDate: model.GetIntDef(startDate, 0),
			EndDate:   model.GetIntDef(endDate, 0)},
	}
	client := pb.NewRssServiceClient(d.client)
	ctx, cancel := context.WithTimeout(context.Background(), time.Duration(d.timeout)*time.Second)
	defer cancel()
	array, err := client.Search(ctx, &pbFilter)
	if err != nil {
		return nil, err
	}
	return array.GetSl(), nil
}

// Добавление коментария
func (d *RPClient) AddComment(c *model.Comment) (int64, error) {

	client := pb.NewCommentServiceClient(d.client)
	ctx, cancel := context.WithTimeout(context.Background(), time.Duration(d.timeout)*time.Second)
	defer cancel()
	in := pb.Comment{IdComment: c.IdComment,
		Parent:   c.Parent,
		Content:  c.Content,
		IdNews:   c.IdNews,
		Time:     c.Time,
		AuthorId: c.AuthorId,
	}

	reply, err := client.AddComment(ctx, &in)
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
	f := pb.Forlist{Count: uint64(idnews)}
	ar, err := client.TreeComment(ctx, &f)
	if err != nil {
		return nil, err
	}
	return ar.GetAnswer(), nil
}

// удаление  соментария ,на деле мы небудем удалять а ставтиь метку.
func (d *RPClient) DelComment(id int64) (bool, error) {
	client := pb.NewCommentServiceClient(d.client)
	ctx, cancel := context.WithTimeout(context.Background(), time.Duration(d.timeout)*time.Second)
	defer cancel()
	f := pb.Forlist{Count: uint64(id)}
	ret, err := client.DelComment(ctx, &f)
	if err != nil {
		return false, err
	}
	return ret.GetRet() == id, nil
}
