-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE TABLE Movimento (
  idMovimento INTEGER IDENTITY NOT NULL PRIMARY KEY,
  Pessoa_idPessoa INTEGER NOT NULL CHECK (Pessoa_idPessoa > 0),
  Produto_idProduto INTEGER NOT NULL CHECK (Produto_idProduto > 0),
  Usuario_idUsuario INTEGER NOT NULL CHECK (Usuario_idUsuario > 0),
  quantidade INTEGER NULL CHECK (quantidade > 0),
  tipo CHAR(1) NULL,
  valorUnitario NUMERIC(10, 2) NULL
);

CREATE INDEX Movimento_FKIndex1 ON Movimento(Usuario_idUsuario);
CREATE INDEX Movimento_FKIndex2 ON Movimento(Produto_idProduto);
CREATE INDEX Movimento_FKIndex3 ON Movimento(Pessoa_idPessoa);

-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE TABLE PessoaFisica (
  idPessoaFisica INTEGER IDENTITY NOT NULL PRIMARY KEY,
  Pessoa_idPessoa INTEGER NOT NULL CHECK (Pessoa_idPessoa > 0),
  cpf VARCHAR(20) NULL
);

CREATE INDEX PessaFisica_FKIndex1 ON PessoaFisica(Pessoa_idPessoa);

-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE TABLE Pessoa (
  idPessoa INTEGER IDENTITY NOT NULL PRIMARY KEY,
  nome VARCHAR(255) NULL,
  logradouro VARCHAR(255) NULL,
  cidade VARCHAR(255) NULL,
  estado CHAR(2) NULL,
  telefone VARCHAR(11) NULL,
  email VARCHAR(255) NULL
);

-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE TABLE PessoaJuridica (
  idPessoaJuridica INTEGER IDENTITY NOT NULL PRIMARY KEY,
  Pessoa_idPessoa INTEGER NOT NULL CHECK (Pessoa_idPessoa > 0),
  cnpj VARCHAR(20) NULL
);

CREATE INDEX PessoaJuridica_FKIndex1 ON PessoaJuridica(Pessoa_idPessoa);

-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE TABLE Produto (
  idProduto INTEGER IDENTITY NOT NULL PRIMARY KEY,
  nome VARCHAR(255) NULL,
  quantidade INTEGER NULL CHECK (quantidade > 0),
  precoVenda NUMERIC(10, 2) NULL -- Alterado o tipo de dados para NUMERIC(10, 2)
);

-- SQLINES LICENSE FOR EVALUATION USE ONLY
CREATE TABLE Usuario (
  idUsuario INTEGER IDENTITY NOT NULL PRIMARY KEY,
  login VARCHAR(20) NULL,
  senha VARCHAR(20) NULL
);
