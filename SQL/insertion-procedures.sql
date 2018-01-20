/*
	MySQL script com todos os storage procedures
    que fazem a inserção de linhas em todas as
    tabelas do banco de dados.
*/

use LojaDeApps;

delimiter //


-- Função para inserir um novo usuário

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
	insert into Usuario values (login, email, MD5(senha), nome, tipo, credito, dataNasce);
end //


-- Função para inserir uma nova empresa

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
	insert into Empresa values (login, cnpj, senha, nome, logradouro, numero, bairro, cidade, pais, site);
end //


-- Função para inserir novo telefone

create procedure insertTelefone(in telefone varchar(20), empresaLogin varchar(50))
begin
	insert into Telefones values (telefone, empresaLogin);
end //


-- Função para inserir novo e-mail

create procedure insertEmail(in email varchar(50), empresaLogin varchar(50))
begin
	insert into Emails values (email, empresaLogin);
end //


-- Função para inserir novo dispositivo

create procedure insertDispositivo(
	in identificador varchar(15),
    in usuarioLogin varchar(50),
    in sistema varchar(20),
    in modelo varchar(10),
    in certificado bool,
    in controleParental int,
    in updateDisp bool,
    in notificacao bool
)
begin
	insert into Dispositivo values (identificador, usuarioLogin, sistema, modelo, certificado, controleParental, updateDisp, notificacao);
end //


-- Função para inserir novo aplicativo

create procedure insertAplicativo(
	in nroRegistro int,
	in empresaLogin varchar(50),
	in nome varchar(20),
	in tamanho int,
	in genero varchar(10),
	in versao varchar(20),
	in faixaEtaria int,
	in downloads int,
	in nota float
)
begin
	insert into Aplicativo values (nroRegistro, empresaLogin, nome, tamanho, genero, versao, faixaEtaria, downloads, nota);
end //


-- Função para inserir novo idioma

create procedure insertIdioma(in idioma varchar(20), aplicativoNroRegistro int)
begin
	insert into Idiomas values (idioma, aplicativoNroRegistro);
end //


-- Função para inserir novo sistema

create procedure insertSistema(in sistema varchar(20), aplicativoNroRegistro int)
begin
	insert into Sistemas values (sistema, aplicativoNroRegistro);
end //


-- Função para inserir nova licença

create procedure insertLicenca(in registro int, in aplicativoNroRegistro int, in tipo varchar(20), in preco float)
begin
	insert into Licenca values (registro, aplicativoNroRegistro, tipo, preco);
end //


-- Função para inserir nova transação de adquirir licença

create procedure insertAdquire(in licencaRegistro int, in usuarioLogin varchar(50), in metodoPagamento varchar(10))
begin
	insert into Adquire values (licencaRegistro, usuarioLogin, metodoPagamento);
end //



delimiter ;


