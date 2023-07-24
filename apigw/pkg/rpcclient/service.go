// формирование RPC Запросов
package rpcclient

import (
	"context"
	"fmt"

	//"gateway/apigw/pkg/config"
	logs "gateway/internal/log"
	pb "gateway/internal/rpc"
	"gateway/internal/model"
	"io"
	"time"

	"google.golang.org/grpc"
	"google.golang.org/grpc/connectivity"
	"google.golang.org/grpc/credentials/insecure"
	"google.golang.org/grpc/keepalive"
)

 var kacp = keepalive.ClientParameters{
    Time:                10 * time.Second, // send pings every 10 seconds if there is no activity
    Timeout:             time.Second,      // wait 1 second for ping back
    PermitWithoutStream: true,             // send pings even without active streams
} 

type RPClient struct {
	client *grpc.ClientConn
}

const timeout int = 120


// конструктор для соединения по RPC
// создает соединение с микросервисем
func  Connect  (target string) (*RPClient, error) {
	
	if len(target) == 0 {
		return nil, fmt.Errorf("server RPC is emply")
	}
	ret := RPClient{}	
	logs.New().Debug(" RPC connect  server: ",target )
	client, err := grpc.Dial(target, grpc.WithTransportCredentials(insecure.NewCredentials()), grpc.WithBlock(),grpc.WithKeepaliveParams(kacp))
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
	logs.New().Debug("RPC client:", d.client.Target(), " close")
	return d.client.Close()
}

// статус состояния соединения
func (d *RPClient) GetState() connectivity.State {
	return d.client.GetState()
}

//  Загрузка RSS   
func (d *RPClient) RunRssServiceAddNews(s model.ShortNews) error {
	client := pb.NewRssServiceClient(d.client)
	ctx, cancel := context.WithTimeout(context.Background(), time.Duration(timeout)*time.Second)
	defer cancel()
	stream, err := client.AddNews(ctx)
	if err != nil {
		return err
	}
	for _, v := range s.Get() {
		sh := pb.ShortNew{ID: v.ID, Title: v.Title, Description: v.Description, Time: v.Time, Hash: int64(v.Hash), Url: v.Url}
		if err := stream.Send(&sh); err != nil {
			logs.New().Debug(err)
			return err
		}
	}
	_, err = stream.CloseAndRecv()
	if err != nil {
		return err
	}
	return nil
}

/* func (d *RPClient) RunRssServiceList() (model.ShortNews, error) {
	var sn model.ShortNews
	client := pb.NewRssServiceClient(d.client)
	ctx, cancel := context.WithTimeout(context.Background(), 10*time.Second)
	defer cancel()
	stream, err := client.List(ctx, &pb.Forlist{})
	if err != nil {
		return sn, err
	}
	var rss model.Short
	for {

		serverNews, err := stream.Recv()
		if err == io.EOF {
			break
		}
		if err != nil {
			return sn, err
		}
		rss.Convert(serverNews)
		sn.Add(rss)
	}
	return sn, nil
}
//ошибка Page Это лимит
func (d *RPClient) RunRssServicePage(Page,limit int32) (model.ShortNews, error) {
	var sn model.ShortNews
	client := pb.NewRssServiceClient(d.client)
	ctx, cancel := context.WithTimeout(context.Background(), 10*time.Second)
	defer cancel()
	pbPage :=  pb.Page{Limit : limit,Page: Page}
	stream, err := client.ListPage(ctx,&pbPage)	
	if err != nil {
		return sn, err
	}
	var rss model.Short
	for {

		serverNews, err := stream.Recv()
		if err == io.EOF {
			break
		}
		if err != nil {
			return sn, err
		}
		rss.Convert(serverNews)
		sn.Add(rss)
	}
	return sn, nil
}
 */

/*func (d *Dial) AddNew (ShortNew model.Short )  {


}
*/

// c := pb.NewBaseServiceClient(conn)
