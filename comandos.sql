CREATE TABLE endereco(
  codigo INT GENERATED ALWAYS AS IDENTITY,

  uf VARCHAR(2) NOT NULL,
  bairro VARCHAR(60) NOT NULL, 
  rua VARCHAR(60) NOT NULL,
  cep VARCHAR(10) NOT NULL,
  complemento VARCHAR(60),

  PRIMARY KEY (codigo)
);

CREATE TABLE tipoFuncionario (
  codigo INT GENERATED ALWAYS AS IDENTITY,

  descricao VARCHAR(60),

  PRIMARY KEY (codigo)
);

CREATE TABLE ferramenta(
  numero_serie VARCHAR(30) PRIMARY KEY,

  descricao VARCHAR(50) NOT NULL
);

CREATE TABLE aparelho(
  numero_serie VARCHAR(30) PRIMARY KEY,

  descricao VARCHAR(50) NOT NULL
);

CREATE TABLE formaPagamento(
  codigo INT GENERATED ALWAYS AS IDENTITY,

  tipo_pagamento VARCHAR(10) NOT NULL,
  descricao VARCHAR(60) NOT NULL,
  bandeira VARCHAR(60),

  PRIMARY KEY(codigo)
);

CREATE TABLE cliente (
  codigo INT GENERATED ALWAYS AS IDENTITY,
  endereco BIGINT NOT NULL,

  nome VARCHAR(60) NOT NULL,

  PRIMARY KEY (codigo),
  FOREIGN KEY (endereco) REFERENCES endereco (codigo)
);

CREATE TABLE funcionario (
  contrato VARCHAR(60) PRIMARY KEY,
  tipo_funcionario INT NOT NULL,

  nome VARCHAR(30) NOT NULL,

  FOREIGN KEY (tipo_funcionario) REFERENCES tipoFuncionario (codigo)
);

CREATE TABLE telefoneCliente(
  codigo BIGINT,
  telefone VARCHAR(13),

  PRIMARY KEY (codigo, telefone),
  FOREIGN KEY (codigo) REFERENCES cliente(codigo)
);

CREATE TABLE telefoneFuncionario(
  codigo VARCHAR(60),
  telefone VARCHAR(13),

  PRIMARY KEY (codigo, telefone),
  FOREIGN KEY (codigo) REFERENCES funcionario(contrato)
);

CREATE TABLE ordemDeServico (
  numero_ordem INT GENERATED ALWAYS AS IDENTITY,
  codigo_cliente BIGINT NOT NULL,

  estado VARCHAR(10) NOT NULL,
  previsao DATE NOT NULL,
  data_recebimeto DATE NOT NULL,
  marca_aparelho VARCHAR(15),
  descricao_defeito VARCHAR(30),

  PRIMARY KEY (numero_ordem),
  FOREIGN KEY (codigo_cliente) REFERENCES cliente(codigo)
);

CREATE TABLE ordemDeServico_formaPagamento (
  numero_ordem INT,
  tipo_pagamento INT,

  numero_seguranca BIGINT NOT NULL, 
  data_pagamento DATE NOT NULL,
  valor REAL NOT NULL,

  PRIMARY KEY (numero_ordem, tipo_pagamento),
  FOREIGN KEY (numero_ordem) REFERENCES ordemDeServico (numero_ordem),
  FOREIGN KEY (tipo_pagamento) REFERENCES formaPagamento (codigo)
);

CREATE TABLE ordemDeServico_funcionario (
  numero_ordem INT,
  contrato VARCHAR(60),

  PRIMARY KEY (numero_ordem, contrato),
  FOREIGN KEY (numero_ordem) REFERENCES ordemDeServico (numero_ordem),
  FOREIGN KEY (contrato) REFERENCES funcionario (contrato)
);

CREATE TABLE ordemDeServico_aparelho(
  numero_ordem INT,
  numero_serie VARCHAR(30),
  previsao DATE NOT NULL,

  PRIMARY KEY (numero_ordem, numero_serie),
  FOREIGN KEY (numero_ordem) REFERENCES ordemDeServico(numero_ordem),
  FOREIGN KEY (numero_serie) REFERENCES aparelho (numero_serie)
);

CREATE TABLE ordemDeServico_ferramenta(
  numero_ordem INT,
  numero_serie VARCHAR(30),
  
  previsao DATE NOT NULL,

  PRIMARY KEY (numero_ordem, numero_serie),
  FOREIGN KEY (numero_ordem) REFERENCES ordemDeServico(numero_ordem),
  FOREIGN KEY (numero_serie) REFERENCES ferramenta (numero_serie)
);
