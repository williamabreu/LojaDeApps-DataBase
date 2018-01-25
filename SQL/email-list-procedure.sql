use LojaDeApps;


-- Procedure cria uma lista de emails de todos os usarios cadastrados, separando-os por ;

DELIMITER // 
create procedure ObtemListaEmailUsuario(inout listaEmail varchar(10000))
BEGIN

  declare done int default false;

  declare emailUser varchar(5000) default "";

  declare obtemEmail cursor for 	
	select  U.email
	from Usuario U
	group by U.login;

  declare continue handler for not found set done = true;

  OPEN obtemEmail;

  get_email: loop
    fetch obtemEmail INTO emailUser;
    
	if done then
      leave get_email;
    end if;
    
   set listaEmail = concat(emailUser,';', listaEmail);
   
   end loop;
   
  close obtemEmail;
 
END // 
DELIMITER ; 

SET @listaEmailUsuarios = '';
CALL ObtemListaEmailUsuario(@listaEmailUsuarios);
SELECT @listaEmailUsuarios;

drop procedure ObtemListaEmailUsuario;


