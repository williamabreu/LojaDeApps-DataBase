use LojaDeApps;

/*insertUsuario(login, email, senha, nome, tipo, credito, dataNasce);*/
call insertUsuario('william', 'william@ufla.br', 'senha-william', 'William Abreu', 'individual', 10.00, '1987-05-26');
call insertUsuario('tarik', 'tarik@ufla.br', 'senha-tarik', 'Tarik Esmin', 'familiar', 470.00, '1992-08-04');
call insertUsuario('take', 'take@ufla.br', 'senha-take', 'Rafael Takehara', 'estudante', 0.00, '2002-12-26');
call insertUsuario('denis', 'denis@ufla.br', 'senha-denis', 'Denis Floriano', 'individual', 0.00, '1999-10-06');
call insertUsuario('denis', 'denis@ufla.br', 'senha-denis', 'Denis Floriano', 'individual', 0.00, '1999-10-06');

call getUsuarios();

delete from Usuario where login = 'take';

drop schema LojaDeApps;