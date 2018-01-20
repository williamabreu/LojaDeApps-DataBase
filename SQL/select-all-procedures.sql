/*
	MySQL script contendo todos os storage procedures
    que obtêm todas as linhas de uma dada tabela do 
    banco de dados. 
    (Simplificaçãoes do "select * from ...")
*/

use LojaDeApps;

delimiter //


-- Função para listar todo o conteúdo da tabela usuário

create procedure getUsuarios()
begin
	select * from Usuario;
end //


-- Função para listar todo o conteúdo da tabela empresa

create procedure getEmpresas()
begin
	select * from Empresa;
end //


-- Função para listar todo o conteúdo da tabela telefones

create procedure getTelefones()
begin
	select * from Telefones;
end //


-- Função para listar todo o conteúdo da tabela emails

create procedure getEmails()
begin
	select * from Emails;
end //


-- Função para listar todo o conteúdo da tabela dispositivo

create procedure getDispositivos()
begin
	select * from Dispositivo;
end //



-- Função para listar todo o conteúdo da tabela aplicativo

create procedure getAplicativos()
begin
	select * from Aplicativo;
end //

-- Função para listar todo o conteúdo da tabela idiomas

create procedure getIdiomas()
begin
	select * from Idiomas;
end //


-- Função para listar todo o conteúdo da tabela sistemas

create procedure getSistemas()
begin
	select * from Sistemas;
end //


-- Função para listar todo o conteúdo da tabela licenca

create procedure getLicencas()
begin
	select * from Licenca;
end //


-- Função para listar todo o conteúdo da tabela adquire

create procedure getAdquires()
begin
	select * from Adquire;
end //




delimiter ;
