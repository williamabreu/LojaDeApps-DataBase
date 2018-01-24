/*
	GCC214 - Banco de Dados - 2017/2
	Loja De Apps
	
	@author Rafael Takehara
	@author Tarik Esmin
	@author	William Abreu
	
	MySQL script que cria todo o esquema
    do banco de dados (DDL).
*/


create schema LojaDeApps;

use LojaDeApps;


CREATE TABLE Usuario (
  login 					VARCHAR(50)		NOT NULL,
  email 					VARCHAR(50)		NOT NULL,
  senha 					VARCHAR(32) 	NOT NULL,
  nome 						VARCHAR(30) 	NOT NULL,
  tipo 						VARCHAR(10) 	NOT NULL,
  credito 					FLOAT		 	NOT NULL, 
  dataNasce 				DATE 			NOT NULL,
  
  CONSTRAINT pk_usuario PRIMARY KEY (login),
  CONSTRAINT uk_email UNIQUE (email)
);


ALTER TABLE Usuario
	ADD CONSTRAINT ck_tipo CHECK (tipo in ('individual', 'familiar', 'estudante')),
	ADD CONSTRAINT ck_email CHECK (email like '%@%.%');


CREATE TABLE Empresa (
  login 					VARCHAR(50) 	NOT NULL,
  cnpj 						CHAR(14)		NOT NULL,
  senha 					VARCHAR(32) 	NOT NULL,
  nome 						VARCHAR(30) 	NOT NULL,
  logradouro				VARCHAR(50) 	NOT NULL,
  numero 					INT 				NULL,
  bairro 					VARCHAR(20) 		NULL,
  cidade 					VARCHAR(20) 	NOT NULL,
  pais 						VARCHAR(20) 	NOT NULL,
  site 						VARCHAR(50) 		NULL,
  
  CONSTRAINT pk_empresa PRIMARY KEY (login),
  CONSTRAINT uk_cnpj UNIQUE (cnpj),
  CONSTRAINT uk_nome UNIQUE (nome)
);


CREATE TABLE Telefones (
  telefone 					VARCHAR(20) 	NOT NULL,
  Empresa_login 			VARCHAR(50) 	NOT NULL,
  
  CONSTRAINT pk_telefones PRIMARY KEY (Empresa_login, telefone),
  CONSTRAINT fk_telefones_empresa FOREIGN KEY (Empresa_login)
    REFERENCES Empresa (login)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);


ALTER TABLE Telefones
	ADD CONSTRAINT ck_telefone CHECK (telefone like '+% % %-%');


CREATE TABLE Emails (
  email 					VARCHAR(50)		NOT NULL,
  Empresa_login 			VARCHAR(50)		NOT NULL,
  
  CONSTRAINT pk_emails PRIMARY KEY (email, Empresa_login),
  CONSTRAINT fk_emails_empresa FOREIGN KEY (Empresa_login)
    REFERENCES Empresa (login)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);


ALTER TABLE Emails
	ADD CONSTRAINT ck_email CHECK (email like '%@%.%');


CREATE TABLE Dispositivo (
  identificador 			VARCHAR(15)		NOT NULL,
  Usuario_login 			VARCHAR(50) 	NOT NULL,
  sistema 					VARCHAR(20) 	NOT NULL,
  versao 					VARCHAR(20) 	NOT NULL,
  modelo 					VARCHAR(10) 	NOT NULL,
  certificado 				BOOLEAN 		NOT NULL,
  controleParental 			BOOLEAN 		NOT	NULL,
  updateDisp 				BOOLEAN 		NOT NULL,
  notificacao 				BOOLEAN		 	NOT NULL,
  
  CONSTRAINT pk_dipositivo PRIMARY KEY (identificador, Usuario_login),
  CONSTRAINT fk_dispositivo_usuario FOREIGN KEY (Usuario_login)
    REFERENCES Usuario (login)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT
);


