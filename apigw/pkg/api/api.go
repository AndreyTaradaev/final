// маршрутизатор для http сервера API приложения Gateway
package api

import (
	"bytes"
	"encoding/json"
	"fmt"
	md "gateway/apigw/pkg/api/midleware"
	"gateway/apigw/pkg/rpc"
	"gateway/apigw/pkg/rpc/service"
	logs "gateway/internal/log"
	pb "gateway/internal/model"
	"gateway/internal/tools"
	"io"
	"net/http"
	"strconv"
	"sync"

	"github.com/gorilla/mux"
)

type API struct {
	r             *mux.Router
	newsClient    rpc.NewsClient
	commentClient rpc.CommentClient
	censorServer  string
}

const timeout int = 120

// Конструктор API.
func New(newstr, commentstr, censorstr string) (*API, error) {
	logger := logs.New()
	newsclient, err := service.Connect(newstr, timeout)
	if err != nil {
		return nil, err
	}

	commentclient, err := service.Connect(commentstr, timeout)
	if err != nil {
		newsclient.Close()
		return nil, err
	}

	a := API{r: mux.NewRouter(), newsClient: newsclient, commentClient: commentclient, censorServer: "http://" + censorstr + "/comment"}
	a.endpoints()

	logger.Debug("Init router http  ", a.censorServer)
	return &a, nil
}

// Router возвращает маршрутизатор для использования
// в качестве аргумента HTTP-сервера.
func (api *API) Router() *mux.Router {
	return api.r
}

// Регистрация методов API в маршрутизаторе запросов.
func (api *API) endpoints() {
	api.r.Use(api.headersMiddleware)
	api.r.Use(md.WrapHandlerWithLogging)
	api.r.HandleFunc("/news/page={id:[0-9]+}", api.page).Methods(http.MethodGet, http.MethodOptions) // получить список  новостей  со страницы (сокращенно)
	api.r.HandleFunc("/news/{id:[0-9]+}", api.news).Methods(http.MethodGet, http.MethodOptions)      //вернуть список последних новостей  для веб-интефейса
	api.r.HandleFunc("/news/search", api.search).Methods(http.MethodGet, http.MethodOptions)         //вернуть список  новостей  по фильтру
	// получить полную новость (c коментариями)
	api.r.HandleFunc("/news/detail={id:[0-9]+}", api.detail).Methods(http.MethodGet, http.MethodOptions) ///детальная новость

	api.r.HandleFunc("/news/list", api.list).Methods(http.MethodGet, http.MethodOptions) //весь список (последнюю 1000)

	// добавить комментарий
	api.r.HandleFunc("/comment/{id:[0-9]+}", api.addcomment).Methods(http.MethodPost, http.MethodOptions)
	// получить комментарий
	api.r.HandleFunc("/comment/{id:[0-9]+}", api.getcomments).Methods(http.MethodGet, http.MethodOptions)
	api.r.HandleFunc("/comment/{id:[0-9]+}", api.delcomment).Methods(http.MethodDelete, http.MethodOptions)
	api.r.PathPrefix("/").Handler(http.StripPrefix("/", http.FileServer(http.Dir("./webapp"))))

}

func (api *API) delcomment(w http.ResponseWriter, r *http.Request) {
	if r.Method == http.MethodOptions {
		return
	}
	idcomment := mux.Vars(r)["id"]
	id, err := strconv.ParseInt(idcomment, 10, 64)
	if err != nil {
		http.Error(w, " comment = "+idcomment+"\n"+err.Error(), http.StatusInternalServerError)
		return
	}
	ret, err := api.commentClient.DelComment(id)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}
	w.Header().Set("result", fmt.Sprintf("%t", ret))
	w.Header().Set("Endpoint", "delcomments")
}

func (api *API) getcomments(w http.ResponseWriter, r *http.Request) {
	if r.Method == http.MethodOptions {
		return
	}
	idcomment := mux.Vars(r)["id"]
	id, err := strconv.ParseInt(idcomment, 10, 64)
	if err != nil {
		http.Error(w, "news = "+idcomment+"\n"+err.Error(), http.StatusInternalServerError)
		return
	}
	ret, err := api.commentClient.Comments(id)
	jsn, err := json.Marshal(ret)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}
	w.Header().Set("id", idcomment)
	w.Header().Set("Endpoint", "getcomments")
	w.Write(jsn)
}

func (api *API) addcomment(w http.ResponseWriter, r *http.Request) {
	if r.Method == http.MethodOptions {
		return
	}

	b, err := io.ReadAll(r.Body)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}
	r.Body.Close()
	Checkbuffer := io.NopCloser(bytes.NewBuffer(b))
	reqID := r.URL.Query().Get("request_id")
	if len(reqID) == 0 {
		reqID = w.Header().Get("Request-ID")
		r.URL.Query().Add("request_id", reqID)
	}

	resp, err := api.makeRequest(r, http.MethodGet, api.censorServer, Checkbuffer)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}
	logs.New().Debugf("service check Comment  status code %d ", resp.StatusCode )	
	switch resp.StatusCode {
	case http.StatusInternalServerError:
		http.Error(w, "Внутренняя ошибка сервиса проверки комментариев", resp.StatusCode)
		return
	case http.StatusForbidden:
		http.Error(w, "Действие запрещено, в комментарии содержатся запрещенные слова ", resp.StatusCode)
		return
	case http.StatusOK:
		break
	default:
		http.Error(w, "Действие запрещено, в комментарии содержатся запрещенные слова ", resp.StatusCode)
		return
	}
	var strucBody pb.Comment

	err = json.Unmarshal(b, &strucBody)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}
	id, err := api.commentClient.AddComment(&strucBody)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}
	w.Header().Set("id", fmt.Sprintf("%d", id))
	w.Write([]byte("ok"))
	w.Header().Set("Endpoint", "addcomment")
}

