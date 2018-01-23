/*
	GCC214 - Banco de Dados - 2017/2
	Loja De Apps
	
	@author Rafael Takehara
	@author Tarik Esmin
	@author	William Abreu
	
	MySQL script descrevendo dois tipos de usuários e
    suas permissoes/revogações de acesso ao banco de
    banco de dados.
*/





drop user 'desenvolvedor'@'localhost';	
create user 'desenvolvedor'@'localhost' identified by 'dev845';

grant delete, select, insert(nome,tamanho,genero,versao,faixaEtaria, Empresa_login) on LojaDeApps.Aplicativo to 'desenvolvedor'@'localhost';

grant update (nome, genero,tamanho,versao) on LojaDeApps.Aplicativo to 'desenvolvedor'@'localhost';

grant select on LojaDeApps.Sistemas to 'desenvolvedor'@'localhost';

grant select,update,delete on LojaDeApps.AplicativoIdiomas to 'desenvolvedor'@'localhost';

grant select,update,delete on LojaDeApps.AplicativoSistemas to 'desenvolvedor'@'localhost';

grant select on LojaDeApps.EmpresaEmails to 'desenvolvedor'@'localhost';

grant update on LojaDeApps.EmpresaAplicativos to 'desenvolvedor'@'localhost';

revoke delete on LojaDeApps.Aplicativo from 'desenvolvedor'@'localhost';

revoke select on LojaDeApps.EmpresaEmails from 'desenvolvedor'@'localhost';

revoke all on LojaDeApps.AplicativoSistemas from 'desenvolvedor'@'localhost';


drop user 'CEO'@'localhost';	
create user 'CEO'@'localhost' identified by 'CEO@LojadeApps';

grant all on LojaDeApps.Aplicativo to 'CEO'@'localhost';

grant select (tipo, credito), references , create view on LojaDeApps.Usuario to 'CEO'@'localhost' ;

grant select (sistema,versao, modelo, controleParental)  on LojaDeApps.Dispositivo to 'CEO'@'localhost';

grant insert, update, alter, create view, trigger on LojaDeApps.Empresa to 'CEO'@'localhost';

grant insert, delete on LojaDeApps.Emails to 'CEO'@'localhost';

grant insert, update, delete on LojaDeApps.EmpresaTelefones to 'CEO'@'localhost';

revoke all on LojaDeApps.Aplicativo from 'CEO'@'localhost';

revoke delete, insert on LojaDeApps.EmpresaTelefones from 'CEO'@'localhost';
 
revoke select(credito) on LojaDeApps.Usuario from 'CEO'@'localhost';

