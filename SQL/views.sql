/*
	GCC214 - Banco de Dados - 2017/2
	Loja De Apps
	
	@author Rafael Takehara
	@author Tarik Esmin
	@author	William Abreu
	
	Views do banco de dados.
*/

use LojaDeApps;


-- Mostra a empresa e seus emails

create view EmpresaEmails as
	select nome, email
    from Empresa, Emails
    where login = Empresa_login
    order by nome asc;


-- Mostra a empresa e seus telefones

create view EmpresaTelefones as
	select nome, telefone
    from Empresa, Telefones
    where login = Empresa_login
    order by nome asc;


-- Mostra o aplicativo e seus idiomas

create view AplicativoIdiomas as
	select Aplicativo.nome app, Empresa.nome dev, Idiomas.idioma idioma
    from Aplicativo, Empresa, Idiomas
    where nroRegistro = Aplicativo_nroRegistro and
		  login = Empresa_login
	order by app asc;


-- Mostra o aplicativo e seus sistemas

create view AplicativoSistemas as
	select Aplicativo.nome app, Empresa.nome dev, Sistemas.sistema so
    from Aplicativo, Empresa, Sistemas
    where nroRegistro = Aplicativo_nroRegistro and
		  login = Empresa_login
	order by app asc;


-- Mostra a empresa e os aplicativos que ela criou

create view EmpresaAplicativos as
	select Empresa.nome dev, Aplicativo.nome app
    from Empresa, Aplicativo
    where login = Empresa_login
    order by dev asc;


-- Mostra o usuário e os dispositivos que possui

create view UsuarioDispositivos as
	select login usuario, identificador dispositivo
    from Usuario, Dispositivo
    where login = Usuario_login
    order by login asc;


-- Mostra o usuário e os aplicativos que baixou (adquiriu licença)

create view UsuariosAplicativos as
	select Usuario.login usuario, Aplicativo.nome app, Empresa.nome dev
    from Usuario, AdquireLicenca, Aplicativo, Empresa
    where Usuario_login = Usuario.login and
		  Aplicativo_nroRegistro = nroRegistro and
          Empresa_login = Empresa.login
	order by usuario asc;