func (api *API) search(w http.ResponseWriter, r *http.Request) {
	if r.Method == http.MethodOptions {
		return
	}
	//sort=date&direction=desc&count=10&offset=0
	word := r.URL.Query().Get("word") //слово поиска
	typesearch := r.URL.Query().Get("type")
	sort := r.URL.Query().Get("sort")
	direction := r.URL.Query().Get("direction")
	startdate := r.URL.Query().Get("startdate")
	enddate := r.URL.Query().Get("enddate")
	filter := pb.CreateFilter(word, typesearch, sort, direction, startdate, enddate)
	logs.New().Debugf("argument %s,%s,%s,%s,%s,%s ", word, typesearch, sort, direction, startdate, enddate)
	arrayNews, err := api.newsClient.SearchNews(filter)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}
	ret, err := json.Marshal(arrayNews)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}
	w.Header().Set("Endpoint", "search")
	w.Header().Set("count", fmt.Sprintf("%d", len(arrayNews.GetArray())))
	w.Write(ret)
}

// обработчик получить список  новостей  со страницы (сокращенно)
func (api *API) page(w http.ResponseWriter, r *http.Request) {
	if r.Method == http.MethodOptions {
		return
	}
	//logger := logs.New()
	pageStr := mux.Vars(r)["id"]
	countStr := r.URL.Query().Get("count")
	page := tools.GetIntDef(pageStr, 1)
	count := tools.GetIntDef(countStr, 20)
	arrayNews, err := api.newsClient.ListPageNews(page, count)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}
	ret, err := json.Marshal(arrayNews)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}
	w.Header().Set("Page", pageStr)
	w.Header().Set("limit", fmt.Sprintf("%d", count))
	w.Header().Set("CountMews", fmt.Sprintf("%d", len(arrayNews.GetArray())))
	w.Header().Set("Endpoint", "page")
	w.Write(ret)
}

// обработчик  вернуть список последних новостей  для веб-интефейса
func (api *API) news(w http.ResponseWriter, r *http.Request) {
	if r.Method == http.MethodOptions {
		return
	}
	pageStr := mux.Vars(r)["id"]
	P := tools.GetIntDef(pageStr, 10)
	arrayNews, err := api.newsClient.ListNews(P)

	ret, err := json.Marshal(arrayNews.GetArray())
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}
	w.Header().Set("Endpoint", "news")
	w.Header().Set("count ", pageStr)
	w.Write(ret)
}

// обработчик весь список (последнюю 1000)
func (api *API) list(w http.ResponseWriter, r *http.Request) {
	if r.Method == http.MethodOptions {
		return
	}
	arrayNews, err := api.newsClient.ListNews(1000) // последнюю 1000 новостей
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}
	ret, err := json.Marshal(arrayNews)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}
	w.Header().Set("Endpoint", "list")
	w.Write(ret)
}

func (a *API) getnews(id int64, channel chan<- interface{}) {
	news, err := a.newsClient.DetailNews(id)
	if err != nil {
		channel <- err
		return
	}
	channel <- news
}

func (a *API) getComment(id int64, channel chan<- interface{}) {

	ret, err := a.commentClient.Comments(id)
	if err != nil {
		channel <- err
		return
	}
	channel <- ret
}
func receive(channel <-chan interface{}) (*pb.FullNew, error) {

	ret := pb.FullNew{}
	for a := range channel {
		switch r := a.(type) {
		case error:
			return nil, r
		case *pb.ShortNew:
			ret.News = r
		case map[int64]*pb.Comment:
			ret.Commments = r
		}
	}
	return &ret, nil
}

func (a *API) formFullNews(id int64) (*pb.FullNew, error) {
	channel := make(chan interface{}, 2)

	var wg sync.WaitGroup
	wg.Add(2)
	go func() {
		a.getnews(id, channel)
		wg.Done()
	}()

	go func() {
		a.getComment(id, channel)
		wg.Done()
	}()
	wg.Wait()
	close(channel)
	return receive(channel)
}

// обработчик  детальная новость
func (api *API) detail(w http.ResponseWriter, r *http.Request) {
	if r.Method == http.MethodOptions {
		return
	}
	idstr := mux.Vars(r)["id"]
	id, err := strconv.ParseInt(idstr, 10, 64)
	if err != nil {
		http.Error(w, "id = "+idstr+"\n"+err.Error(), http.StatusInternalServerError)
		return
	}
	fullnews, err := api.formFullNews(id)
	if err != nil {
		http.Error(w, "id news have next error: \n"+err.Error(), http.StatusInternalServerError)
		return
	}
	ret, err := json.Marshal(fullnews)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}
	w.Header().Set("news_id ", idstr)
	w.Header().Set("Endpoint", "ful_news")
	w.Write(ret)
}

// headersMiddleware устанавливает заголовки ответа сервера.
func (api *API) headersMiddleware(next http.Handler) http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {

		if r.URL.String() == "/" {
			w.Header().Set("Content-Type", "text/html; charset=utf-8")
		} else {
			w.Header().Set("Content-Type", "application/json; charset=utf-8")
		}
		w.Header().Set("Access-Control-Allow-Origin", "*")
		logs.New().Debug(r.Header)
		logs.New().Debug(r.URL)
		next.ServeHTTP(w, r)

	})
}

// Проверка  коментариев
func (api *API) makeRequest(req *http.Request, method, url string, body io.ReadCloser) (*http.Response, error) {
	client := &http.Client{}
	r, err := http.NewRequest(method, url, body)
	if err != nil {
		return nil, err
	}
	r.Header = req.Header
	return client.Do(r)
}
