package main

import (
	"crypto/sha256"
	"encoding/hex"
	"strings"
	"testing"
)

func TestGenerateAPIKey(t *testing.T) {
	key, err := generateAPIKey()
	if err != nil {
		t.Fatalf("esperava nenhum erro ao gerar chave, obteve: %v", err)
	}

	if !strings.HasPrefix(key, "tm_key_") {
		t.Errorf("esperava prefixo 'tm_key_', obteve: %s", key)
	}

	// tm_key_ (7 caracteres) + 64 caracteres hex (32 bytes) = 71 caracteres
	if len(key) != 71 {
		t.Errorf("esperava tamanho de 71 caracteres, obteve: %d", len(key))
	}

	// Verifica unicidade em múltiplas chamadas
	keys := make(map[string]bool)
	for i := 0; i < 50; i++ {
		k, err := generateAPIKey()
		if err != nil {
			t.Fatalf("erro na iteração %d: %v", i, err)
		}
		if keys[k] {
			t.Fatalf("chave duplicada gerada: %s", k)
		}
		keys[k] = true
	}
}

func TestHashAPIKey(t *testing.T) {
	tests := []struct {
		name     string
		input    string
		expected string
	}{
		{
			name:     "hash de string vazia",
			input:    "",
			expected: func() string { h := sha256.Sum256([]byte("")); return hex.EncodeToString(h[:]) }(),
		},
		{
			name:     "hash de texto conhecido",
			input:    "minha-chave-secreta-123",
			expected: func() string { h := sha256.Sum256([]byte("minha-chave-secreta-123")); return hex.EncodeToString(h[:]) }(),
		},
		{
			name:     "hash determinístico",
			input:    "tm_key_1234567890abcdef",
			expected: func() string { h := sha256.Sum256([]byte("tm_key_1234567890abcdef")); return hex.EncodeToString(h[:]) }(),
		},
	}

	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			got := hashAPIKey(tt.input)
			if got != tt.expected {
				t.Errorf("hashAPIKey(%q) = %s; esperado %s", tt.input, got, tt.expected)
			}
			if len(got) != 64 {
				t.Errorf("tamanho do hash = %d; esperado 64", len(got))
			}
		})
	}
}
