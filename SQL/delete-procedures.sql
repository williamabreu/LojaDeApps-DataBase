/*
	GCC214 - Banco de Dados - 2017/2
	Loja De Apps
	
	@author Rafael Takehara
	@author Tarik Esmin
	@author	William Abreu
	
	MySQL script com storage procedures
    que fazem exclusões de linhas em 
    tabelas do banco de dados.
*/


use LojaDeApps;

delimiter //


create procedure deleteUsuario(in login varchar(50))
begin
	delete from Usuario where Usuario.login = login;
end //