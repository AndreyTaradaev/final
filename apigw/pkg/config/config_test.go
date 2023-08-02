// реализация файла конфигурации создает единственный экземпляр .

package config

import "testing"

func Test_config_Load(t *testing.T) {
	c := New()
	t.Run("1", func(t *testing.T) {

		if err := c.Load("config.json"); err != nil {
			t.Errorf("config.Load() error = %v", err)
		}
		t.Log(c.String())
		t.Log(c.Log(), c.Port(), c.Newshost(), c.Newsport())
		t.Log(c.Period(), c.CensorHost(), c.СensorPort(), c.СommentHost(), c.СommentPort())
	},
	)
	t.Run("1", func(t *testing.T) {
		if err := c.Load(""); err != nil {
			t.Errorf("config.Load() error = %v", err)
		}
	},
	)
	c.conf.Port = 0
	c.conf.NewsHost = ""
	c.conf.NewsPort = 0
	c.conf.CommentHost = ""
	c.conf.CommentPort = 0
	c.conf.CensorHost = ""
	c.conf.CensorPort = 0
	t.Run("1", func(t *testing.T) {
		if err := c.Load(""); err != nil {
			t.Errorf("config.Load() error = %v", err)
		}
	},
	)

}
