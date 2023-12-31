// Code generated by protoc-gen-go-grpc. DO NOT EDIT.
// versions:
// - protoc-gen-go-grpc v1.3.0
// - protoc             v4.24.0--rc1
// source: apigetway.proto

// имя пакета, в результирующем go-файле это сохраниться

package model

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
	RssService_AddNews_FullMethodName  = "/rpc_news.RssService/AddNews"
	RssService_List_FullMethodName     = "/rpc_news.RssService/List"
	RssService_ListPage_FullMethodName = "/rpc_news.RssService/ListPage"
	RssService_GetNews_FullMethodName  = "/rpc_news.RssService/GetNews"
	RssService_Search_FullMethodName   = "/rpc_news.RssService/Search"
)

// RssServiceClient is the client API for RssService service.
//
// For semantics around ctx use and closing/ending streaming RPCs, please refer to https://pkg.go.dev/google.golang.org/grpc/?tab=doc#ClientConn.NewStream.
type RssServiceClient interface {
	// add news
	AddNews(ctx context.Context, opts ...grpc.CallOption) (RssService_AddNewsClient, error)
	// list news
	List(ctx context.Context, in *Forlist, opts ...grpc.CallOption) (*ArrayShortNews, error)
	ListPage(ctx context.Context, in *Page, opts ...grpc.CallOption) (*ArrayShortNews, error)
	GetNews(ctx context.Context, in *Forlist, opts ...grpc.CallOption) (*ShortNew, error)
	Search(ctx context.Context, in *Filter, opts ...grpc.CallOption) (*ArrayShortNews, error)
}

type rssServiceClient struct {
	cc grpc.ClientConnInterface
}

