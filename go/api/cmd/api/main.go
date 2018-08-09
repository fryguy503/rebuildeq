package main

import (
	"github.com/rs/zerolog"
	"github.com/rs/zerolog/log"
	"github.com/xackery/rebuildeq/go/api/internal/service/nats"
	"github.com/xackery/rebuildeq/go/api/internal/service/web"
	"github.com/xackery/rebuildeq/go/api/internal/storage/sql"
)

type api struct {
}

func main() {
	zerolog.TimeFieldFormat = ""

	zerolog.SetGlobalLevel(zerolog.InfoLevel)
	//if *debug {
	//	zerolog.SetGlobalLevel(zerolog.DebugLevel)
	//}
	logInfo := log.Info()
	//logError := log.Error()
	logInfo.Msg("initializing")
	//api := &api{}

	sql, err := sql.NewSQLStorage()
	if err != nil {
		log.Fatal().Err(err).Msg("failed to initialize new sql storage")
	}

	webSvr, err := web.NewWebService(sql, []byte("2oi23∆™ø£∂ˆ∆"))
	if err != nil {
		log.Fatal().Err(err).Msg("failed to initialize new web service")
	}

	natsSvr, err := nats.NewNatsService()
	if err != nil {
		log.Fatal().Err(err).Msg("failed to initialize new nats service")
	}

	err = webSvr.ListenAndServe(123)
	err = natsSvr.ListenAndServe(142)

}
