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

drop procedure if exists sp_remover_prova;
delimiter //
create procedure sp_remover_prova(
	in provId int
)
begin	
	delete from prova
    where prov_id = provId;
end //
delimiter ;

drop procedure if exists sp_adicionar_classificacao_prova;
delimiter $$
create procedure sp_adicionar_classificacao_prova(
	in classificao int,
    in parId int,
    in provId int,
    in pontuacao float
)
begin
	insert into resultados(res_classificacao, res_atlet_par_id, res_prov_id, res_pontuacao)
    values(classificao, parId, provId, pontuacao);
end $$
delimiter ;

drop procedure if exists sp_clonar_prova;
delimiter $$
create procedure sp_clonar_prova(
	in provId int
)
begin
	select *, 'Cópia' from vProvas
    where IDProva = provId;
end $$
delimiter ;

call sp_clonar_prova(2);