// API приложения Gateway
package api

import (
	"encoding/json"
	"fmt"
	"net/http"
	"strconv"

	"gateway/apigw/pkg/service"
	logs "gateway/internal/log"
	"gateway/internal/model"

	"github.com/gorilla/mux"
)

type API struct {
	r *mux.Router
	//newsserv  *service.Dial
	newsServer    string
	commentServer string
}

// Конструктор API.
func New(newsTarget, comenttarget string) (*API, error) {
	logger := logs.New()

	a := API{r: mux.NewRouter(), newsServer: newsTarget, commentServer: comenttarget}
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
	api.r.HandleFunc("/news", api.news).Methods(http.MethodGet, http.MethodOptions)
	// получить список  новостей  со страницы (сокращенно)
	api.r.HandleFunc("/news?page={id:[0-9]+}", api.newspage).Methods(http.MethodGet, http.MethodOptions)
	// получить полную новость (c коментариями)
	api.r.HandleFunc("/news?{id:[0-9]+}", api.news).Methods(http.MethodGet, http.MethodOptions)
	// добавить комментарий
	api.r.HandleFunc("/comment/{id:[0-9]+}", api.news).Methods(http.MethodPost, http.MethodOptions)
	// получить комментарий
	api.r.HandleFunc("/comment/{id:[0-9]+}", api.news).Methods(http.MethodGet, http.MethodOptions)
	// удалить комментарий
	api.r.HandleFunc("/comment/{id:[0-9]+}", api.news).Methods(http.MethodDelete, http.MethodOptions)

	api.r.Use(api.headersMiddleware)
	api.r.PathPrefix("/").Handler(http.StripPrefix("/", http.FileServer(http.Dir("./webapp"))))


	//api.r.PathPrefix("/").Handler(http.StripPrefix("/", http.FileServer(http.Dir("./webapp"))))
}

// Получаем весь список новостей (сокращенно)
func (api *API) news(w http.ResponseWriter, r *http.Request) {
	logger := logs.New()
	if r.Method == http.MethodOptions {
		return
	}
	logger.Debug("init RPC client")
	dial, err := service.Init(api.newsServer)
	if err != nil {
		logger.Error("error init RPC client ", err)
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}
	var arrayNews model.ShortNews
	pageParam := r.URL.Query().Get("page")
	if len(pageParam) == 0 {
		arrayNews, err = dial.RunRssServiceList()
	} else {
		page, err := strconv.Atoi(pageParam)
		if err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
			return
		}
		arrayNews, err = dial.RunRssServicePage(page)
	}
	if err != nil {
		logger.Error("error cal rpc func  from RPC server ", err)
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}
	ret, _ := json.Marshal(arrayNews.Get())
	w.Header().Set("Content-Length", fmt.Sprintf("%d", len(ret)))
	w.Write(ret)
}

// обработка запросов новостей
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
}

// headersMiddleware устанавливает заголовки ответа сервера.
func (api *API) headersMiddleware(next http.Handler) http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		w.Header().Set("Content-Type", "application/json")
		w.Header().Set("Access-Control-Allow-Origin", "*")
		next.ServeHTTP(w, r)
	})
}
