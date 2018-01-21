/*
	GCC214 - Banco de Dados - 2017/2
	Loja De Apps
	
	@author Rafael Takehara
	@author Tarik Esmin
	@author	William Abreu
	
	Triggers do banco de dados.
*/


use LojaDeApps;

delimiter //


create trigger after_insert_adquirelicenca
after insert on AdquireLicenca
for each row
begin
	-- ???
end //






delimiter ;


