use LojaDeApps;

delimiter $$

-- procedure que obtem a media de downlaods de todos os app cadastrados na loja
create procedure ObtemMediaDownloads(out media decimal(10,3))
begin
	declare somaDownloads float;
    declare totalApps int;
    
	select sum(downloads) into somaDownloads
	from Aplicativo
    order by nome asc;

	select count(*) into totalApps
    from Aplicativo;
	
    
    set media = somaDownloads/totalApps;
  end $$

delimiter ;

set @mediaDownloads = null;
call ObtemMediaDownloads(@mediaDownloads);
select @mediaDownloads;

drop procedure ObtemMediaDownloads;

