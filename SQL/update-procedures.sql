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



create procedure setNotaMaiorPreco(in notaref float)
begin

	update Aplicativo
	set nota = notaref
	where nota is null and nroRegistro in (select Aplicativo_nroRegistro from AdquireLicenca			
										   where preco >= all ( select preco from AdquireLicenca
															 where preco is not null));
end // 


create procedure setVersaoSistema(in versaoNova varchar(20), in sistemaDesejado varchar(20)) 
begin
	
    update Dispositivo
	set versao = versaoNova
    where sistema = sistemaDesajado;
end //


update Dispositivo
set controleParental = false
where  Usuario_login in (select login from Usuario where (datediff(curdate(), Usuario.dataNasce)/365.25) >= 18);

update Empresa
set nome = concat(nome,' ', pais)
where Empresa.login in (select Empresa_login from Aplicativo group by Empresa_login having count(*) > 2);

update AdquireLicenca
set preco = preco*1.10
where Aplicativo_nroRegistro in (select nroRegistro from Aplicativo
							where downloads > 5);


call setNotaMaiorPreco(3.5); 

                            
select *
from Empresa;
                            											
delimiter ;


