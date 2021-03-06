/*
	GCC214 - Banco de Dados - 2017/2
	Loja De Apps
	
	@author Rafael Takehara
	@author Tarik Esmin
	@author	William Abreu
	
	Triggers do banco de dados.
*/


use LojaDeApps;

drop trigger after_insert_adquireLicenca;
-- Incrementa o número de downloads de forma automatica após adquirir a licensa do app
delimiter //
create trigger after_insert_adquireLicenca
after insert on AdquireLicenca
for each row
begin
	
	update Aplicativo 
	set downloads = downloads + 1
	where nroRegistro = appNroRegistro;
    
end //
delimiter ;


drop trigger update_login_Usuario;
-- Atualiza o login do usuario, modificada na tabela Usuario, em outras tabelas
delimiter //
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
		signal sqlstate '45000' SET message_text = 'Login  muito curto, insira um login com pelo menos 3 caracteres! ';
	end if;
end //
delimiter ;
                        
CREATE TABLE HistoricoEmpresas
( 
  responsavel               VARCHAR(50)    NOT NULL,
  data_delecao               date			NOT NULL,
  cnpj 						CHAR(14)		NOT NULL,
  nome 						VARCHAR(30) 	NOT NULL,						
  site 						VARCHAR(50) 		NULL
);

drop table HistoricoEmpresas;

drop trigger after_delete_Empresa;
-- Insere um historico de empresas cadastradas após serem deletadas
delimiter //
create trigger after_delete_Empresa
after delete on Empresa
for each row
begin 
	
    declare usuario varchar(50);
    select user() into usuario;
    
	insert into HistoricoEmpresas (responsavel, data_delecao, cnpj, nome, site)
    values (usuario, sysdate(), old.cnpj, old.nome, old.site);
  	
end //
delimiter ;

delimiter //

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


create trigger before_insert_telefone
before insert on Telefone
for each row
begin
	if (not new.telefone like '+% % %-%') then
		signal sqlstate '45000' SET message_text = 'Coluna telefone inválida.';
    end if;
end //


create trigger before_insert_email
before insert on Emails
for each row
begin
	if (not new.email like '%@%.%') then
		signal sqlstate '45000' SET message_text = 'Coluna email inválida.';
    end if;
end //


create trigger before_insert_aplicativo
before insert on Aplicativo
for each row
begin
	if (not new.faixaEtaria in (NULL, 10, 12, 14, 16, 18)) then
		signal sqlstate '45000' SET message_text = 'Coluna faixaEtaria inválida.';
    end if;
end //


create trigger before_insert_adquire_licenca
before insert on AdquireLicenca
for each row
begin
	if (not new.tipo in ('comercial', 'freeware', 'opensource')) then
		signal sqlstate '45000' SET message_text = 'Coluna tipo inválida.';
    end if;
end //



delimiter ;











