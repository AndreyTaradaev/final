// API приложения Gateway
package api

import (
	"encoding/json"
	"fmt"
	"gateway/apigw/pkg/rpcclient"
	logs "gateway/internal/log"
	"net/http"
	"strconv"

	"github.com/gorilla/mux"
)

type API struct {
	r       *mux.Router
	nClient *rpcclient.RPClient
	cClient *rpcclient.RPClient
}

const timeout int = 120

// Конструктор API.
func New(newsTarget, comenttarget string) (*API, error) {
	logger := logs.New()
	newsclient, err := rpcclient.Connect(newsTarget, timeout)
	if err != nil {
		return nil, err
	}

	a := API{r: mux.NewRouter(), nClient: newsclient}
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

	// получить список новостей (сокращенно)
	api.r.HandleFunc("/news/page={id:[0-9]+}", api.page).Methods(http.MethodGet, http.MethodOptions)   // получить список  новостей  со страницы (сокращенно)
	api.r.HandleFunc("/news/{id:[0-9]+}", api.news).Methods(http.MethodGet, http.MethodOptions)        //вернуть список последних новостей  для веб-интефейса
	api.r.HandleFunc("/news/filter?", api.news).Methods(http.MethodGet, http.MethodOptions)            //вернуть список  новостей  по фильтру
	api.r.HandleFunc("/news?detail={id:[0-9]+}", api.news).Methods(http.MethodGet, http.MethodOptions) ///детальная новость
	// получить полную новость (c коментариями)
	api.r.HandleFunc("/news/list", api.list).Methods(http.MethodGet, http.MethodOptions)

	// добавить комментарий
	api.r.HandleFunc("/comment/{id:[0-9]+}", api.news).Methods(http.MethodPost, http.MethodOptions)
	// получить комментарий
	api.r.HandleFunc("/comment/{id:[0-9]+}", api.news).Methods(http.MethodGet, http.MethodOptions)
	// удалить комментарий
	api.r.HandleFunc("/comment/{id:[0-9]+}", api.news).Methods(http.MethodDelete, http.MethodOptions)
	api.r.PathPrefix("/").Handler(http.StripPrefix("/", http.FileServer(http.Dir("./webapp"))))
	api.r.Use(api.headersMiddleware)

}

// получить список  новостей  со страницы (сокращенно)
func (api *API) page(w http.ResponseWriter, r *http.Request) {
	if r.Method == http.MethodOptions {
		return
	}
	//logger := logs.New()
	pageStr := mux.Vars(r)["id"]
	countStr := r.URL.Query().Get("count")
	page, err := strconv.Atoi(pageStr)
	if err != nil {
		http.Error(w, "page = "+pageStr+"\n"+err.Error(), http.StatusInternalServerError)
		return
	}
	count, err := strconv.Atoi(countStr)
	if err != nil {
		count = 20
	}
	arrayNews, err := api.nClient.RunRssServiceListPage(uint32(page), uint32(count))
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}
	ret, err := json.Marshal(arrayNews.Get())
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}
	w.Header().Set("Content-Length", fmt.Sprintf("%d", len(ret)))
	w.Header().Set("Page", pageStr)
	w.Header().Set("limit", fmt.Sprintf("%d", count))
	w.Header().Set("Endpoint", "page")
	w.Write(ret)
	return

}
func (api *API) list(w http.ResponseWriter, r *http.Request) {}

func (api *API) news(w http.ResponseWriter, r *http.Request) {
	if r.Method == http.MethodOptions {
		return
	}
	pageStr := mux.Vars(r)["id"]
	P, err := strconv.ParseUint(pageStr,10,64)	
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}
	arrayNews, err := api.nClient.RunRssServiceList(P)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}
	ret, err := json.Marshal(arrayNews.Get())
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}
	w.Header().Set("Content-Length", fmt.Sprintf("%d", len(ret)))
	w.Header().Set("Endpoint", "news")
	w.Header().Set("count ", pageStr)
	w.Write(ret)
}

// Получаем весь список новостей (сокращенно)

/* // обработка запросов новостей
func (api *API) newspage(w http.ResponseWriter, r *http.Request) {
	logger := logs.New()
	if r.Method == http.MethodOptions {
		return
	}

	strid, ok := mux.Vars(r)["id"]
	if !ok {
		logger.Error("Parametr Number page not found: " + strid)
		http.Error(w, "Number page not found: "+strid, http.StatusInternalServerError)
		return
	}

	id, err := strconv.Atoi(strid)

	if err != nil {
		logger.Error(err, strid)
		http.Error(w, err.Error()+": "+strid, http.StatusInternalServerError)
		return
	}

	logger.Debug("init RPC client")
	dial, err := service.Init(api.newsServer)
	if err != nil {
		logger.Error("error init RPC client ", err)
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}
	arrayNews, err := dial.RunRssServicePage(id)
	if err != nil {
		logger.Error("error from connect  RPC server ", err)
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}
	ret, _ := json.Marshal(arrayNews.Get())
	w.Header().Set("Content-Length", fmt.Sprintf("%d", len(ret)))
	w.Write(ret)
} */

// headersMiddleware устанавливает заголовки ответа сервера.
func (api *API) headersMiddleware(next http.Handler) http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		w.Header().Set("Content-Type", "application/json")
		w.Header().Set("Access-Control-Allow-Origin", "*")
		logs.New().Debug(r.Header)
		logs.New().Debug(r.URL)
		next.ServeHTTP(w, r)
	})
}
