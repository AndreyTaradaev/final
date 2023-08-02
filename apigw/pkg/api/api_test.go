// маршрутизатор для http сервера API приложения Gateway

package api

import (
	"bytes"
	_ "gateway/apigw/docs"
	"net/http"
	"net/http/httptest"
	"testing"
)

const (
	newsserver    = "127.0.0.1:11200"
	commentserver = "127.0.0.1:10001"
	censorserver  = "127.0.0.1:12035"
)

func TestAPI_endpoints(t *testing.T) {
	api, err := New(newsserver, commentserver, censorserver)
	if err != nil {
		t.Fatal(err)
		return
	}
	var testBody1 = []byte(`  {
	   		"content": "Ghbrjkmyj1112 asdasdqertyasdQWEYasd",
	   		"idnews" : 65222,
	   		"authorid":  1121 ,
	   		"time":  5556522222,

	   	"Parent": 46


	   	}`)
	var testBody2 = []byte(` {		
		"content": "Ghbrjkmyj1112 asdasdqertyasdQWErtYasd",
		"idnews" : 65222,		
		"authorid":  1121 ,
		"time":  5556522222,		
		"Parent": 46			
	}`)
	

	req := httptest.NewRequest(http.MethodGet, "/news/page/1", nil)
	rr := httptest.NewRecorder()
	api.Router().ServeHTTP(rr, req)
	// Проверяем код ответа.
	if !(rr.Code == http.StatusOK) {
		t.Errorf("код неверен: получили %d, а хотели %d", rr.Code, http.StatusOK)
	}

	req = httptest.NewRequest(http.MethodGet, "/news/10", nil)
	rr = httptest.NewRecorder()
	api.Router().ServeHTTP(rr, req)
	// Проверяем код ответа.
	if !(rr.Code == http.StatusOK) {
		t.Errorf("код неверен: получили %d, а хотели %d", rr.Code, http.StatusOK)
	}

	req = httptest.NewRequest(http.MethodGet, "/news/search?word=go&type=2&sort=url&direction=desc&request_id=444444444444444444444444", nil)
	rr = httptest.NewRecorder()
	api.Router().ServeHTTP(rr, req)
	// Проверяем код ответа.
	if !(rr.Code == http.StatusOK) {
		t.Errorf("код неверен: получили %d, а хотели %d", rr.Code, http.StatusOK)
	}

	req = httptest.NewRequest(http.MethodGet, "/news/detail/65222", nil)
	rr = httptest.NewRecorder()
	api.Router().ServeHTTP(rr, req)
	// Проверяем код ответа.
	if !(rr.Code == http.StatusOK) {
		t.Errorf("код неверен: получили %d, а хотели %d", rr.Code, http.StatusOK)
	}

	req = httptest.NewRequest(http.MethodPost, "/comment/1", bytes.NewBuffer(testBody2))
	rr = httptest.NewRecorder()
	api.Router().ServeHTTP(rr, req)
	// Проверяем код ответа.
	if !(rr.Code == http.StatusForbidden) {
		t.Errorf("код неверен: получили %d, а хотели %d", rr.Code, http.StatusForbidden)
	}
	req = httptest.NewRequest(http.MethodPost, "/comment/1", bytes.NewBuffer(testBody1))
	rr = httptest.NewRecorder()
	api.Router().ServeHTTP(rr, req)
	// Проверяем код ответа.
	if !(rr.Code == http.StatusOK) {
		t.Errorf("код неверен: получили %d, а хотели %d", rr.Code, http.StatusOK)
	}

	req = httptest.NewRequest(http.MethodGet, "/comment/65222", nil)
	rr = httptest.NewRecorder()
	api.Router().ServeHTTP(rr, req)
	// Проверяем код ответа.
	if !(rr.Code == http.StatusOK) {
		t.Errorf("код неверен: получили %d, а хотели %d", rr.Code, http.StatusOK)
	}

	req = httptest.NewRequest(http.MethodDelete, "/comment/45", nil)
	rr = httptest.NewRecorder()
	api.Router().ServeHTTP(rr, req)
	// Проверяем код ответа.
	if !(rr.Code == http.StatusOK) {
		t.Errorf("код неверен: получили %d, а хотели %d", rr.Code, http.StatusOK)
	}

}
