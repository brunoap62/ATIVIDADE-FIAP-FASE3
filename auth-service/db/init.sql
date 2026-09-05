CREATE TABLE IF NOT EXISTS api_keys (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    
    -- key_hash armazena o hash SHA-256 da chave, que tem 64 caracteres hexadecimais
    key_hash VARCHAR(64) NOT NULL UNIQUE, 
    
    is_active BOOLEAN DEFAULT true,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Injeta a chave padrão de desenvolvimento para o evaluation-service
INSERT INTO api_keys (name, key_hash) 
VALUES ('evaluation-service-key', '18b75b4dd04fc7a5c81044bfa796f653c09e97a61a5673d7f5663e9f87d0e377')
ON CONFLICT (key_hash) DO NOTHING;