func NewRssServiceClient(cc grpc.ClientConnInterface) RssServiceClient {
	return &rssServiceClient{cc}
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

func (c *rssServiceClient) List(ctx context.Context, in *Forlist, opts ...grpc.CallOption) (*ArrayShortNews, error) {
	out := new(ArrayShortNews)
	err := c.cc.Invoke(ctx, RssService_List_FullMethodName, in, out, opts...)
	if err != nil {
		return nil, err
	}
	return out, nil
}

func (c *rssServiceClient) ListPage(ctx context.Context, in *Page, opts ...grpc.CallOption) (*ArrayShortNews, error) {
	out := new(ArrayShortNews)
	err := c.cc.Invoke(ctx, RssService_ListPage_FullMethodName, in, out, opts...)
	if err != nil {
		return nil, err
	}
	return out, nil
}

func (c *rssServiceClient) GetNews(ctx context.Context, in *Forlist, opts ...grpc.CallOption) (*ShortNew, error) {
	out := new(ShortNew)
	err := c.cc.Invoke(ctx, RssService_GetNews_FullMethodName, in, out, opts...)
	if err != nil {
		return nil, err
	}
	return out, nil
}

func (c *rssServiceClient) Search(ctx context.Context, in *Filter, opts ...grpc.CallOption) (*ArrayShortNews, error) {
	out := new(ArrayShortNews)
	err := c.cc.Invoke(ctx, RssService_Search_FullMethodName, in, out, opts...)
	if err != nil {
		return nil, err
	}
	return out, nil
}

// RssServiceServer is the server API for RssService service.
// All implementations must embed UnimplementedRssServiceServer
// for forward compatibility
type RssServiceServer interface {
	// add news
	AddNews(RssService_AddNewsServer) error
	// list news
	List(context.Context, *Forlist) (*ArrayShortNews, error)
	ListPage(context.Context, *Page) (*ArrayShortNews, error)
	GetNews(context.Context, *Forlist) (*ShortNew, error)
	Search(context.Context, *Filter) (*ArrayShortNews, error)
	mustEmbedUnimplementedRssServiceServer()
}

// UnimplementedRssServiceServer must be embedded to have forward compatible implementations.
type UnimplementedRssServiceServer struct {
}

func (UnimplementedRssServiceServer) AddNews(RssService_AddNewsServer) error {
	return status.Errorf(codes.Unimplemented, "method AddNews not implemented")
}
func (UnimplementedRssServiceServer) List(context.Context, *Forlist) (*ArrayShortNews, error) {
	return nil, status.Errorf(codes.Unimplemented, "method List not implemented")
}
func (UnimplementedRssServiceServer) ListPage(context.Context, *Page) (*ArrayShortNews, error) {
	return nil, status.Errorf(codes.Unimplemented, "method ListPage not implemented")
}
func (UnimplementedRssServiceServer) GetNews(context.Context, *Forlist) (*ShortNew, error) {
	return nil, status.Errorf(codes.Unimplemented, "method GetNews not implemented")
}
func (UnimplementedRssServiceServer) Search(context.Context, *Filter) (*ArrayShortNews, error) {
	return nil, status.Errorf(codes.Unimplemented, "method Search not implemented")
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

func _RssService_List_Handler(srv interface{}, ctx context.Context, dec func(interface{}) error, interceptor grpc.UnaryServerInterceptor) (interface{}, error) {
	in := new(Forlist)
	if err := dec(in); err != nil {
		return nil, err
	}
	if interceptor == nil {
		return srv.(RssServiceServer).List(ctx, in)
	}
	info := &grpc.UnaryServerInfo{
		Server:     srv,
		FullMethod: RssService_List_FullMethodName,
	}
	handler := func(ctx context.Context, req interface{}) (interface{}, error) {
		return srv.(RssServiceServer).List(ctx, req.(*Forlist))
	}
	return interceptor(ctx, in, info, handler)
}

func _RssService_ListPage_Handler(srv interface{}, ctx context.Context, dec func(interface{}) error, interceptor grpc.UnaryServerInterceptor) (interface{}, error) {
	in := new(Page)
	if err := dec(in); err != nil {
		return nil, err
	}
	if interceptor == nil {
		return srv.(RssServiceServer).ListPage(ctx, in)
	}
	info := &grpc.UnaryServerInfo{
		Server:     srv,
		FullMethod: RssService_ListPage_FullMethodName,
	}
	handler := func(ctx context.Context, req interface{}) (interface{}, error) {
		return srv.(RssServiceServer).ListPage(ctx, req.(*Page))
	}
	return interceptor(ctx, in, info, handler)
}

func _RssService_GetNews_Handler(srv interface{}, ctx context.Context, dec func(interface{}) error, interceptor grpc.UnaryServerInterceptor) (interface{}, error) {
	in := new(Forlist)
	if err := dec(in); err != nil {
		return nil, err
	}
	if interceptor == nil {
		return srv.(RssServiceServer).GetNews(ctx, in)
	}
	info := &grpc.UnaryServerInfo{
		Server:     srv,
		FullMethod: RssService_GetNews_FullMethodName,
	}
	handler := func(ctx context.Context, req interface{}) (interface{}, error) {
		return srv.(RssServiceServer).GetNews(ctx, req.(*Forlist))
	}
	return interceptor(ctx, in, info, handler)
}

func _RssService_Search_Handler(srv interface{}, ctx context.Context, dec func(interface{}) error, interceptor grpc.UnaryServerInterceptor) (interface{}, error) {
	in := new(Filter)
	if err := dec(in); err != nil {
		return nil, err
	}
	if interceptor == nil {
		return srv.(RssServiceServer).Search(ctx, in)
	}
	info := &grpc.UnaryServerInfo{
		Server:     srv,
		FullMethod: RssService_Search_FullMethodName,
	}
	handler := func(ctx context.Context, req interface{}) (interface{}, error) {
		return srv.(RssServiceServer).Search(ctx, req.(*Filter))
	}
	return interceptor(ctx, in, info, handler)
}

// RssService_ServiceDesc is the grpc.ServiceDesc for RssService service.
// It's only intended for direct use with grpc.RegisterService,
// and not to be introspected or modified (even as a copy)
var RssService_ServiceDesc = grpc.ServiceDesc{
	ServiceName: "rpc_news.RssService",
	HandlerType: (*RssServiceServer)(nil),
	Methods: []grpc.MethodDesc{
		{
			MethodName: "List",
			Handler:    _RssService_List_Handler,
		},
		{
			MethodName: "ListPage",
			Handler:    _RssService_ListPage_Handler,
		},
		{
			MethodName: "GetNews",
			Handler:    _RssService_GetNews_Handler,
		},
		{
			MethodName: "Search",
			Handler:    _RssService_Search_Handler,
		},
	},
	Streams: []grpc.StreamDesc{
		{
			StreamName:    "AddNews",
			Handler:       _RssService_AddNews_Handler,
			ClientStreams: true,
		},
	},
	Metadata: "apigetway.proto",
}

const (
	CommentService_AddComment_FullMethodName  = "/rpc_news.CommentService/AddComment"
	CommentService_DelComment_FullMethodName  = "/rpc_news.CommentService/DelComment"
	CommentService_TreeComment_FullMethodName = "/rpc_news.CommentService/TreeComment"
)

// CommentServiceClient is the client API for CommentService service.
//
// For semantics around ctx use and closing/ending streaming RPCs, please refer to https://pkg.go.dev/google.golang.org/grpc/?tab=doc#ClientConn.NewStream.
type CommentServiceClient interface {
	// add comment
	AddComment(ctx context.Context, in *Comment, opts ...grpc.CallOption) (*Result, error)
	DelComment(ctx context.Context, in *Forlist, opts ...grpc.CallOption) (*Result, error)
	// return tree comment for id news
	TreeComment(ctx context.Context, in *Forlist, opts ...grpc.CallOption) (*TreeComments, error)
}

type commentServiceClient struct {
	cc grpc.ClientConnInterface
}

func NewCommentServiceClient(cc grpc.ClientConnInterface) CommentServiceClient {
	return &commentServiceClient{cc}
}

func (c *commentServiceClient) AddComment(ctx context.Context, in *Comment, opts ...grpc.CallOption) (*Result, error) {
	out := new(Result)
	err := c.cc.Invoke(ctx, CommentService_AddComment_FullMethodName, in, out, opts...)
	if err != nil {
		return nil, err
	}
	return out, nil
}

func (c *commentServiceClient) DelComment(ctx context.Context, in *Forlist, opts ...grpc.CallOption) (*Result, error) {
	out := new(Result)
	err := c.cc.Invoke(ctx, CommentService_DelComment_FullMethodName, in, out, opts...)
	if err != nil {
		return nil, err
	}
	return out, nil
}

func (c *commentServiceClient) TreeComment(ctx context.Context, in *Forlist, opts ...grpc.CallOption) (*TreeComments, error) {
	out := new(TreeComments)
	err := c.cc.Invoke(ctx, CommentService_TreeComment_FullMethodName, in, out, opts...)
	if err != nil {
		return nil, err
	}
	return out, nil
}

// CommentServiceServer is the server API for CommentService service.
// All implementations must embed UnimplementedCommentServiceServer
// for forward compatibility
type CommentServiceServer interface {
	// add comment
	AddComment(context.Context, *Comment) (*Result, error)
	DelComment(context.Context, *Forlist) (*Result, error)
	// return tree comment for id news
	TreeComment(context.Context, *Forlist) (*TreeComments, error)
	mustEmbedUnimplementedCommentServiceServer()
}

// UnimplementedCommentServiceServer must be embedded to have forward compatible implementations.
type UnimplementedCommentServiceServer struct {
}

func (UnimplementedCommentServiceServer) AddComment(context.Context, *Comment) (*Result, error) {
	return nil, status.Errorf(codes.Unimplemented, "method AddComment not implemented")
}
func (UnimplementedCommentServiceServer) DelComment(context.Context, *Forlist) (*Result, error) {
	return nil, status.Errorf(codes.Unimplemented, "method DelComment not implemented")
}
func (UnimplementedCommentServiceServer) TreeComment(context.Context, *Forlist) (*TreeComments, error) {
	return nil, status.Errorf(codes.Unimplemented, "method TreeComment not implemented")
}
func (UnimplementedCommentServiceServer) mustEmbedUnimplementedCommentServiceServer() {}

// UnsafeCommentServiceServer may be embedded to opt out of forward compatibility for this service.
// Use of this interface is not recommended, as added methods to CommentServiceServer will
// result in compilation errors.
type UnsafeCommentServiceServer interface {
	mustEmbedUnimplementedCommentServiceServer()
}

func RegisterCommentServiceServer(s grpc.ServiceRegistrar, srv CommentServiceServer) {
	s.RegisterService(&CommentService_ServiceDesc, srv)
}

func _CommentService_AddComment_Handler(srv interface{}, ctx context.Context, dec func(interface{}) error, interceptor grpc.UnaryServerInterceptor) (interface{}, error) {
	in := new(Comment)
	if err := dec(in); err != nil {
		return nil, err
	}
	if interceptor == nil {
		return srv.(CommentServiceServer).AddComment(ctx, in)
	}
	info := &grpc.UnaryServerInfo{
		Server:     srv,
		FullMethod: CommentService_AddComment_FullMethodName,
	}
	handler := func(ctx context.Context, req interface{}) (interface{}, error) {
		return srv.(CommentServiceServer).AddComment(ctx, req.(*Comment))
	}
	return interceptor(ctx, in, info, handler)
}

func _CommentService_DelComment_Handler(srv interface{}, ctx context.Context, dec func(interface{}) error, interceptor grpc.UnaryServerInterceptor) (interface{}, error) {
	in := new(Forlist)
	if err := dec(in); err != nil {
		return nil, err
	}
	if interceptor == nil {
		return srv.(CommentServiceServer).DelComment(ctx, in)
	}
	info := &grpc.UnaryServerInfo{
		Server:     srv,
		FullMethod: CommentService_DelComment_FullMethodName,
	}
	handler := func(ctx context.Context, req interface{}) (interface{}, error) {
		return srv.(CommentServiceServer).DelComment(ctx, req.(*Forlist))
	}
	return interceptor(ctx, in, info, handler)
}

func _CommentService_TreeComment_Handler(srv interface{}, ctx context.Context, dec func(interface{}) error, interceptor grpc.UnaryServerInterceptor) (interface{}, error) {
	in := new(Forlist)
	if err := dec(in); err != nil {
		return nil, err
	}
	if interceptor == nil {
		return srv.(CommentServiceServer).TreeComment(ctx, in)
	}
	info := &grpc.UnaryServerInfo{
		Server:     srv,
		FullMethod: CommentService_TreeComment_FullMethodName,
	}
	handler := func(ctx context.Context, req interface{}) (interface{}, error) {
		return srv.(CommentServiceServer).TreeComment(ctx, req.(*Forlist))
	}
	return interceptor(ctx, in, info, handler)
}

// CommentService_ServiceDesc is the grpc.ServiceDesc for CommentService service.
// It's only intended for direct use with grpc.RegisterService,
// and not to be introspected or modified (even as a copy)
var CommentService_ServiceDesc = grpc.ServiceDesc{
	ServiceName: "rpc_news.CommentService",
	HandlerType: (*CommentServiceServer)(nil),
	Methods: []grpc.MethodDesc{
		{
			MethodName: "AddComment",
			Handler:    _CommentService_AddComment_Handler,
		},
		{
			MethodName: "DelComment",
			Handler:    _CommentService_DelComment_Handler,
		},
		{
			MethodName: "TreeComment",
			Handler:    _CommentService_TreeComment_Handler,
		},
	},
	Streams:  []grpc.StreamDesc{},
	Metadata: "apigetway.proto",
}
