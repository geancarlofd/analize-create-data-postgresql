-- Drop all tables if they exist (safe cleanup for testing)
DROP SCHEMA public CASCADE;
CREATE SCHEMA public;

-- Tabela de usuários
CREATE TABLE usuarios (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    senha_hash TEXT NOT NULL,
    data_cadastro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Endereços dos usuários
CREATE TABLE enderecos (
    id SERIAL PRIMARY KEY,
    usuario_id INT REFERENCES usuarios(id),
    rua VARCHAR(150),
    numero VARCHAR(10),
    complemento VARCHAR(50),
    cidade VARCHAR(100),
    estado CHAR(2),
    cep VARCHAR(10)
);

-- Categorias de produtos
CREATE TABLE categorias (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    descricao TEXT
);

-- Produtos
CREATE TABLE produtos (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT,
    preco DECIMAL(10,2) NOT NULL,
    estoque INT NOT NULL,
    categoria_id INT REFERENCES categorias(id)
);

-- Imagens dos produtos
CREATE TABLE imagens_produto (
    id SERIAL PRIMARY KEY,
    produto_id INT REFERENCES produtos(id),
    url TEXT NOT NULL,
    legenda TEXT
);

-- Carrinho de compras
CREATE TABLE carrinhos (
    id SERIAL PRIMARY KEY,
    usuario_id INT REFERENCES usuarios(id),
    data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Itens no carrinho
CREATE TABLE carrinho_itens (
    id SERIAL PRIMARY KEY,
    carrinho_id INT REFERENCES carrinhos(id),
    produto_id INT REFERENCES produtos(id),
    quantidade INT NOT NULL
);

-- Pedidos
CREATE TABLE pedidos (
    id SERIAL PRIMARY KEY,
    usuario_id INT REFERENCES usuarios(id),
    endereco_entrega_id INT REFERENCES enderecos(id),
    data_pedido TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(50) DEFAULT 'pendente'
);

-- Itens do pedido
CREATE TABLE pedido_itens (
    id SERIAL PRIMARY KEY,
    pedido_id INT REFERENCES pedidos(id),
    produto_id INT REFERENCES produtos(id),
    quantidade INT NOT NULL,
    preco_unitario DECIMAL(10,2) NOT NULL
);

-- Pagamentos
CREATE TABLE pagamentos (
    id SERIAL PRIMARY KEY,
    pedido_id INT REFERENCES pedidos(id),
    forma_pagamento VARCHAR(50),
    valor DECIMAL(10,2),
    status VARCHAR(50) DEFAULT 'pendente',
    data_pagamento TIMESTAMP
);

-- Avaliações dos produtos
CREATE TABLE avaliacoes (
    id SERIAL PRIMARY KEY,
    usuario_id INT REFERENCES usuarios(id),
    produto_id INT REFERENCES produtos(id),
    nota INT CHECK (nota >= 1 AND nota <= 5),
    comentario TEXT,
    data_avaliacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Cupons de desconto
CREATE TABLE cupons (
    id SERIAL PRIMARY KEY,
    codigo VARCHAR(20) UNIQUE,
    desconto_percentual INT,
    valido_ate DATE
);

-- Cupons aplicados em pedidos
CREATE TABLE cupons_pedidos (
    id SERIAL PRIMARY KEY,
    pedido_id INT REFERENCES pedidos(id),
    cupom_id INT REFERENCES cupons(id)
);

-- Logs de acesso
CREATE TABLE acessos (
    id SERIAL PRIMARY KEY,
    usuario_id INT REFERENCES usuarios(id),
    ip VARCHAR(45),
    user_agent TEXT,
    data_acesso TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Notificações para o usuário
CREATE TABLE notificacoes (
    id SERIAL PRIMARY KEY,
    usuario_id INT REFERENCES usuarios(id),
    mensagem TEXT NOT NULL,
    lida BOOLEAN DEFAULT FALSE,
    data_envio TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
