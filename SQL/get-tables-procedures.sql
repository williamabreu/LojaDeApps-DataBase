/*
	GCC214 - Banco de Dados - 2017/2
	Loja De Apps
	
	@author Rafael Takehara
	@author Tarik Esmin
	@author	William Abreu
	
	MySQL script contendo todos os storage procedures
    que obtêm todas as linhas de uma dada tabela do 
    banco de dados. Simplificaçãoes do "select * from ..."
*/


use LojaDeApps;

delimiter //


-- Função para listar todo o conteúdo da tabela usuário

create procedure getTableUsuario()
begin
	select * from Usuario;
end //


-- Função para listar todo o conteúdo da tabela empresa

create procedure getTableEmpresa()
begin
	select * from Empresa;
end //


-- Função para listar todo o conteúdo da tabela telefones

create procedure getTableTelefones()
begin
	select * from Telefones;
end //


-- Função para listar todo o conteúdo da tabela emails

create procedure getTableEmails()
begin
	select * from Emails;
end //


-- Função para listar todo o conteúdo da tabela dispositivo

create procedure getTableDispositivo()
begin
	select * from Dispositivo;
end //


-- Função para listar todo o conteúdo da tabela aplicativo

create procedure getTableAplicativo()
begin
	select * from Aplicativo;
end //


-- Função para listar todo o conteúdo da tabela idiomas

create procedure getTableIdiomas()
begin
	select * from Idiomas;
end //


-- Função para listar todo o conteúdo da tabela sistemas

create procedure getTableSistemas()
begin
	select * from Sistemas;
end //


-- Função para listar todo o conteúdo da tabela adquirelicencas

create procedure getTableAdquireLicenca()
begin
	select * from AdquireLicenca;
end //


delimiter ;

