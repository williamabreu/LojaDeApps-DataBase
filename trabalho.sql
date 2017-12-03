create schema LojaDeApps;

use LojaDeApps;

-- -----------------------------------------------------
-- Table Usuario
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Usuario (
  login 	VARCHAR(50) 	NOT NULL,
  email 	VARCHAR(50) 	NOT NULL,
  senha 	VARCHAR(32) 	NOT NULL,
  nome 		VARCHAR(30) 	NOT NULL,
  tipo 		VARCHAR(10) 	NOT NULL,
  credito 	DECIMAL(8, 2) 	NOT NULL, 
  dataNasce DATE 			NOT NULL,
  PRIMARY KEY (login),
  UNIQUE INDEX email_UNIQUE (email ASC)
);


-- -----------------------------------------------------
-- Table Empresa
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Empresa (
  login 		VARCHAR(50) NOT NULL,
  cnpj 			INT 		NOT NULL,
  senha 		VARCHAR(32) NOT NULL,
  nome 			VARCHAR(30) NOT NULL,
  logradouro	VARCHAR(50) NOT NULL,
  numero 		INT 			NULL,
  bairro 		VARCHAR(20) 	NULL,
  cidade 		VARCHAR(20) NOT NULL,
  pais 			VARCHAR(20) NOT NULL,
  site 			VARCHAR(50) 	NULL,
  PRIMARY KEY (login),
  UNIQUE INDEX cnpj_UNIQUE (cnpj ASC)
);


-- -----------------------------------------------------
-- Table Telefones
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Telefones (
  telefone 		VARCHAR(20) NOT NULL,
  Empresa_login VARCHAR(50) NOT NULL,
  PRIMARY KEY (Empresa_login, telefone),
  CONSTRAINT fk_Telefones_Empresa1
    FOREIGN KEY (Empresa_login)
    REFERENCES Empresa (login)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);


-- -----------------------------------------------------
-- Table Emails
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Emails (
  email 		VARCHAR(50) NOT NULL,
  Empresa_login VARCHAR(50) NOT NULL,
  PRIMARY KEY (email, Empresa_login),
  INDEX fk_Emails_Empresa1_idx (Empresa_login ASC),
  CONSTRAINT fk_Emails_Empresa1
    FOREIGN KEY (Empresa_login)
    REFERENCES Empresa (login)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);


-- -----------------------------------------------------
-- Table Dispositivo
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Dispositivo (
  identificador 	VARCHAR(15) NOT NULL,
  Usuario_login 	VARCHAR(50) NOT NULL,
  sistema 			VARCHAR(20) NOT NULL,
  versao 			VARCHAR(20) NOT NULL,
  modelo 			VARCHAR(10) NOT NULL,
  certificado 		TINYINT(1) 	NOT NULL,
  controleParental 	INT 			NULL,
  update 			TINYINT(1) 	NOT NULL,
  notificacao 		TINYINT(1) 	NOT NULL,
  PRIMARY KEY (identificador, Usuario_login),
  INDEX fk_Dispositivo_Usuario1_idx (Usuario_login ASC),
  CONSTRAINT fk_Dispositivo_Usuario1
    FOREIGN KEY (Usuario_login)
    REFERENCES Usuario (login)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT
);


-- -----------------------------------------------------
-- Table Aplicativo
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Aplicativo (
  nroRegistro 	INT 		NOT NULL,
  Empresa_cnpj 	INT 		NOT NULL,
  nome 			VARCHAR(20) NOT NULL,
  tamanho 		INT 		NOT NULL,
  genero 		VARCHAR(10) 	NULL,
  versao 		VARCHAR(20) NOT NULL,
  faixaEtaria 	INT 			NULL,
  downloads 	INT 		NOT	NULL,
  nota 			FLOAT 			NULL,
  PRIMARY KEY (nroRegistro),
  INDEX fk_Aplicativo_Empresa1_idx (Empresa_cnpj ASC),
  CONSTRAINT fk_Aplicativo_Empresa1
    FOREIGN KEY (Empresa_cnpj)
    REFERENCES Empresa (cnpj)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT
);


-- -----------------------------------------------------
-- Table Idiomas
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Idiomas (
  idioma 					VARCHAR(20) NOT NULL,
  Aplicativo_nroRegistro 	INT 		NOT NULL,
  PRIMARY KEY (idioma, Aplicativo_nroRegistro),
  INDEX fk_Idiomas_Aplicativo1_idx (Aplicativo_nroRegistro ASC),
  CONSTRAINT fk_Idiomas_Aplicativo1
    FOREIGN KEY (Aplicativo_nroRegistro)
    REFERENCES Aplicativo (nroRegistro)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);


-- -----------------------------------------------------
-- Table Sistemas
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Sistemas (
  sistema 					VARCHAR(20) NOT NULL,
  Aplicativo_nroRegistro 	INT 		NOT NULL,
  PRIMARY KEY (Aplicativo_nroRegistro, sistema),
  INDEX fk_Sistemas_Aplicativo1_idx (Aplicativo_nroRegistro ASC),
  CONSTRAINT fk_Sistemas_Aplicativo1
    FOREIGN KEY (Aplicativo_nroRegistro)
    REFERENCES Aplicativo (nroRegistro)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);


-- -----------------------------------------------------
-- Table Licenca
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Licenca (
  registro 					INT 			NOT NULL,
  Aplicativo_nroRegistro 	INT 			NOT NULL,
  tipo 						VARCHAR(20) 	NOT NULL,
  preco 					DECIMAL(8, 2) 		NULL,
  PRIMARY KEY (registro),
  INDEX fk_Licenca_Aplicativo1_idx (Aplicativo_nroRegistro ASC),
  CONSTRAINT fk_Licenca_Aplicativo1
    FOREIGN KEY (Aplicativo_nroRegistro)
    REFERENCES Aplicativo (nroRegistro)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT
);


-- -----------------------------------------------------
-- Table Adquire
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS Adquire (
  Licenca_registro 	INT 		NOT NULL,
  Usuario_login 	VARCHAR(50) NOT NULL,
  metodoPag 		VARCHAR(10) 	NULL,
  PRIMARY KEY (Licenca_registro, Usuario_login),
  INDEX fk_Adquire_Usuario1_idx (Usuario_login ASC),
  CONSTRAINT fk_Adquire_Licenca1
    FOREIGN KEY (Licenca_registro)
    REFERENCES Licenca (registro)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT fk_Adquire_Usuario1
    FOREIGN KEY (Usuario_login)
    REFERENCES Usuario (login)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);
