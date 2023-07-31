// маршрутизатор для http сервера API приложения Gateway
package api

import (
	"encoding/json"
	"fmt"
	"gateway/censor/pkg/storage"
	db "gateway/censor/pkg/storage/postgres"
	logs "gateway/internal/log"
	pb "gateway/internal/model"
	"io"
	"net/http"
	"time"

	"github.com/google/uuid"
	"github.com/gorilla/mux"
)

type API struct {
	r  *mux.Router
	db storage.DBInterface
}

const timeout int = 120

// Конструктор API.
func New() (*API, error) {
	logger := logs.New()
	d, err := db.New()
	if err != nil {
		return nil, err
	}

	a := API{r: mux.NewRouter(), db: d}
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
	api.r.Use(api.headersMiddleware)
	api.r.HandleFunc("/comment", api.checkComment).Methods(http.MethodGet, http.MethodOptions)
	api.r.HandleFunc("/word/{w}", api.addWord).Methods(http.MethodPost, http.MethodOptions)
}

// проверка комментария на запрещенные слова если  находим то возвращаем статускод 404 если нет по 200
func (api *API) addWord(w http.ResponseWriter, r *http.Request) {
	if r.Method == http.MethodOptions {
		return
	}
	word := mux.Vars(r)["w"]
	if len(word) == 0 {
		http.Error(w, "word is emply!", http.StatusForbidden)
		return
	}
	err := api.db.AddWord(word)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}
	w.Write([]byte("ok"))
}

// проверка комментария на запрещенные слова если  находим то возвращаем статускод 404 если нет по 200
func (api *API) checkComment(w http.ResponseWriter, r *http.Request) {
	if r.Method == http.MethodOptions {
		return
	}
	b, err := io.ReadAll(r.Body)
	r.Body.Close()
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}
	var strucBody pb.Comment

	err = json.Unmarshal(b, &strucBody)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}
	ret, err := api.db.CheckComment(&strucBody)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}
	w.Header().Set("Endpoint", "checkcomment")
	if ret {
		//w.WriteHeader(http.StatusOK)
		w.Write([]byte("ok"))
		return
	}
	w.WriteHeader(http.StatusForbidden)
	w.Write([]byte("найдены запрещенные слова !"))
}

// headersMiddleware устанавливает заголовки ответа сервера.
func (api *API) headersMiddleware(next http.Handler) http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		reqID := r.URL.Query().Get("request_id")
		if len(reqID) == 0 {
			u := uuid.New()
			reqID = u.String()
		}

		logs.New().Debug(r.Header)
		logs.New().Debug(r.URL)
		next.ServeHTTP(w, r)
		w.Header().Set("Request-ID", reqID)
		w.Header().Set("Access-Control-Allow-Origin", "*")
		logstr := fmt.Sprintf("Date: %s, Host: %s, Metod: %s, Path %s,  ", time.Now().Format("02-Jan-2006 15:04:05.00"), r.Host, r.Method, r.URL.Path)
		logs.New().Info(logstr)
	})
}
