// API приложения Gateway
package api

import (
	"encoding/json"
	"fmt"
	"gateway/apigw/pkg/rpcclient"
	logs "gateway/internal/log"
	"gateway/internal/model"
	"io"
	"net/http"
	"strconv"

	pb "gateway/internal/rpc"
	"sync"

	"github.com/gorilla/mux"
)

type API struct {
	r       *mux.Router
	nClient model.NewsClient
	cClient model.CommentClient
}

const timeout int = 120

// Конструктор API.
func New(newstr, commentstr string) (*API, error) {
	logger := logs.New()
	newsclient, err := rpcclient.Connect(newstr, timeout)
	if err != nil {
		return nil, err
	}

	commentclient, err := rpcclient.Connect(commentstr, timeout)
	if err != nil {
		newsclient.Close()
		return nil, err
	}

	a := API{r: mux.NewRouter(), nClient: newsclient, cClient: commentclient}
	a.endpoints()
	logger.Debug("Init router http")
	return &a, nil
}

// Router возвращает маршрутизатор для использования
// в качестве аргумента HTTP-сервера.
func (api *API) Router() *mux.Router {
	return api.r
}

// Регистрация методов API в маршрутизаторе запросов.
func (api *API) endpoints() {
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
	api.r.Use(api.headersMiddleware)
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
	ret, err := api.cClient.DelComment(id)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}

	//w.Header().Set("Content-Length", fmt.Sprintf("%d", len(jsn)))

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
		http.Error(w, "number news = "+idcomment+"\n"+err.Error(), http.StatusInternalServerError)
		return
	}
	ret, err := api.cClient.Comments(id)
	jsn, err := json.Marshal(ret)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}
	w.Header().Set("Content-Length", fmt.Sprintf("%d", len(jsn)))

	w.Header().Set("id", idcomment)
	w.Header().Set("Endpoint", "getcomments")
	w.Write(jsn)
}

func (api *API) addcomment(w http.ResponseWriter, r *http.Request) {
	if r.Method == http.MethodOptions {
		return
	}
	defer r.Body.Close()

	b, err := io.ReadAll(r.Body)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}
	var strucBody model.Comment //

	err = json.Unmarshal(b, &strucBody)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}
	id, err := api.cClient.AddComment(&strucBody)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
	}
	w.Header().Set("id", fmt.Sprintf("%d", id))
	w.Write([]byte("ok"))
	w.Header().Set("Endpoint", "addcomment")
	//w.WriteHeader(http.StatusOK)
}

func (api *API) search(w http.ResponseWriter, r *http.Request) {
	if r.Method == http.MethodOptions {
		return
	}
	//sort=date&direction=desc&count=10&offset=0
	word := r.URL.Query().Get("word")
	typesearch := r.URL.Query().Get("type")
	sort := r.URL.Query().Get("sort")
	direction := r.URL.Query().Get("direction")
	startdate := r.URL.Query().Get("startdate")
	enddate := r.URL.Query().Get("enddate")
	logs.New().Debugf(`Parametr search: word "%s", type "%s", field "%s",direction "%s",startdate "%s", enddate "%s"`, word, typesearch, sort, direction, startdate, enddate)

	arrayNews, err := api.nClient.SearchNews(word, typesearch, sort, direction, startdate, enddate)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}
	ret, err := json.Marshal(arrayNews)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}
	w.Header().Set("Content-Length", fmt.Sprintf("%d", len(ret)))
	w.Header().Set("Endpoint", "search")
	w.Header().Set("count", fmt.Sprintf("%d", len(arrayNews)))
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
	page, err := strconv.ParseUint(pageStr, 10, 64)
	if err != nil {
		http.Error(w, "page = "+pageStr+"\n"+err.Error(), http.StatusInternalServerError)
		return
	}
	count := model.GetIntDef(countStr, 20)

	arrayNews, err := api.nClient.ListPageNews(uint32(page), uint32(count))
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}
	ret, err := json.Marshal(arrayNews)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}
	w.Header().Set("Content-Length", fmt.Sprintf("%d", len(ret)))
	w.Header().Set("Page", pageStr)
	w.Header().Set("limit", fmt.Sprintf("%d", count))
	w.Header().Set("Count", fmt.Sprintf("%d", len(arrayNews)))
	w.Header().Set("Endpoint", "page")
	w.Write(ret)
}

// обработчик  вернуть список последних новостей  для веб-интефейса
func (api *API) news(w http.ResponseWriter, r *http.Request) {
	if r.Method == http.MethodOptions {
		return
	}
	pageStr := mux.Vars(r)["id"]
	P, err := strconv.ParseUint(pageStr, 10, 64)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}
	arrayNews, err := api.nClient.ListNews(P)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}
	ret, err := json.Marshal(arrayNews)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}
	w.Header().Set("Content-Length", fmt.Sprintf("%d", len(ret)))
	w.Header().Set("Endpoint", "news")
	w.Header().Set("count ", pageStr)
	w.Write(ret)
}

// обработчик весь список (последнюю 1000)
func (api *API) list(w http.ResponseWriter, r *http.Request) {
	if r.Method == http.MethodOptions {
		return
	}
	arrayNews, err := api.nClient.ListNews(1000) // последнюю 1000 новостей
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}
	ret, err := json.Marshal(arrayNews)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}
	w.Header().Set("Content-Length", fmt.Sprintf("%d", len(ret)))
	w.Header().Set("Endpoint", "list")
	w.Write(ret)
}

// обработчик  детальная новость
func (api *API) detail(w http.ResponseWriter, r *http.Request) {
	if r.Method == http.MethodOptions {
		return
	}
	idstr := mux.Vars(r)["id"]
	id, err := strconv.ParseUint(idstr, 10, 64)
	if err != nil {
		http.Error(w, "id = "+idstr+"\n"+err.Error(), http.StatusInternalServerError)
		return
	}

	var wg sync.WaitGroup
	wg.Add(2)
	var fnews *pb.FullNew = new(pb.FullNew)

	//var comments pb.
	func() {
		go func() {
			news, err := api.nClient.DetailNews(id)
			if err != nil {
				wg.Done()
				return
			}
			fnews.News = news
			wg.Done()
		}()
		go func() {
			ret, err := api.cClient.Comments(int64(id))
			if err != nil {
				wg.Done()
				return
			}
			fnews.Commments = ret
			wg.Done()
		}()
	}()
	wg.Wait()
	if err != nil {
		http.Error(w, "\n"+err.Error(), http.StatusInternalServerError)
		return
	}
	ret, err := json.Marshal(fnews)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}
	w.Header().Set("Content-Length", fmt.Sprintf("%d", len(ret)))
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