CREATE TABLE Aplicativo (
  nroRegistro 				INT 			NOT NULL	auto_increment,
  Empresa_login				VARCHAR(50)		NOT NULL,
  nome 						VARCHAR(20) 	NOT NULL,
  tamanho 					INT 			NOT NULL,
  genero 					VARCHAR(10)		 	NULL,
  versao 					VARCHAR(20) 	NOT NULL,
  faixaEtaria 				INT 				NULL,
  downloads 				INT 			NOT	NULL	DEFAULT 0,
  nota 						FLOAT 				NULL	DEFAULT NULL,
  
  CONSTRAINT pk_aplicativo PRIMARY KEY (nroRegistro),
  CONSTRAINT fk_aplicativo_empresa FOREIGN KEY (Empresa_login)
    REFERENCES Empresa (login)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT uk_aplicativo UNIQUE (Empresa_login, nome)
);


ALTER TABLE Aplicativo
	ADD CONSTRAINT ck_idade CHECK (faixaEtaria in (NULL, 10, 12, 14, 16, 18));


CREATE TABLE Idiomas (
  idioma 					VARCHAR(20) 	NOT NULL,
  Aplicativo_nroRegistro 	INT 			NOT NULL,
  
  CONSTRAINT pk_idiomas PRIMARY KEY (idioma, Aplicativo_nroRegistro),
  CONSTRAINT fk_idiomas_aplicativo FOREIGN KEY (Aplicativo_nroRegistro)
    REFERENCES Aplicativo (nroRegistro)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);


CREATE TABLE Sistemas (
  sistema 					VARCHAR(20) 	NOT NULL,
  Aplicativo_nroRegistro 	INT 			NOT NULL,
  
  CONSTRAINT pk_sistemas PRIMARY KEY (Aplicativo_nroRegistro, sistema),
  CONSTRAINT fk_sistemas_aplicativo FOREIGN KEY (Aplicativo_nroRegistro)
    REFERENCES Aplicativo (nroRegistro)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);


CREATE TABLE Licenca (
  registro 					INT 			NOT NULL,
  Aplicativo_nroRegistro 	INT 			NOT NULL,
  tipo 						VARCHAR(20) 	NOT NULL,
  preco 					FLOAT		 		NULL,
  
  CONSTRAINT pk_licenca PRIMARY KEY (registro)/*,
  CONSTRAINT fk_licenca_aplicativo FOREIGN KEY (Aplicativo_nroRegistro)
    REFERENCES Aplicativo (nroRegistro)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT*/
  
  -- Comentar a definição de chave estrangeira para permitir
  -- a exclusão da tabela.
);


CREATE TABLE Adquire (
  Licenca_registro 			INT 			NOT NULL,
  Usuario_login 			VARCHAR(50) 	NOT NULL,
  metodoPag 				VARCHAR(10) 		NULL,
  
  CONSTRAINT pk_adquire PRIMARY KEY (Licenca_registro, Usuario_login)/*,
  CONSTRAINT fk_adquire_licenca FOREIGN KEY (Licenca_registro)
    REFERENCES Licenca (registro)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT fk_adquire_usuario FOREIGN KEY (Usuario_login)
    REFERENCES Usuario (login)
    ON DELETE CASCADE
    ON UPDATE CASCADE*/
  
  -- Comentar a definição de chave estrangeira para permitir
  -- a exclusão da tabela.
);


-- Exluir as tabelas Licenca e Adquire para criar uma
-- nova que será a mescla das duas.

DROP TABLE Licenca;
DROP TABLE Adquire;

CREATE TABLE AdquireLicenca (
  registro 					INT 			NOT NULL	auto_increment,
  Usuario_login 			VARCHAR(50) 	NOT NULL,
  Aplicativo_nroRegistro 	INT 			NOT NULL,
  tipo 						VARCHAR(20) 	NOT NULL,
  preco 					FLOAT		 		NULL,
  metodoPag 				VARCHAR(10) 		NULL,
  
  CONSTRAINT pk_adquire_licenca PRIMARY KEY (registro),
  CONSTRAINT fk_licenca_aplicativo FOREIGN KEY (Aplicativo_nroRegistro)
    REFERENCES Aplicativo (nroRegistro)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT fk_adquire_usuario FOREIGN KEY (Usuario_login)
    REFERENCES Usuario (login)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT ck_tipo CHECK (tipo in ('comercial', 'freeware', 'opensource'))
);


