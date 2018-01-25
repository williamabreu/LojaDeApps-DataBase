-- -------------------------------------------------------------------------- --
--	                           REQUISITO (A)                                  --
--	                           REQUISITO (B)                                  --
-- -------------------------------------------------------------------------- --

create schema LojaDeApps;

use LojaDeApps;

/*
	Definição das colunas da tabela Usuario, bem como as restrições de que o
	login é chave primária e o email chave secundária.
*/
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

/*
	Adiciona a verificação do dado inserido nas colunas tipo e email na tabela.
*/
ALTER TABLE Usuario
   ADD CONSTRAINT ck_tipo CHECK (tipo in ('individual','familiar','estudante')),
   ADD CONSTRAINT ck_email CHECK (email like '%@%.%');

/*
	Definição das colunas da tabela Empresa, bem como as restriçoes de login
	como chave primária, cnpj e nome como chaves secundárias.
*/
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

/*
	Definição das colunas da tabela Telefone, que representa a lista de
	telefones de uma empresa. Assim, a chave primária consiste no par das
	duas únicas colunas, sendo Empresa_login uma referência para empresa.
*/
CREATE TABLE Telefones (
  telefone 					VARCHAR(20) 	NOT NULL,
  Empresa_login 			VARCHAR(50) 	NOT NULL,

  CONSTRAINT pk_telefones PRIMARY KEY (Empresa_login, telefone),
  CONSTRAINT fk_telefones_empresa FOREIGN KEY (Empresa_login)
    REFERENCES Empresa (login)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

/*
	Adiciona a verificação de telefone na tabela.
*/
ALTER TABLE Telefones
	ADD CONSTRAINT ck_telefone CHECK (telefone like '+% % %-%');

/*
	Definição da tabela de Emails, que tem funcionalidade semelhante à tabela
	Telefones.
*/
CREATE TABLE Emails (
  email 					VARCHAR(50)		NOT NULL,
  Empresa_login 			VARCHAR(50)		NOT NULL,

  CONSTRAINT pk_emails PRIMARY KEY (email, Empresa_login),
  CONSTRAINT fk_emails_empresa FOREIGN KEY (Empresa_login)
    REFERENCES Empresa (login)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

/*
	Adiciona verificação do email.
*/
ALTER TABLE Emails
	ADD CONSTRAINT ck_email CHECK (email like '%@%.%');

/*
	Definição da tabela Dispositivo, sendo Usuario_login chave estrangeira e o
	par identificador-Usuario_login a chave primária.
*/
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

/*
	Definição da tabela Aplicativo, sendo a chave primária um número
	auto-incrementado (i.e. gerado automaticamente) pelo SGBD e Emresa_login
	chave estrangeira de ralacionamento.
*/
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

/*
	Adiciona verificação dos tipos de idade válidos para a tabela.
*/
ALTER TABLE Aplicativo
	ADD CONSTRAINT ck_idade CHECK (faixaEtaria in (NULL, 10, 12, 14, 16, 18));

/*
	Definição da tabela idiomas, que serve como uma lista de idiomas de um
	aplicativo. Funcionamento semelhante às tabelas Telefones e Emails.
*/
CREATE TABLE Idiomas (
  idioma 					VARCHAR(20) 	NOT NULL,
  Aplicativo_nroRegistro 	INT 			NOT NULL,

  CONSTRAINT pk_idiomas PRIMARY KEY (idioma, Aplicativo_nroRegistro),
  CONSTRAINT fk_idiomas_aplicativo FOREIGN KEY (Aplicativo_nroRegistro)
    REFERENCES Aplicativo (nroRegistro)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

/*
	Definição da tebala de Sistemas operacionais, cuja estrutura é semelhante à
	tabela Idiomas.
*/
CREATE TABLE Sistemas (
  sistema 					VARCHAR(20) 	NOT NULL,
  Aplicativo_nroRegistro 	INT 			NOT NULL,

  CONSTRAINT pk_sistemas PRIMARY KEY (Aplicativo_nroRegistro, sistema),
  CONSTRAINT fk_sistemas_aplicativo FOREIGN KEY (Aplicativo_nroRegistro)
    REFERENCES Aplicativo (nroRegistro)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

/*
	Definição da tabela Licenca, que não será utilizada no sistema final.
*/
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

/*
	Definição da tabela Adquire, que não será utilizada no sistema final.
*/
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

/*
	Definição da tabela AdquireLicenca, que é a junção das tabelas Adquire e
	Licenca. Foi feita a mesclagem porque existe uma interdependência entre as
	tabelas, que têm o objetivo de formalizar o relacionamento entre um usuário
	e uma aplicativo, que é feit através da aquisição de licenças de uso.
*/
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

-- -------------------------------------------------------------------------- --
--	                           REQUISITO (C)                                  --
-- -------------------------------------------------------------------------- --

/*
	Ver em anexo as tabelas com os dados inseridos.
*/

delimiter //

-- Função para inserir um novo usuário.
create procedure insertUsuario(
	in login varchar(50),
    in email varchar(50),
    in senha varchar(32),
    in nome varchar(30),
    in tipo varchar(10),
    in credito float,
    in dataNasce date
)
begin
	insert into Usuario
	values (login, email, MD5(senha), nome, tipo, credito, dataNasce);
end //

-- Função para inserir uma nova empresa.
create procedure insertEmpresa(
	in login varchar(50),
    in cnpj char(14),
    in senha varchar(32),
    in nome varchar(30),
    in logradouro varchar(50),
    in numero int,
    in bairro varchar(20),
    in cidade varchar(20),
    in pais varchar(20),
    in site varchar(50)
)
begin
	insert into Empresa values (login, cnpj, MD5(senha), nome, logradouro, 
								numero, bairro, cidade, pais, site);
end //

-- Função para inserir novo telefone.
create procedure insertTelefone(in fone varchar(20), empresaLogin varchar(50))
begin
	insert into Telefones values (fone, empresaLogin);
end //


-- Função para inserir novo e-mail.
create procedure insertEmail(in email varchar(50), empresaLogin varchar(50))
begin
	insert into Emails values (email, empresaLogin);
end //

-- Função para inserir novo dispositivo.
create procedure insertDispositivo(
	in identificador varchar(15),
    in usuarioLogin varchar(50),
    in sistema varchar(20),
    in modelo varchar(10),
    in versao varchar(20),
    in certificado bool,
    in controleParental bool,
    in updateDisp bool,
    in notificacao bool
)
begin
	insert into Dispositivo
    values (identificador, usuarioLogin, sistema, modelo, versao, certificado,
            controleParental, updateDisp, notificacao);
end //

-- Função para inserir novo aplicativo.
create procedure insertAplicativo(
	in empresaLogin varchar(50),
	in nome varchar(20),
	in tamanho int,
	in genero varchar(10),
	in versao varchar(20),
	in faixaEtaria int
)
begin
	insert into Aplicativo
	(Empresa_login, nome, tamanho, genero, versao, faixaEtaria, downloads, nota)
    values (empresaLogin, nome, tamanho, genero, versao, faixaEtaria, 0, NULL);
end //

-- Função para inserir novo idioma.
create procedure insertIdioma(
	in idioma varchar(20),
	in nomeApp varchar(20),
	in loginDev varchar(50)
)
begin
	declare nro int;

    select nroRegistro into nro
    from Aplicativo
	where Empresa_login = loginDev and nome = nomeApp;

    insert into Idiomas values (idioma, nro);
end //

-- Função para inserir novo sistema.
create procedure insertSistema(
	in sistema varchar(20),
	in nomeApp varchar(20),
	in loginDev varchar(50)
)
begin
	declare nro int;

    select nroRegistro into nro
    from Aplicativo
	where Empresa_login = loginDev and nome = nomeApp;

	insert into Sistemas values (sistema, nro);
end //

-- Função para inserir nova transação de adquirir licença.
create procedure insertAdquireLicenca(
	in loginUser varchar(50),
	in nomeApp varchar(20),
    in loginDev varchar(50),
	in tipo varchar(20),
	in preco float,
	in metodoPag varchar(10)
)
begin
    declare appNroRegistro int;

    select nroRegistro into appNroRegistro
    from Aplicativo
	where Empresa_login = loginDev and nome = nomeApp;

	insert into AdquireLicenca
	(Usuario_login, Aplicativo_nroRegistro, tipo, preco, metodoPag)
    values (loginUser, appNroRegistro, tipo, preco, metodoPag);
end //

delimiter ;

-- -------------------------------------------------------------------------- --
--	                           REQUISITO (D)                                  --
-- -------------------------------------------------------------------------- --

delimiter //

-- Procedimento que muda o nome do usuário.
create procedure setUsuarioNome(in loginRef varchar(50), novoNome varchar(30))
begin
	update Usuario
    set nome = novoNome
    where login = loginRef;
end //

-- Procedimento que muda o tipo de usuário.
create procedure setUsuarioTipo(in loginRef varchar(50), in newTipo varchar(10))
begin
	update Usuario
    set tipo = newTipo
    where login = loginRef and newTipo in ('individual','familiar','estudante');
end //

-- Procedimento que muda o valor de crédito do usuário.
create procedure setUsuarioCredito(in loginRef varchar(50), in newCredito float)
begin
	update Usuario
    set credito = newcredito
    where login = loginRef;
end //

-- Procedimento que insere o valor de notaref na nota do aplicativo mais caro
-- do sistema (que teve maior preço de venda de licença).
create procedure setNotaMaiorPreco(in notaref float)
begin
	update Aplicativo
	set nota = notaref
	where nota is null and
	      nroRegistro in (select Aplicativo_nroRegistro from AdquireLicenca
						  where preco >= all (select preco from AdquireLicenca
											  where preco is not null));
end //

-- Procedimento que muda versão do sistema de um dispositivo.
create procedure setVersaoSistema(in vers varchar(20), in sist varchar(20))
begin
    update Dispositivo
	set versao = vers
    where sistema = sist;
end //

delimiter ;

/*
	Exemplo que desliga o controleParental para todos os usuários que possuem
	mais de 18 anos de acordo com a data atual.
*/
update Dispositivo
set controleParental = false
where  Usuario_login in (select login from Usuario
                         where
                         (datediff(curdate(), Usuario.dataNasce)/365.25) >= 18);

/*
	Exemplo que acrescenta ao nome da empresa o nome do seu país para todas as
	empresas que possuem mais do que 2 aplicativos cadastrados.
*/
update Empresa
set nome = concat(nome,' ', pais)
where Empresa.login in (select Empresa_login from Aplicativo
                        group by Empresa_login
                        having count(*) > 2);

/*
	Exemplo que reajusta o preco da licença em 10% para aplicativos com
	mais de 5 downloads.
*/
update AdquireLicenca
set preco = preco * 1.10
where Aplicativo_nroRegistro in (select nroRegistro from Aplicativo
							     where downloads > 5);

-- -------------------------------------------------------------------------- --
--	                           REQUISITO (E)                                  --
-- -------------------------------------------------------------------------- --

delimiter //

-- Procedimento que deleta um usuário identificado pelo login dado.
create procedure deleteUsuario(in login varchar(50))
begin
	delete from Usuario where Usuario.login = login;
end //

-- Procedimento encarregado de deletar log de empresas a partir do login e senha
delimiter //
create procedure deletaEmpresa(in login varchar(50), in senha varchar(32))
begin
	delete from Empresa
	where Empresa.login = login and Empresa.senha = MD5(senha);
end //
delimiter ;

-- Deleta licenças de aplicativos com menos de 5 downloads.
delete from AdquireLicenca
where Aplicativo_nroRegistro not in (select nroRegistro
									 from Aplicativo
									 group by nroRegistro
									 having sum(downloads) >= 5);

-- Deleta usuários com creditos negativos e idade menor que 18 anos.
delete from Usuario
where Usuario.credito < 0 and
      (datediff(curdate(), Usuario.dataNasce)/365.25) < 18;

-- Deleta dispostivos sem certificados ou dispositvos sem atualização
-- em que os donos tem menos de 20 creditos.
delete from Dispositivo
where Dispositivo.certificado  = false or Dispositivo.updateDisp = false
and Usuario_login not in (select login
						  from Usuario
						  where credito > 20);

-- -------------------------------------------------------------------------- --
--	                           REQUISITO (F)                                  --
-- -------------------------------------------------------------------------- --

-- Consulta o email do usuário de nome Ricardo Planeta.
select email 
from Usuario 
where nome = 'Ricardo Planeta';

-- Consulta os nomes das empresas, em ordem decrescente, cujo país seja Brasil
-- ou USA.
select nome 
from Empresa 
where pais= 'Brasil' OR 'USA' 
order by nome desc;

-- Consulta o telefone das empresas que não possuem site ou não possuam bairro
-- definido.
select telefone 
from Empresa natural join Telefones 
where site or bairro is null;

-- Consulta o registro e o nome dos aplicativos que não possuem download entre
-- 0 e 5.
select nroRegistro, nome 
from Aplicativo 
where downloads not between 0 and 5;

-- Consulta o login dos usuários que possuem nome composto por dois nomes e tem
-- a inicial A.
select login
from Usuario 
where nome like 'A% %';

-- Consulta a identificação dos dispositivos cujo usuário tem crédito inferior
-- a 120 reais.
select identificador
from Dispositivo 
where  Usuario_login in (select login from Usuario where credito <= 120);

-- Consulta o cnpj das empresas que possuem pelo menos um aplicativo cadastrado.
select cnpj
from Empresa 
where exists (select * from Aplicativo);

-- Consulta o registro e o nome dos aplicativos que possuem nota entre 4 e 5.
select nroRegistro, nome 
from Aplicativo 
where nota between 4 and 5;

-- Consulta os nomes dos aplicativos que possuem licença freeware ou opensource.
select distinct nome
from AdquireLicenca L join Aplicativo A 
on L.Aplicativo_nroRegistro = A.nroRegistro
where (L.preco = 0) or (L.preco is null);

-- Consulta o nome das empresas que possuem mais de dois telefones.
select E.nome
from Empresa E join Telefones T on E.login = T.Empresa_login
group by E.nome
having count(telefone) > 2;

-- Consulta o nome dos aplicativos que foram vendidas licenças com preço 
-- superior a 100 reais e pagas através de bitcoin OU o usuário que adquiriu
-- a licença do app possui crédito superior a 400.
select nome
from Aplicativo
where nroRegistro in (select Aplicativo_nroRegistro
					  from AdquireLicenca 
					  where preco > 100 and metodoPag = 'bitcoin')
Union
select A.nome
from Aplicativo A, AdquireLicenca L, Usuario U
where A.nroRegistro = L.Aplicativo_nroRegistro and 
      L.Usuario_login = U.login and U.credito > 400;

-- Consulta o número total de downloadas que os aplicativos da Microsoft
-- possuem.
select sum(downloads)
from Empresa E join Aplicativo A on E.login = A.Empresa_login
where E.nome = 'Microsoft';

-- Consulta o nome, número de downloads e o gênero dos aplicativos da Microsoft
-- que possuem número de downloads maior do que algum app do Google ou da
-- Pcenter Informática.
select  A.nome, downloads, genero
from Empresa E join Aplicativo A on E.login = A.Empresa_login
where E.nome = 'Microsoft' and 
      A.downloads > any (select A.downloads 
                         from Empresa E join Aplicativo A 
                         on E.login = A.Empresa_login
						 where E.nome='Google' or E.nome='Pcenter Informática');

-- Consulta o nome, o email e o crédito dos usuários que possuem saldo 
-- suficiente para adquirir alguma licença comercial que já foi vendida.
select  nome, email, credito
from Usuario
where credito >= all (select preco from AdquireLicenca where preco is not null);

-- Consulta o nome do usuário e a quantidade de aplicativos que ele baixou.
select  U.nome, count(*) as nroAplicativosAdquiridos
from Usuario U, Aplicativo A, AdquireLicenca L
where U.login = L.Usuario_login and A.nroRegistro = L.Aplicativo_nroRegistro
group by U.nome;

-- -------------------------------------------------------------------------- --
--	                           REQUISITO (G)                                  --
-- -------------------------------------------------------------------------- --

-- Mostra a empresa e seus emails.
create view EmpresaEmails as
	select nome, email
    from Empresa, Emails
    where login = Empresa_login
    order by nome asc;

-- Mostra a empresa e seus telefones.
create view EmpresaTelefones as
	select nome, telefone
    from Empresa, Telefones
    where login = Empresa_login
    order by nome asc;

-- Mostra o aplicativo e seus idiomas.
create view AplicativoIdiomas as
	select Aplicativo.nome app, Empresa.nome dev, Idiomas.idioma idioma
    from Aplicativo, Empresa, Idiomas
    where nroRegistro = Aplicativo_nroRegistro and
		  login = Empresa_login
	order by app asc;

-- Mostra o aplicativo e seus sistemas.
create view AplicativoSistemas as
	select Aplicativo.nome app, Empresa.nome dev, Sistemas.sistema so
    from Aplicativo, Empresa, Sistemas
    where nroRegistro = Aplicativo_nroRegistro and
		  login = Empresa_login
	order by app asc;

-- Mostra a empresa e os aplicativos que ela criou.
create view EmpresaAplicativos as
	select Empresa.nome dev, Aplicativo.nome app
    from Empresa, Aplicativo
    where login = Empresa_login
    order by dev asc;

-- Mostra o usuário e os dispositivos que possui.
create view UsuarioDispositivos as
	select login usuario, identificador dispositivo
    from Usuario, Dispositivo
    where login = Usuario_login
    order by login asc;

-- Mostra o usuário e os aplicativos que baixou (adquiriu licença).
create view UsuariosAplicativos as
	select Usuario.login usuario, Aplicativo.nome app, Empresa.nome dev
    from Usuario, AdquireLicenca, Aplicativo, Empresa
    where Usuario_login = Usuario.login and
		  Aplicativo_nroRegistro = nroRegistro and
          Empresa_login = Empresa.login
	order by usuario asc;

-- Exemplos de uso das views:

-- Lista todos os e-mails da Apple Inc.
select email from EmpresaEmails where nome = 'Apple Inc.';

-- Lista os nomes dos apps que estão disponíveis em português.
select app, dev from AplicativoIdiomas where idioma = 'pt-BR';

-- Lista todo o conteúdo das views.
select * from EmpresaTelefones;
select * from AplicativoSistemas;
select * from EmpresaAplicativos;
select * from UsuarioDispositivos;
select * from UsuariosAplicativos;

-- -------------------------------------------------------------------------- --
--	                           REQUISITO (H)                                  --
-- -------------------------------------------------------------------------- --

-- Cria o usuário desenvolvedor:
create user 'desenvolvedor'@'localhost' identified by 'dev845';

-- Concede privilégios ao usuário desenvolvedor:

grant delete, select, 
      insert (nome,tamanho,genero,versao,faixaEtaria, Empresa_login) 
      on LojaDeApps.Aplicativo 
      to 'desenvolvedor'@'localhost';

grant update (nome, genero,tamanho,versao) on LojaDeApps.Aplicativo 
      to 'desenvolvedor'@'localhost';

grant select on LojaDeApps.Sistemas to 'desenvolvedor'@'localhost';

grant select, update, delete on LojaDeApps.AplicativoIdiomas 
	  to 'desenvolvedor'@'localhost';

grant select,update,delete on LojaDeApps.AplicativoSistemas 
	  to 'desenvolvedor'@'localhost';

grant select on LojaDeApps.EmpresaEmails to 'desenvolvedor'@'localhost';

grant update on LojaDeApps.EmpresaAplicativos to 'desenvolvedor'@'localhost';

-- Faz restrições ao usuário desenvolvedor:

revoke delete on LojaDeApps.Aplicativo from 'desenvolvedor'@'localhost';

revoke select on LojaDeApps.EmpresaEmails from 'desenvolvedor'@'localhost';

revoke all on LojaDeApps.AplicativoSistemas from 'desenvolvedor'@'localhost';

-- Cria o usuário CEO:
create user 'CEO'@'localhost' identified by 'CEO@LojadeApps';

-- Concede privilégios ao usuário CEO:

grant all on LojaDeApps.Aplicativo to 'CEO'@'localhost';

grant select (tipo, credito), references, create view on LojaDeApps.Usuario 
	  to 'CEO'@'localhost' ;

grant select (sistema, versao, modelo, controleParental) 
	  on LojaDeApps.Dispositivo 
	  to 'CEO'@'localhost';

grant insert, update, alter, create view, trigger on LojaDeApps.Empresa 
	  to 'CEO'@'localhost';

grant insert, delete on LojaDeApps.Emails to 'CEO'@'localhost';

grant insert, update, delete on LojaDeApps.EmpresaTelefones 
	  to 'CEO'@'localhost';

-- Faz restrições ao usuário CEO:

revoke all on LojaDeApps.Aplicativo from 'CEO'@'localhost';

revoke delete, insert on LojaDeApps.EmpresaTelefones from 'CEO'@'localhost';
 
revoke select(credito) on LojaDeApps.Usuario from 'CEO'@'localhost';

-- -------------------------------------------------------------------------- --
--	                           REQUISITO (I)                                  --
-- -------------------------------------------------------------------------- --

/*
	Outros procedimentos foram criados ao longo do documento.
*/

delimiter //

-- Procedure cria uma lista de emails de todos os usarios cadastrados, 
-- separando-os por vírgula (formato CSV).
create procedure ObtemListaEmailUsuario(inout listaEmail varchar(10000))
BEGIN

  declare done int default false;

  declare emailUser varchar(5000) default "";

  declare obtemEmail cursor for 	
	select  U.email
	from Usuario U
	group by U.login;

  declare continue handler for not found set done = true;

  OPEN obtemEmail;

  get_email: loop
    fetch obtemEmail INTO emailUser;
    
	if done then
      leave get_email;
    end if;
    
   set listaEmail = concat(emailUser,',', listaEmail);
   
   end loop;
   
  close obtemEmail;
 
END //
 
DELIMITER ; 

-- Exemplo de uso:
SET @listaEmailUsuarios = '';
CALL ObtemListaEmailUsuario(@listaEmailUsuarios);
SELECT @listaEmailUsuarios;

delimiter $$

-- Procedure que obtem a media de downlaods de todos os app cadastrados na loja.
create procedure ObtemMediaDownloads(out media decimal(10,3))
begin
	declare somaDownloads float;
    declare totalApps int;
    
	select sum(downloads) into somaDownloads
	from Aplicativo
    order by nome asc;

	select count(*) into totalApps
    from Aplicativo;
	
    
    set media = somaDownloads/totalApps;
end $$

delimiter ;

-- Exemplo de uso:
set @mediaDownloads = null;
call ObtemMediaDownloads(@mediaDownloads);
select @mediaDownloads;

-- -------------------------------------------------------------------------- --
--	                           REQUISITO (J)                                  --
-- -------------------------------------------------------------------------- --

delimiter //

-- Incrementa o número de downloads de forma automatica após adquirir a licença.
create trigger after_insert_adquireLicenca
after insert on AdquireLicenca
for each row
begin	
	update Aplicativo
	set downloads = downloads + 1
	where nroRegistro = new.Aplicativo_nroRegistro;    
end //

-- Atualiza o login do usuario, modificada na tabela Usuario, em outras tabelas.
create trigger update_login_Usuario
after update on Usuario
for each row
begin 
	if (length(new.login) >= 3) then
    
		update AdquireLicenca
        set Usuario_login = new.login;
        
        update Dispositivo
        set Usuario_login = new.login;
        		
    else
		signal sqlstate '45000' SET message_text = 'Login  muito curto, insira 
		um login com pelo menos 3 caracteres!';
	end if;
end //

delimiter ;

-- Cria nova tabela.                        
CREATE TABLE HistoricoEmpresas ( 
  responsavel               VARCHAR(50)    	NOT NULL,
  data_delecao              DATE			NOT NULL,
  cnpj 						CHAR(14)		NOT NULL,
  nome 						VARCHAR(30) 	NOT NULL,						
  site 						VARCHAR(50) 		NULL
);

delimiter //

-- Insere um histórico de empresas cadastradas após serem deletadas
create trigger after_delete_Empresa
after delete on Empresa
for each row
begin 	
    declare usuario varchar(50);
    select user() into usuario;
    
	insert into HistoricoEmpresas (responsavel, data_delecao, cnpj, nome, site)
    values (usuario, sysdate(), old.cnpj, old.nome, old.site);  	
end //

-- Faz a verificação de tipo antes de inserir valor, pois CHECK não funcionou
-- no MySQL.
create trigger before_insert_usuario
before insert on Usuario
for each row
begin
	if (not new.tipo in ('individual', 'familiar', 'estudante')) then
		signal sqlstate '45000' SET message_text = 'Coluna tipo inválida.';
	elseif (not new.email like '%@%.%') then
		signal sqlstate '45000' SET message_text = 'Coluna email inválida.';
    end if;
end //

-- Faz a verificação do telefone antes de inserir valor, pois CHECK não 
-- funcionou no MySQL.
create trigger before_insert_telefone
before insert on Telefones
for each row
begin
	if (not new.telefone like '+% % %-%') then
		signal sqlstate '45000' SET message_text = 'Coluna telefone inválida.';
    end if;
end //

-- Faz a verificação do email antes de inserir valor, pois CHECK não funcionou
-- no MySQL.
create trigger before_insert_email
before insert on Emails
for each row
begin
	if (not new.email like '%@%.%') then
		signal sqlstate '45000' SET message_text = 'Coluna email inválida.';
    end if;
end //

-- Faz a verificação da faixa etária antes de inserir valor, pois CHECK não 
-- funcionou no MySQL.
create trigger before_insert_aplicativo
before insert on Aplicativo
for each row
begin
	if (not new.faixaEtaria in (NULL, 10, 12, 14, 16, 18)) then
		signal sqlstate '45000' SET message_text='Coluna faixaEtaria inválida.';
    end if;
end //

-- Faz a verificação do tipo de licença antes de inserir valor, pois CHECK não 
-- funcionou no MySQL.
create trigger before_insert_adquire_licenca
before insert on AdquireLicenca
for each row
begin
	if (not new.tipo in ('comercial', 'freeware', 'opensource')) then
		signal sqlstate '45000' SET message_text = 'Coluna tipo inválida.';
    end if;
end //

delimiter ;
