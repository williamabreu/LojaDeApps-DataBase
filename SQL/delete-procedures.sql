/*
	GCC214 - Banco de Dados - 2017/2
	Loja De Apps
	
	@author Rafael Takehara
	@author Tarik Esmin
	@author	William Abreu
	
	MySQL script com exemplos de 
    storage procedures e deletes
    que fazem exclusões de linhas em 
    tabelas do banco de dados.
*/


use LojaDeApps;

delimiter //

create procedure deleteUsuario(in login varchar(50))
begin
	delete from Usuario where Usuario.login = login;
end //

delimiter ;

-- deleta licencasEmpresa de aplicativos com menos de 5 downloads
delete from AdquireLicenca
where Aplicativo_nroRegistro not in (select nroRegistro
					from Aplicativo
                    group by nroRegistro
                    having sum(downloads) >= 5);
	
-- procedimento encarregado de deletar log de empresas a partir do login e senha                    
delimiter //
create procedure deletaEmpresa(in login varchar(50), in senha varchar(32))
begin
	delete from Empresa where Empresa.login = login and Empresa.senha = senha;
end //
delimiter ;

-- Deleta usuarios com creditos negativos e idade menor que 18 anos
delete from Usuario
where Usuario.credito < 0 and (datediff(curdate(), Usuario.dataNasce)/365.25) < 18;

/* deleta dispostivos sem certificados ou dispositvos sem atualização 
em que os donos tem menos de 20 creditos */
delete from Dispositivo 
where Dispositivo.certificado  = false or Dispositivo.updateDisp = false 
and Usuario_login not in( select login
							from Usuario
							where credito > 20);
                    
