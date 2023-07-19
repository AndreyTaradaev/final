// Code generated by protoc-gen-go-grpc. DO NOT EDIT.
// versions:
// - protoc-gen-go-grpc v1.3.0
// - protoc             v4.24.0--rc1
// source: apigetway.proto

// имя пакета, в результирующем go-файле это сохраниться

package rpc

import (
	context "context"
	grpc "google.golang.org/grpc"
	codes "google.golang.org/grpc/codes"
	status "google.golang.org/grpc/status"
)

// This is a compile-time assertion to ensure that this generated file
// is compatible with the grpc package it is being compiled against.
// Requires gRPC-Go v1.32.0 or later.
const _ = grpc.SupportPackageIsVersion7

const (
	RssService_AddNew_FullMethodName   = "/rpc_news.RssService/AddNew"
	RssService_AddNews_FullMethodName  = "/rpc_news.RssService/AddNews"
	RssService_List_FullMethodName     = "/rpc_news.RssService/List"
	RssService_ListPage_FullMethodName = "/rpc_news.RssService/ListPage"
)

// RssServiceClient is the client API for RssService service.
//
// For semantics around ctx use and closing/ending streaming RPCs, please refer to https://pkg.go.dev/google.golang.org/grpc/?tab=doc#ClientConn.NewStream.
type RssServiceClient interface {
	// add news
	AddNew(ctx context.Context, in *ShortNew, opts ...grpc.CallOption) (*Result, error)
	AddNews(ctx context.Context, opts ...grpc.CallOption) (RssService_AddNewsClient, error)
	// list news
	List(ctx context.Context, in *Forlist, opts ...grpc.CallOption) (RssService_ListClient, error)
	// вернуть  список новостей на странице
	ListPage(ctx context.Context, in *Page, opts ...grpc.CallOption) (RssService_ListPageClient, error)
}

type rssServiceClient struct {
	cc grpc.ClientConnInterface
}

func NewRssServiceClient(cc grpc.ClientConnInterface) RssServiceClient {
	return &rssServiceClient{cc}
}

func (c *rssServiceClient) AddNew(ctx context.Context, in *ShortNew, opts ...grpc.CallOption) (*Result, error) {
	out := new(Result)
	err := c.cc.Invoke(ctx, RssService_AddNew_FullMethodName, in, out, opts...)
	if err != nil {
		return nil, err
	}
	return out, nil
}

func (c *rssServiceClient) AddNews(ctx context.Context, opts ...grpc.CallOption) (RssService_AddNewsClient, error) {
	stream, err := c.cc.NewStream(ctx, &RssService_ServiceDesc.Streams[0], RssService_AddNews_FullMethodName, opts...)
	if err != nil {
		return nil, err
	}
	x := &rssServiceAddNewsClient{stream}
	return x, nil
}

type RssService_AddNewsClient interface {
	Send(*ShortNew) error
	CloseAndRecv() (*Result, error)
	grpc.ClientStream
}

type rssServiceAddNewsClient struct {
	grpc.ClientStream
}

func (x *rssServiceAddNewsClient) Send(m *ShortNew) error {
	return x.ClientStream.SendMsg(m)
}

func (x *rssServiceAddNewsClient) CloseAndRecv() (*Result, error) {
	if err := x.ClientStream.CloseSend(); err != nil {
		return nil, err
	}
	m := new(Result)
	if err := x.ClientStream.RecvMsg(m); err != nil {
		return nil, err
	}
	return m, nil
}

func (c *rssServiceClient) List(ctx context.Context, in *Forlist, opts ...grpc.CallOption) (RssService_ListClient, error) {
	stream, err := c.cc.NewStream(ctx, &RssService_ServiceDesc.Streams[1], RssService_List_FullMethodName, opts...)
	if err != nil {
		return nil, err
	}
	x := &rssServiceListClient{stream}
	if err := x.ClientStream.SendMsg(in); err != nil {
		return nil, err
	}
	if err := x.ClientStream.CloseSend(); err != nil {
		return nil, err
	}
	return x, nil
}

type RssService_ListClient interface {
	Recv() (*ShortNew, error)
	grpc.ClientStream
}

type rssServiceListClient struct {
	grpc.ClientStream
}

func (x *rssServiceListClient) Recv() (*ShortNew, error) {
	m := new(ShortNew)
	if err := x.ClientStream.RecvMsg(m); err != nil {
		return nil, err
	}
	return m, nil
}

func (c *rssServiceClient) ListPage(ctx context.Context, in *Page, opts ...grpc.CallOption) (RssService_ListPageClient, error) {
	stream, err := c.cc.NewStream(ctx, &RssService_ServiceDesc.Streams[2], RssService_ListPage_FullMethodName, opts...)
	if err != nil {
		return nil, err
	}
	x := &rssServiceListPageClient{stream}
	if err := x.ClientStream.SendMsg(in); err != nil {
		return nil, err
	}
	if err := x.ClientStream.CloseSend(); err != nil {
		return nil, err
	}
	return x, nil
}

type RssService_ListPageClient interface {
	Recv() (*ShortNew, error)
	grpc.ClientStream
}

type rssServiceListPageClient struct {
	grpc.ClientStream
}

func (x *rssServiceListPageClient) Recv() (*ShortNew, error) {
	m := new(ShortNew)
	if err := x.ClientStream.RecvMsg(m); err != nil {
		return nil, err
	}
	return m, nil
}

