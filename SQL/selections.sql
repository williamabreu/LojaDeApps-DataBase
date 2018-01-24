use LojaApps;

select email from Usuario where nome = 'Ricardo Planeta';

select nome from Empresa where pais= 'Brasil' OR 'USA' order by nome desc;

select telefone from Empresa natural join Telefones where site  or bairro  is null;

select nroRegistro, nome from Aplicativo where downloads not between 0 and 5;

select login
from Usuario where nome like 'A% %';

select identificador
from Dispositivo where  Usuario_login  in  ( select login  from Usuario where credito  <= 120);
																																	
select cnpj
from Empresa where exists ( select * from Aplicativo);

select nroRegistro and nome from Aplicativo where nota between 4 and 5;

select  distinct nome 
from AdquireLicenca L join Aplicativo A on L.Aplicativo_nroRegistro = A.nroRegistro
where (L.preco  = 0) or (L.preco is null) ;

select E.nome
from Empresa E join Telefones T on E.login = T.Empresa_login
group by E.nome
having count(telefone)  > 2; 

select nome
from Aplicativo
where nroRegistro in (select Aplicativo_nroRegistro
					 from AdquireLicenca where preco > 100 and metodoPag = 'bitcoin')
Union
select A.nome 
from Aplicativo A, AdquireLicenca L, Usuario U
where A.nroRegistro  = L.Aplicativo_nroRegistro  and L.Usuario_login = U.login
and U.credito > 400;                
			
select sum(downloads)
from Empresa E join Aplicativo A on E.login = A.Empresa_login
where E.nome = 'Microsoft';

select  A.nome, downloads, genero
from Empresa E join Aplicativo A on E.login = A.Empresa_login
where E.nome = 'Microsoft'  and A.downloads > any ( select A.downloads from Empresa E join Aplicativo A on E.login = A.Empresa_login
												   where E.nome = 'Google' or E.nome= 'Pcenter Informática');
							
select  nome, email, credito
from Usuario
where credito >= all (select preco from AdquireLicenca where preco is not null);

select  U.nome,count(*) as nroAplicativosAdquiridos 
from Usuario U, Aplicativo A, AdquireLicenca L
where U.login = L.Usuario_login and A.nroRegistro  = L.Aplicativo_nroRegistro
group by U.nome;

