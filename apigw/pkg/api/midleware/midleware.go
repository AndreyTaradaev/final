// лог HTTP запроса и ответа
package midleware

import (
	"fmt"
	logs "gateway/internal/log"
	"net/http"
	"time"

	"github.com/google/uuid"
)

type loggingResponseWriter struct {
	http.ResponseWriter
	statusCode int
}

func newLoggingResponseWriter(w http.ResponseWriter) *loggingResponseWriter {
	return &loggingResponseWriter{w, http.StatusOK}
}

func (lrw *loggingResponseWriter) WriteHeader(code int) {
	lrw.statusCode = code
	lrw.ResponseWriter.WriteHeader(code)
}

func WrapHandlerWithLogging(wrappedHandler http.Handler) http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		logstr := fmt.Sprintf("Date: %s, Host: %s, Metod: %s, Path %s,  ", time.Now().Format("02-Jan-2006 15:04:05.00"), r.Host, r.Method, r.URL.Path)
		reqID := r.URL.Query().Get("request_id")
		if len(reqID) == 0 {
			u := uuid.New()
			reqID = u.String()
		}
		w.Header().Set("Request-ID", reqID)
		lrw := newLoggingResponseWriter(w)
		wrappedHandler.ServeHTTP(lrw, r)

		statusCode := lrw.statusCode
		logstr += "StatusCode: " + http.StatusText(statusCode) + ", Request-ID: " + reqID
		logs.New().Info(logstr)
	})
}

/*
 */
