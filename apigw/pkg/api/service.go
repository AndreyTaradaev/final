//формирование RPC Запросов
package api 


import(
	 //pb "gateway/internal/rpc"
	 "google.golang.org/grpc"
	 "gateway/apigw/pkg/config"
	 "fmt"
	 "google.golang.org/grpc/connectivity"
	 //logs "gateway/apigw/pkg/log"
	 "gateway/apigw/pkg/model"
	 "google.golang.org/grpc/credentials/insecure"

)

type Dial struct{
	client *grpc.ClientConn
} 

func NewClient()  *Dial {	
	ret := Dial{}	
	return &ret
} 

func (d *Dial) Connect( target string) error{
if (len(target)==0) {
	c := config.New()
	target =  fmt.Sprintf("%s:%d",c.Newshost(),c.Newsport())
}
client ,err := grpc.Dial(target,grpc.WithTransportCredentials( insecure.NewCredentials()), grpc.WithBlock() )
if(err != nil){
	return  err
}
d.client = client
return nil
}


func (d *Dial) Close() error{
	return d.client.Close()	
}

func (d *Dial) GetState()  connectivity.State  {
	return d.client.GetState()
}

func (d *Dial) AddNew (ShortNew model.Short )  {


}





   // c := pb.NewBaseServiceClient(conn)
