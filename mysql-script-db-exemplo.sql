/* 
UFLA        Universidade Federal de Lavras
DCC         Departamento de Ciência da Computação
Disciplina  GCC214 - INTrodução a Sistemas de Banco de Dados
Professor   Denilson Alves Pereira

Script de exemplo - MySQL

*/

/*
Inicializar/parar serviço MySQL no Ubuntu:

sudo service mysql start
sudo service mysql stop
sudo service mysql restart

*/

CREATE SCHEMA Empresa;

use Empresa;

CREATE TABLE Departamento (
    idDepto    INT           NOT NULL auto_increment,
    nomeDepto  VARCHAR(30)   NOT NULL,
    idGerente  INT           NOT NULL,
    CONSTRAINT pk_depto PRIMARY KEY (idDepto),
    CONSTRAINT uk_nome UNIQUE (nomeDepto)
);

CREATE TABLE Funcionario (
    idFunc     INT           NOT NULL auto_increment,
    nomeFunc   VARCHAR(50)   NOT NULL,
    endereco   VARCHAR(80)   NOT NULL,
    dataNasc   DATE          NOT NULL,
    sexo       CHAR(1)       NOT NULL,
    salario    DECIMAL(8,2)  NOT NULL,
    idSuperv   INT               NULL,
    idDepto    INT           NOT NULL,
    CONSTRAINT pk_func PRIMARY KEY (idFunc),
    CONSTRAINT ck_sexo CHECK (sexo='M' or sexo='F')
);

CREATE TABLE Projeto (
    idProj       INT      NOT NULL auto_increment,
    nomeProj      VARCHAR(30)  NOT NULL,
    localizacao   VARCHAR(30)      NULL,
    idDepto      INT    NOT NULL,
    CONSTRAINT pk_proj PRIMARY KEY (idProj),
    CONSTRAINT fk_proj_depto FOREIGN KEY (idDepto)
       REFERENCES Departamento (idDepto),
    CONSTRAINT uk_nomeProj UNIQUE (nomeProj)
);

CREATE TABLE Dependente (
    idDep       INT          NOT NULL auto_increment,
    idFunc      INT          NOT NULL,
    nomeDep     VARCHAR(50)  NOT NULL,
    dataNasc    DATE         NOT NULL,
    sexo        CHAR(1)      NOT NULL,
    parentesco  CHAR(15)         NULL,
    CONSTRAINT pk_depend PRIMARY KEY (idDep),
    CONSTRAINT fk_dep_func FOREIGN KEY (idFunc)
       REFERENCES Funcionario (idFunc)
       ON DELETE CASCADE,
    CONSTRAINT ck_sexo_dep CHECK (sexo='M' or sexo='F')
);

CREATE TABLE Trabalha (
    idFunc    INT           NOT NULL,
    idProj    INT           NOT NULL,
    numHoras  DECIMAL(6,1)      NULL,
    CONSTRAINT pk_trab PRIMARY KEY (idFunc,idProj),
    CONSTRAINT fk_trab_func FOREIGN KEY (idFunc)
       REFERENCES Funcionario (idFunc)
       ON DELETE CASCADE,
    CONSTRAINT fk_trab_proj FOREIGN KEY (idProj)
       REFERENCES Projeto (idProj)
       ON DELETE CASCADE
);

INSERT INTO Funcionario
VALUES (1,'João B. Silva','R. Guaicui, 175','1955/02/01','M',500,2,1);
INSERT INTO Funcionario
VALUES (2,'Frank T. Santos','R. Gentios, 22','1966/02/02','M',1000,8,1);
INSERT INTO Funcionario
VALUES (3,'Alice N. Pereira','R. Curitiba, 11','1970/05/15','F',700,4,3);
INSERT INTO Funcionario
VALUES (4,'Júnia B. Mendes','R. E. Santos, 123','1976/07/06','F',1200,8,3);
INSERT INTO Funcionario
VALUES (5,'José S. Tavares','R. Iraí, 153','1975/10/12','M',1500,2,1);
INSERT INTO Funcionario
VALUES (6,'Luciana S. Santos','R. Iraí, 175','1960/10/10','F',600,2,1);
INSERT INTO Funcionario
VALUES (7,'Maria P. Ramos','R. C. Linhares, 10','1965/11/05','F',1000,4,3);
INSERT INTO Funcionario
VALUES (8,'Jaime A. Mendes','R. Bahia, 111','1960/11/25','M',2000,NULL,2);

INSERT INTO Departamento
VALUES (1,'Pesquisa',2);
INSERT INTO Departamento
VALUES (2,'Administração',8);
INSERT INTO Departamento
VALUES (3,'Construção',4);

ALTER TABLE Funcionario
ADD CONSTRAINT fk_func_depto FOREIGN KEY (idDepto)
       REFERENCES Departamento (idDepto);

ALTER TABLE Funcionario
ADD CONSTRAINT fk_func_superv FOREIGN KEY (idSuperv)
       REFERENCES Funcionario (idFunc)
       ON DELETE SET NULL;

ALTER TABLE Departamento
ADD CONSTRAINT fk_depto_func FOREIGN KEY (idGerente)
        REFERENCES Funcionario (idFunc);

INSERT INTO Dependente
VALUES (1,2,'Luciana','1990/11/05','F','Filha');
INSERT INTO Dependente
VALUES (2,2,'Paulo','1992/11/11','M','Filho');
INSERT INTO Dependente
VALUES (3,2,'Sandra','1996/12/14','F','Filha');
INSERT INTO Dependente
VALUES (4,4,'Mike','1997/11/05','M','Filho');
INSERT INTO Dependente
VALUES (5,1,'Max','1979/05/11','M','Filho');
INSERT INTO Dependente
VALUES (6,1,'Rita','1985/11/07','F','Filha');
INSERT INTO Dependente
VALUES (7,1,'Bety','1960/12/17','F','Esposa');

INSERT INTO Projeto
VALUES (1,'ProdX','Savassi',1);
INSERT INTO Projeto
VALUES (2,'ProdY','Luxemburgo',1);
INSERT INTO Projeto
VALUES (3,'ProdZ','Centro',1);
INSERT INTO Projeto
VALUES (10,'Computação','C. Nova',3);
INSERT INTO Projeto
VALUES (20,'Organização','Luxemburgo',2);
INSERT INTO Projeto
VALUES (30,'N. Benefícios','C. Nova',1);

INSERT INTO Trabalha
VALUES (1,1,32.5);
INSERT INTO Trabalha
VALUES (1,2,7.5);
INSERT INTO Trabalha
VALUES (5,3,40.0);
INSERT INTO Trabalha
VALUES (6,1,20.0);
INSERT INTO Trabalha
VALUES (6,2,20.0);
INSERT INTO Trabalha
VALUES (2,2,10.0);
INSERT INTO Trabalha
VALUES (2,3,10.0);
INSERT INTO Trabalha
VALUES (2,10,10.0);
INSERT INTO Trabalha
VALUES (2,20,10.0);
INSERT INTO Trabalha
VALUES (3,30,30.0);
INSERT INTO Trabalha
VALUES (3,10,10.0);
INSERT INTO Trabalha
VALUES (7,10,35.0);
INSERT INTO Trabalha
VALUES (7,30,5.0);
INSERT INTO Trabalha
VALUES (4,20,15.0);
INSERT INTO Trabalha
VALUES (8,20,NULL);

commit;
