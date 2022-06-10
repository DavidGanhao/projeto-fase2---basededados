-- SP1 (número identificador do stored procedure)
-- cria uma nova prova num evento determinado, enviando todos os dados necessários à definição da mesma.
drop procedure if exists sp_criar_prova;
delimiter $$
create procedure sp_criar_prova(
	in localiz varchar(10),
    in provDate date,
    in provDuracao varchar(30),
    in evenCode int,
    in modCode int,
    in fregCod int,
    in concCod int,
    in distCod int
)
begin
	insert into prova(prov_localizacao, prov_data, prov_duracao, prov_even_code, prov_mod_code
    , prov_freg_codigo, prov_conc_codigo, prov_conc_dist_codigo)
    values(localiz, provDate, provDuracao, evenCode, modCode, fregCode, concCod, distCod);
end $$
delimiter ;

-- nao esta acabado
drop procedure if exists sp_remover_prova;
delimiter //
create procedure sp_remover_prova(
	in localiz varchar(10),
    in provDate date,
    in provDuracao varchar(30),
    in evenCode int,
    in modCode int,
    in fregCod int,
    in concCod int,
    in distCod int
)
begin	
	delete from prova
    where prov_localizacao=localiz and
	prov_data=provDate and
    prov_duracao=provDuracao and
    prov_even_code=evenCode and
    prov_mod_code=modCode and
    prov_freg_codigo=fregCod and
    prov_conc_codigo=concCod and
    prov_conc_dist_codigo=distCod;
end //
delimiter ;