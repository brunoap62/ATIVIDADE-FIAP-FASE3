package main

import (
	"testing"
)

func TestConnectDB_InvalidURL(t *testing.T) {
	// Tenta conectar em uma porta onde não há PostgreSQL rodando
	_, err := connectDB("postgres://invalid_user:invalid_pass@127.0.0.1:54333/invalid_db?sslmode=disable&connect_timeout=1")
	if err == nil {
		t.Error("esperava erro ao conectar em URL de banco inválida, obteve nil")
	}
}
