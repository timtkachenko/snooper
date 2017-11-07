package main

import (
	"github.com/siddontang/go-mysql/canal"
	"github.com/siddontang/go-mysql/mysql"
	"log"
	"os"
	"os/signal"
	"syscall"
)

type MyEventHandler struct {
	canal.DummyEventHandler
}

func (h *MyEventHandler) OnRow(e *canal.RowsEvent) error {
	log.Printf("%s %v\n", e.Action, e.Rows)
	return nil
}

func (h *MyEventHandler) String() string {
	return "MyEventHandler"
}
func main() {
	cfg := canal.NewDefaultConfig()
	cfg.Addr = "127.0.0.1:3306"
	cfg.User = "root"
	cfg.Password = "root"
	// We only care table canal_test in test db
	cfg.Dump.TableDB = "snooper"
	cfg.Dump.Tables = []string{"job"}

	c, err := canal.NewCanal(cfg)
	if err != nil {
		//panic(err)
		log.Printf("error %v", err)
	}

	// Register a handler to handle RowsEvent
	c.SetEventHandler(&MyEventHandler{})

	// Start canal
	c.RunFrom(mysql.Position{})
	sigchan := make(chan os.Signal)
	signal.Notify(
		sigchan,
		syscall.SIGTERM,
		syscall.SIGQUIT,
	)
	<-sigchan
}
