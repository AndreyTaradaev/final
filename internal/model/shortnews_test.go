// пакет  model был сформирован автоматически утилитой  protoc(protobuf)

// здесь находятся вспмогательные функции

package model

import (
	"reflect"
	"testing"
)

func TestNewShort(t *testing.T) {
	type args struct {
		id      int64
		title   string
		content string
		time    int64
		link    string
		idNews  string
	}
	w := ShortNew{ID: 0, Title: "Title", Content: "Content", PubTime: 111, Link: "url", Hash: 3200567209791299584}
	tests := []struct {
		name string
		args args
		want *ShortNew
	}{struct {
		name string
		args args
		want *ShortNew
	}{name: "1", args: args{id: 0, title: "Title", content: "Content", time: 111, link: "url", idNews: "IdNews"}, want: &w}} // TODO: Add test cases.

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			if got := NewShort(tt.args.id, tt.args.title, tt.args.content, tt.args.time, tt.args.link, tt.args.idNews); !reflect.DeepEqual(got, tt.want) {
				t.Errorf("NewShort() = %v, want %v", got, tt.want)
			}
		})
	}
}
