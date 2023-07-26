// формирование RPC Запросов
package rpcclient

import (
	"context"
	"fmt"
	logs "gateway/internal/log"
	"gateway/internal/model"
	pb "gateway/internal/rpc"

	//"io"
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
	client, err := grpc.Dial(target, grpc.WithTransportCredentials(insecure.NewCredentials()), grpc.WithBlock(), grpc.WithKeepaliveParams(kacp))
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

// закрытие соединения
func (d *RPClient) Close() error {
	return d.client.Close()
}

// статус состояния соединения
func (d *RPClient) GetState() connectivity.State {
	return d.client.GetState()
}

// Загрузка RSS
func (d *RPClient) RunRssServiceAddNews(s *model.ShortNews) error {
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
func (d *RPClient) RunRssServiceListPage(Page, limit uint32) (*model.ShortNews, error) {
	var sn model.ShortNews
	client := pb.NewRssServiceClient(d.client)
	ctx, cancel := context.WithTimeout(context.Background(), time.Duration(d.timeout)*time.Second)
	defer cancel()
	pbPage := pb.Page{Limit: limit, Page: Page}
	array, err := client.ListPage(ctx, &pbPage)
	if err != nil {
		return nil, err
	}
	for _, v := range array.GetSl() {
		sn.Append(v)
	}
	return &sn, nil
}

// вернуть список последних новостей  для веб-интефейса
func (d *RPClient) RunRssServiceList(n uint64) (*model.ShortNews, error) {
	var sn model.ShortNews
	client := pb.NewRssServiceClient(d.client)
	ctx, cancel := context.WithTimeout(context.Background(), time.Duration(d.timeout)*time.Second)
	defer cancel()
	l := pb.Forlist{Count: n}
	array, err := client.List(ctx, &l)
	if err != nil {
		return nil, err
	}
	for _, v := range array.GetSl() {
		sn.Append(v)
	}
	return &sn, nil
}

// детальная новость
func (d *RPClient) RunRssServiceGetNews(n uint64) (*model.Short, error) {
	var sn model.Short
	client := pb.NewRssServiceClient(d.client)
	ctx, cancel := context.WithTimeout(context.Background(), time.Duration(d.timeout)*time.Second)
	defer cancel()
	l := pb.Forlist{Count: n}
	news, err := client.GetNews(ctx, &l)
	if err != nil {
		return nil, err
	}
	sn.Convert(news)
	return &sn, nil
}

// поиск по фильтру
func (d *RPClient) RunRssServiceSearch(word string, // слово для поиска
	paramword string, // параметр для поиска
	fieldsort string, //поле для сортировки
	typesort string, //тип сортировки
	startDate string, //начальная дата
	endDate string, //конечнаядата дата
) (*model.ShortNews, error) {
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

	var sn model.ShortNews
	client := pb.NewRssServiceClient(d.client)
	ctx, cancel := context.WithTimeout(context.Background(), time.Duration(d.timeout)*time.Second)
	defer cancel()
	array, err := client.Search(ctx, &pbFilter)
	if err != nil {
		return nil, err
	}
	for _, v := range array.GetSl() {
		sn.Append(v)
	}
	return &sn, nil
}