// RssServiceServer is the server API for RssService service.
// All implementations must embed UnimplementedRssServiceServer
// for forward compatibility
type RssServiceServer interface {
	// add news
	AddNew(context.Context, *ShortNew) (*Result, error)
	AddNews(RssService_AddNewsServer) error
	// list news
	List(*Forlist, RssService_ListServer) error
	// вернуть  список новостей на странице
	ListPage(*Page, RssService_ListPageServer) error
	mustEmbedUnimplementedRssServiceServer()
}

// UnimplementedRssServiceServer must be embedded to have forward compatible implementations.
type UnimplementedRssServiceServer struct {
}

func (UnimplementedRssServiceServer) AddNew(context.Context, *ShortNew) (*Result, error) {
	return nil, status.Errorf(codes.Unimplemented, "method AddNew not implemented")
}
func (UnimplementedRssServiceServer) AddNews(RssService_AddNewsServer) error {
	return status.Errorf(codes.Unimplemented, "method AddNews not implemented")
}
func (UnimplementedRssServiceServer) List(*Forlist, RssService_ListServer) error {
	return status.Errorf(codes.Unimplemented, "method List not implemented")
}
func (UnimplementedRssServiceServer) ListPage(*Page, RssService_ListPageServer) error {
	return status.Errorf(codes.Unimplemented, "method ListPage not implemented")
}
func (UnimplementedRssServiceServer) mustEmbedUnimplementedRssServiceServer() {}

// UnsafeRssServiceServer may be embedded to opt out of forward compatibility for this service.
// Use of this interface is not recommended, as added methods to RssServiceServer will
// result in compilation errors.
type UnsafeRssServiceServer interface {
	mustEmbedUnimplementedRssServiceServer()
}

func RegisterRssServiceServer(s grpc.ServiceRegistrar, srv RssServiceServer) {
	s.RegisterService(&RssService_ServiceDesc, srv)
}

func _RssService_AddNew_Handler(srv interface{}, ctx context.Context, dec func(interface{}) error, interceptor grpc.UnaryServerInterceptor) (interface{}, error) {
	in := new(ShortNew)
	if err := dec(in); err != nil {
		return nil, err
	}
	if interceptor == nil {
		return srv.(RssServiceServer).AddNew(ctx, in)
	}
	info := &grpc.UnaryServerInfo{
		Server:     srv,
		FullMethod: RssService_AddNew_FullMethodName,
	}
	handler := func(ctx context.Context, req interface{}) (interface{}, error) {
		return srv.(RssServiceServer).AddNew(ctx, req.(*ShortNew))
	}
	return interceptor(ctx, in, info, handler)
}

func _RssService_AddNews_Handler(srv interface{}, stream grpc.ServerStream) error {
	return srv.(RssServiceServer).AddNews(&rssServiceAddNewsServer{stream})
}

type RssService_AddNewsServer interface {
	SendAndClose(*Result) error
	Recv() (*ShortNew, error)
	grpc.ServerStream
}

type rssServiceAddNewsServer struct {
	grpc.ServerStream
}

func (x *rssServiceAddNewsServer) SendAndClose(m *Result) error {
	return x.ServerStream.SendMsg(m)
}

func (x *rssServiceAddNewsServer) Recv() (*ShortNew, error) {
	m := new(ShortNew)
	if err := x.ServerStream.RecvMsg(m); err != nil {
		return nil, err
	}
	return m, nil
}

func _RssService_List_Handler(srv interface{}, stream grpc.ServerStream) error {
	m := new(Forlist)
	if err := stream.RecvMsg(m); err != nil {
		return err
	}
	return srv.(RssServiceServer).List(m, &rssServiceListServer{stream})
}

type RssService_ListServer interface {
	Send(*ShortNew) error
	grpc.ServerStream
}

type rssServiceListServer struct {
	grpc.ServerStream
}

func (x *rssServiceListServer) Send(m *ShortNew) error {
	return x.ServerStream.SendMsg(m)
}

func _RssService_ListPage_Handler(srv interface{}, stream grpc.ServerStream) error {
	m := new(Page)
	if err := stream.RecvMsg(m); err != nil {
		return err
	}
	return srv.(RssServiceServer).ListPage(m, &rssServiceListPageServer{stream})
}

type RssService_ListPageServer interface {
	Send(*ShortNew) error
	grpc.ServerStream
}

type rssServiceListPageServer struct {
	grpc.ServerStream
}

func (x *rssServiceListPageServer) Send(m *ShortNew) error {
	return x.ServerStream.SendMsg(m)
}

// RssService_ServiceDesc is the grpc.ServiceDesc for RssService service.
// It's only intended for direct use with grpc.RegisterService,
// and not to be introspected or modified (even as a copy)
var RssService_ServiceDesc = grpc.ServiceDesc{
	ServiceName: "rpc_news.RssService",
	HandlerType: (*RssServiceServer)(nil),
	Methods: []grpc.MethodDesc{
		{
			MethodName: "AddNew",
			Handler:    _RssService_AddNew_Handler,
		},
	},
	Streams: []grpc.StreamDesc{
		{
			StreamName:    "AddNews",
			Handler:       _RssService_AddNews_Handler,
			ClientStreams: true,
		},
		{
			StreamName:    "List",
			Handler:       _RssService_List_Handler,
			ServerStreams: true,
		},
		{
			StreamName:    "ListPage",
			Handler:       _RssService_ListPage_Handler,
			ServerStreams: true,
		},
	},
	Metadata: "apigetway.proto",
}
