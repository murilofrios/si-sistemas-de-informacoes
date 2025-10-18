-- Adicionando DROP TABLE para garantir que a tabela seja recriada do zero
-- Script para criar a tabela de cadastros no Supabase
-- Execute este script no SQL Editor do Supabase

-- Remove a tabela se ela já existir (para evitar conflitos)
DROP TABLE IF EXISTS cadastros CASCADE;

-- Cria a tabela com os campos necessários
CREATE TABLE cadastros (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    telefone VARCHAR(20) NOT NULL,
    descricao TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Índice para busca rápida por email
CREATE INDEX idx_cadastros_email ON cadastros(email);

-- Índice para busca por data de criação
CREATE INDEX idx_cadastros_created_at ON cadastros(created_at DESC);

-- Comentários nas colunas para documentação
COMMENT ON TABLE cadastros IS 'Armazena cadastros de interessados no curso de Sistemas de Informação';
COMMENT ON COLUMN cadastros.nome IS 'Nome completo do interessado';
COMMENT ON COLUMN cadastros.email IS 'Email para contato';
COMMENT ON COLUMN cadastros.telefone IS 'Telefone com DDD';
COMMENT ON COLUMN cadastros.descricao IS 'Descrição ou comentários adicionais (opcional)';
COMMENT ON COLUMN cadastros.created_at IS 'Data e hora do cadastro';

-- Adicionando políticas de RLS para permitir inserções públicas
-- Habilita Row Level Security
ALTER TABLE cadastros ENABLE ROW LEVEL SECURITY;

-- Cria política para permitir que qualquer pessoa insira dados (necessário para formulário público)
CREATE POLICY "Permitir inserção pública de cadastros"
ON cadastros
FOR INSERT
TO anon, authenticated
WITH CHECK (true);

-- Cria política para permitir leitura apenas para usuários autenticados (opcional, para admin)
CREATE POLICY "Permitir leitura para usuários autenticados"
ON cadastros
FOR SELECT
TO authenticated
USING (true);
