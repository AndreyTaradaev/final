// API приложения Gateway
package api

import (
	//"encoding/json"
	"net/http"
	//"strconv"	
	//"gateway/apigw/pkg/model"
	"github.com/gorilla/mux"
	logs "gateway/internal/log"
)

type API struct {	
	r  *mux.Router
}

// Конструктор API.
func New() *API {
	a := API{r: mux.NewRouter()}
	a.endpoints()
	logger := logs.New()
	logger.Debug("Init router http")
	return &a
}

// Router возвращает маршрутизатор для использования
// в качестве аргумента HTTP-сервера.
func (api *API) Router() *mux.Router {
	return api.r
}

// Регистрация методов API в маршрутизаторе запросов.
func (api *API) endpoints() {
	api.r.Use(api.headersMiddleware)
	// получить список новостей (сокращенно)
	api.r.HandleFunc("/news", api.news).Methods(http.MethodGet, http.MethodOptions)
	// получить список  новостей  со страницы (сокращенно)
	api.r.HandleFunc("/news/page={id:[0-9]+}", api.news).Methods(http.MethodGet, http.MethodOptions)
	// получить полную новость (c коментариями)
	api.r.HandleFunc("/news/{id:[0-9]+}", api.news).Methods(http.MethodGet, http.MethodOptions)
// добавить комментарий
api.r.HandleFunc("/comment/{id:[0-9]+}", api.news).Methods(http.MethodPost, http.MethodOptions)
// получить комментарий
api.r.HandleFunc("/comment/{id:[0-9]+}", api.news).Methods(http.MethodGet, http.MethodOptions)
// удалить комментарий
api.r.HandleFunc("/comment/{id:[0-9]+}", api.news).Methods(http.MethodDelete, http.MethodOptions)

	

	//api.r.PathPrefix("/").Handler(http.StripPrefix("/", http.FileServer(http.Dir("./webapp"))))
}

func (api *API) news(w http.ResponseWriter, r *http.Request) {	
	if r.Method == http.MethodOptions {
		return
	}
	s := mux.Vars(r)["n"]
//	n, _ := strconv.Atoi(s)
	//news, err := api.db.GetNews(n)
	/* if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	} */
	logs.New().Debug("Headres:", r.Header)
	logs.New().Debug("Vars from request: ", mux.Vars(r))
	
	w.Write( []byte("checked " + s) )
	//json.NewEncoder(w).Encode(news)
}

// headersMiddleware устанавливает заголовки ответа сервера.
func (api *API) headersMiddleware(next http.Handler) http.Handler {
    return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
        w.Header().Set("Content-Type", "application/json")
		w.Header().Set("Access-Control-Allow-Origin", "*")
        next.ServeHTTP(w, r)
    })
}
