/*
	GCC214 - Banco de Dados - 2017/2
	Loja De Apps
	
	@author Rafael Takehara
	@author Tarik Esmin
	@author	William Abreu
	
	MySQL script com storage procedures
    que fazem modificações em tabelas
    do banco de dados.
*/


use LojaDeApps;

delimiter //


create procedure setUsuarioEmail(in loginRef varchar(50), in novoEmail varchar(50))
begin
	update Usuario
    set email = novoEmail
    where login = loginRef;
end //


create procedure setUsuarioSenha(in loginRef varchar(50), in novaSenha varchar(32))
begin
	update Usuario
    set senha = novaSenha
    where login = loginRef;
end //


create procedure setUsuarioNome(in loginRef varchar(50), novoNome varchar(30))
begin
	update Usuario
    set nome = novoNome
    where login = loginRef;
end //


create procedure setUsuarioTipo(in loginRef varchar(50), in novoTipo varchar(10))
begin
	update Usuario
    set tipo = novoTipo
    where login = loginRef;
end //


create procedure setUsuarioCredito(in loginRef varchar(50), in novoCredito float)
begin
	update Usuario
    set credito = novocredito
    where login = loginRef;
end //


create procedure setUsuarioDataNasce(in loginRef varchar(50), in novaData date)
begin
	update Usuario
    set dataNasce = novaData
    where login = loginRef;
end //


delimiter ;


