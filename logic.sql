-- FUNCTIONS

drop function if exists func_getMedalha;
delimiter $$
create function func_getMedalha(
	classificao int)
returns varchar(100)
deterministic
begin
	if(classificao = 1)
    then
		return 'Ouro';
	end if;
    if(classificao = 2)
    then
		return 'Prata';
	end if;
    if(classificao = 3)
    then
		return 'Bronze';
	end if;
    return 'Nenhuma medalha';
end $$
delimiter ;

drop function if exists func_getIdade;
delimiter $$
create function func_getIdade(
	datednsc date
)
returns int
deterministic
begin
	return timestampdiff(year, datednsc, curdate());
end $$
delimiter ;

-- VIEWS

drop view if exists vCompras;
create view vCompras as
select comp_ip as 'IP', comp_preco as 'Preço', comp_datadecompra as 'Data da compra',
 comp_prod_nome as 'Produto', comp_serv_fornecedor as 'Fornecedor', comp_aloj_morada as 'Morada'
from compra;
drop view if exists vParticipante;
create view vParticipante as
select par_id as 'ID', par_nome as 'Nome Completo', par_sexo as 'Sexo',par_dnsc as 'Data de Nascimento',
timestampdiff(year, par_dnsc, curdate()) as 'Idade',
par_aloj_morada as 'Alojamento' from participante;

drop view if exists vTBLLogs;
create view vTBLLogs as
select logs_id as 'IDLogs', logs_date_oper as 'Data da operação',
logs_par_id as 'IDParticipante', logs_prov_id as 'IDProva', logs_old_pontuacao as 'Pontuação alterada'
, logs_new_pontuacao as 'Pontuação adicionada', logs_classificacao as 'Classificação' from tbl_logs;

drop view if exists vAlojamento;
create view vAlojamento as
select aloj_morada as 'Morada', aloj_localizacao as 'Localização', aloj_area as 'Área', aloj_tipol_tipologia as 'Tipologia', aloj_freg_codigo as 'Freguesia',
aloj_conc_codigo as 'Concelho', aloj_conc_dist_codigo as 'Distrito' from alojamento;

drop view if exists vProvas;
create view vProvas as
select prov_id as 'IDProva', prov_localizacao as 'Localização', prov_duracao as 'Duração da prova', prov_data as 'Data da prova', prov_even_code as 'Evento'
, mod_nome as 'Modalidade', prov_freg_codigo as 'Freguesia', prov_conc_codigo as 'Concelho', prov_conc_dist_codigo as 'Distrito'  from prova
join modalidade on prov_mod_code = mod_code;

drop view if exists vAtletaInformacao;
create view vAtletaInformacao as
select par_id as 'ID', par_nome as 'Nome Completo', par_sexo as 'Sexo',
atlet_peso as 'Peso',atlet_altura as 'Altura',par_dnsc as 'Data de Nascimento',
timestampdiff(year, par_dnsc, curdate()) as 'Idade',
par_aloj_morada as 'Alojamento' from participante join atleta on par_id = atlet_par_id;

drop view if exists vTreinadorInformacao;
create view vTreinadorInformacao as
select par_id as 'ID', par_nome as 'Nome Completo',
trein_cert_certificado as 'Certificado', par_sexo as 'Sexo',par_dnsc as 'Data de Nascimento',
timestampdiff(year, par_dnsc, curdate()) as 'Idade',
par_aloj_morada as 'Alojamento' from participante join treinador on par_id = trein_par_id;

drop view if exists vResultadosOrdenado;
create view vResultadosOrdenado as
select func_getMedalha(res_classificacao) as 'Medalha', res_pontuacao as 'Pontuação',res_atlet_par_id as 'IDAtleta',
 res_classificacao as 'Lugar', res_prov_id 'IDProva' from resultados
 order by res_prov_id, res_classificacao;

drop view if exists vMoradaCaracteristicas;
create view vMoradaCaracteristicas as
select aloj_morada as 'Morada', aloj_tipol_tipologia as 'Tipologia', carac_caracteristica as 'Característica'
from alojamento join caracteristicasaloj on caracaloj_aloj_morada = aloj_morada
join características on caracaloj_carac_code = carac_code;

drop view if exists vMoradaProdutos;
create view vMoradaProdutos as
select aloj_morada as 'Morada', comp_prod_nome as 'Produto', 
comp_preco as 'Preço', comp_serv_fornecedor as 'Fornecedor'
from alojamento join compra on comp_aloj_morada = aloj_morada;

drop view if exists vEquipaInformacao;
create view vEquipaInformacao as
select equip_sigla as 'Sigla', equip_nome as 'Nome da Equipa', even_nome as 'Participa no Evento'
from equipa 
join equipaevento on eqev_equip_sigla = equip_sigla
join evento on eqev_even_code = even_code;

drop view if exists vProvaModalidade;
create view vProvaModalidade as
select prov_id as 'ID Prova', prov_data as 'Data da prova', mod_nome as 'Modalidade'
from prova
join modalidade on mod_code = prov_mod_code;

drop view if exists vEventos;
create view vEventos as
select org_nome as 'Organizador', even_nome as 'Nome do Evento', even_descricao as 'Descrição do evento',
even_perinicio as 'Ínicio', even_perfim as 'Fim', timestampdiff(day, even_perinicio, even_perfim) as 'Período em dias', even_morada as 'Local'
from evento
join organizador on even_org_nome = org_nome;

drop view if exists vEquipaParticipante;
create view vEquipaParticipante as
select par_id as 'ID', par_nome as 'Nome Completo', par_dnsc as 'Data de nascimento',func_getIdade(par_dnsc) as 'Idade',equip_sigla as 'Sigla', equip_nome as 'Nome da equipa'
from equipa
join participanteequipa on parequip_equip_sigla = equip_sigla
join participante on parequip_par_id = par_id;

drop view if exists vNaoParticiparam;
create view vNaoParticiparam as
select par_id as 'ID',par_nome as 'Nome Completo',par_sexo as 'Sexo',
par_dnsc as 'Data de Nascimento',func_getIdade(par_dnsc) as 'Idade',
ifnull(par_aloj_morada, '(Sem Alojamento)') as 'Morada' from resultados
right join atleta on res_atlet_par_id = atlet_par_id
join participante on atlet_par_id = par_id
where res_prov_id is null;

drop view if exists vCalculoAreaAlojamento;
create view vCalculoAreaAlojamento as
select aloj_tipol_tipologia as 'Tipologia', avg(aloj_area) 'Média de área',
max(aloj_area) 'Área máxima', min(aloj_area) 'Área mínima', stddev(aloj_area) 'Desvio Padrão'
 from alojamento
 group by aloj_tipol_tipologia;

drop view if exists vCalculoIdadePorEvento;
create view vCalculoIdadePorEvento as
select eqev_even_code as 'Evento', avg(Idade) as 'Média de idade', max(Idade) as 'Idade máxima', min(Idade) as 'Idade mínima', stddev(Idade) as 'Desvio Padrão' from vEquipaParticipante
join equipaevento on eqev_equip_sigla = Sigla
group by eqev_even_code;

drop view if exists vCalculoAlturaPorEvento;
create view vCalculoAlturaPorEvento as
select eqev_even_code as 'Evento', avg(Altura) as 'Média de altura', max(Altura) as 'Altura máxima', min(Altura) as 'Altura mínima', stddev(Altura) as 'Desvio padrão' from vAtletaInformacao
join participanteequipa on ID = parequip_par_id
join equipaevento on parequip_equip_sigla = eqev_equip_sigla
group by eqev_even_code;

drop view if exists vCalculoPesoPorEvento;
create view vCalculoPesoPorEvento as
select eqev_even_code as 'Evento', avg(Peso) as 'Média de peso', max(Peso) as 'Peso máximo', min(Peso) as 'Peso mínimo', stddev(Peso) as 'Desvio padrão' from vAtletaInformacao
join participanteequipa on ID = parequip_par_id
join equipaevento on parequip_equip_sigla = eqev_equip_sigla
group by eqev_even_code;

drop view if exists vCalculoPesoPorProva;
create view vCalculoPesoPorProva as
select res_prov_id as 'Prova', avg(atlet_peso) as 'Média do peso',max(atlet_peso) as 'Peso máximo', min(atlet_peso) as 'Peso mínimo', stddev(atlet_peso) as 'Desvio padrão' from resultados
join atleta on res_atlet_par_id = atlet_par_id
group by res_prov_id;

drop view if exists vCalculoAlturaPorProva;
create view vCalculoAlturaPorProva as
select res_prov_id as 'Prova', avg(atlet_altura) as 'Média da altura',max(atlet_altura) as 'Altura máxima', min(atlet_altura) as 'Altura mínima', stddev(atlet_altura) as 'Desvio padrão' from resultados
join atleta on res_atlet_par_id = atlet_par_id
group by res_prov_id;

drop view if exists vCalculoPontuacaoPorProva;
create view vCalculoPontuacaoPorProva as
select res_prov_id as 'Prova', avg(res_pontuacao) as 'Média de pontuação', max(res_pontuacao) as 'Pontuação máxima', min(res_pontuacao) as 'Pontuação mínima', stddev(res_pontuacao) as 'Desvio padrão'
 from resultados
 group by res_prov_id;

drop view if exists vParticipanteNumMedalhas;
create view vParticipanteNumMedalhas as
select par_id as 'ID',par_nome as 'Nome Completo', atlet_peso as 'Peso'
, atlet_altura as 'Altura', func_getIdade(par_dnsc) as 'Idade',
res_classificacao as 'Classificação', res_prov_id as 'ID Prova',
count(*) 'Nº Medalhas'
from resultados
join atleta on atlet_par_id = res_atlet_par_id
join participante on atlet_par_id = par_id
where res_classificacao <= 3
group by par_id;

-- PROCEDURES

drop procedure if exists sp_criar_caracteristica;
delimiter $$
create procedure sp_criar_caracteristica(
	in caracteristica varchar(30)
)
begin
	insert into características(carac_caracteristica) value(caracteristica);
end $$
delimiter ;

drop procedure if exists sp_criar_participante;
delimiter $$
create procedure sp_criar_participante(
	in sexo char,
    in nome varchar(50),
    in dataNascimento date
)
begin
	insert into participante(par_sexo, par_nome, par_dnsc) values(sexo, nome, dataNascimento);
end $$
delimiter ;

drop procedure if exists sp_alojar_participante;
delimiter $$
create procedure sp_alojar_participante(
	in id int,
    in morada varchar(50)
)
begin
	update participante
    set par_aloj_morada = morada
    where par_id = id;
end $$
delimiter ;

drop procedure if exists sp_criar_evento;
delimiter $$
create procedure sp_criar_evento(
	in descricao varchar(100),
    in inicio date,
    in fim date,
    in nome varchar(40),
    in localNome varchar(50),
    in organizador varchar(50)
)
begin
	insert into evento(even_descricao, even_perinicio, even_perfim, even_nome, even_morada, even_org_nome)
    values(descricao, inicio, fim, nome, localNome, organizador);
end $$
delimiter ;

drop procedure if exists sp_adicionar_equipa_evento;
delimiter $$
create procedure sp_adicionar_equipa_evento(
	in evenCode int,
    in equipSigla varchar(5)
)
begin
	insert into equipaevento(eqev_equip_sigla, eqev_even_code)
    values(equipSigla, evenCode);
end $$
delimiter ;

drop procedure if exists sp_definir_atleta;
delimiter $$
create procedure sp_definir_atleta(
	in parId int,
    in peso int,
    in altura float
)
begin
	insert into atleta(atlet_par_id, atlet_peso, atlet_altura)
    values(parId, peso, altura);
end $$
delimiter ;

drop procedure if exists sp_definir_treinador;
delimiter $$
create procedure sp_definir_treinador(
	in parId int,
    in certificado varchar(30)
)
begin
	insert into treinador(trein_par_id, trein_cert_certificado)
    values(parId, certificado);
end $$
delimiter ;

drop procedure if exists sp_criar_produto;
delimiter $$
create procedure sp_criar_produto(
	in prodNome varchar(30)
)
begin
	insert into produto value(prodNome);
end $$
delimiter ;

drop procedure if exists sp_adicionar_modalidade;
delimiter $$
create procedure sp_adicionar_modalidade(
	in modalid varchar(40)
)
begin
	insert into modalidade(mod_nome) value(modalid);
end $$
delimiter ;

drop procedure if exists sp_adicionar_alojamento;
delimiter $$
create procedure sp_adicionar_alojamento(
	in morada varchar(50),
    in localiz varchar(10),
    in area int,
    in tipol varchar(2),
    in fregCod int,
    in concCod int,
    in distCod int
)
begin
	insert into alojamento(aloj_morada, aloj_localizacao, aloj_area, aloj_tipol_tipologia, aloj_freg_codigo,
    aloj_conc_codigo, aloj_conc_dist_codigo)
    values(morada, localiz, area, tipol, fregCod, concCod, distCod);
end $$
delimiter ;

drop procedure if exists sp_efetuar_compra;
delimiter $$
create procedure sp_efetuar_compra(
	in preco int,
    in prodNome varchar(30),
    in fornecedor varchar(20),
    in morada varchar(50)
)
begin
	insert into compra(comp_preco, comp_datadecompra, comp_prod_nome, comp_serv_fornecedor, comp_aloj_morada)
    values(preco, curdate(), prodNome, fornecedor, morada);
end $$
delimiter ;

drop procedure if exists sp_mostrar_resultados_atleta;
delimiter $$
create procedure sp_mostrar_resultados_atleta(
	in parId int
)
begin
	select par_id as 'ID',par_nome as 'Nome Completo', atlet_peso as 'Peso'
    , atlet_altura as 'Altura', func_getIdade(par_dnsc) as 'Idade',
    res_classificacao as 'Classificação', res_prov_id as 'ID Prova', func_getMedalha(res_classificacao) as 'Medalha'
    from resultados
    join atleta on atlet_par_id = res_atlet_par_id
    join participante on atlet_par_id = par_id
    where par_id = parId;
end $$
delimiter ;

drop procedure if exists sp_mostrar_medalhas_atleta;
delimiter $$
create procedure sp_mostrar_medalhas_atleta(
	in parId int
)
begin
	select par_id as 'ID',par_nome as 'Nome Completo', atlet_peso as 'Peso'
    , atlet_altura as 'Altura', func_getIdade(par_dnsc) as 'Idade',
    res_classificacao as 'Classificação', res_prov_id as 'ID Prova', func_getMedalha(res_classificacao) as 'Medalha',
    count(*) 'Nº Medalhas'
    from resultados
    join atleta on atlet_par_id = res_atlet_par_id
    join participante on atlet_par_id = par_id
    where par_id = parId
    group by func_getMedalha(res_classificacao);
end $$
delimiter ;

drop procedure if exists sp_mostrar_valor_gasto_alojamento;
delimiter $$
create procedure sp_mostrar_valor_gasto_alojamento(
	in alojMorada varchar(50)
)
begin 
	select comp_aloj_morada as 'Morada', sum(comp_preco) as 'Soma de todos os produtos' 
	from compra
	where comp_aloj_morada = alojMorada;
end $$
delimiter ;

drop procedure if exists sp_mostrar_aloj_equipa;
delimiter $$
create procedure sp_mostrar_aloj_equipa(
	in equipSigla varchar(5)
)
begin
select Morada, Localização, Área, Tipologia, Freguesia, Concelho, Distrito, par_nome as 'Nome', parequip_equip_sigla as 'Equipa' from vAlojamento
	join participante on par_aloj_morada = Morada
	join participanteequipa on par_id = parequip_par_id
    where equipSigla = parequip_equip_sigla;
end $$
delimiter ;



-- TRIGGERS

drop trigger if exists verificar_sexo;
delimiter $$
create trigger verificar_sexo
before insert on participante
for each row
begin
	if(NEW.par_sexo not like 'M' and NEW.par_sexo not like 'F')
    then
		set NEW.par_sexo = 'M';
    end if;
end $$
delimiter ;

drop trigger if exists verificar_sexo_update;
delimiter $$
create trigger verificar_sexo_update
before update on participante
for each row
begin
	if(NEW.par_sexo not like 'M' and NEW.par_sexo not like 'F')
    then
		set NEW.par_sexo = OLD.par_sexo;
    end if;
end $$
delimiter ;

drop trigger if exists verificar_preco;
delimiter $$
create trigger verificar_preco
before insert on compra
for each row
begin
	if(NEW.comp_preco < 0)
    then
		set NEW.comp_preco = 100;
    end if;
end $$
delimiter ;

drop trigger if exists verificar_preco_update;
delimiter $$
create trigger verificar_preco_update
before update on compra
for each row
begin
	if(NEW.comp_preco < 0)
    then
		set NEW.comp_preco = OLD.comp_preco;
    end if;
end $$
delimiter ;

drop trigger if exists verificar_peso_altura;
delimiter $$
create trigger verificar_peso_altura
before insert on atleta
for each row
begin
	if(NEW.atlet_peso < 0)
    then
		set NEW.atlet_peso = 0;
    end if;
    if(NEW.atlet_altura < 0)
    then
		set NEW.atlet_altura = 0;
    end if;
end $$
delimiter ;

drop trigger if exists verificar_peso_altura_update;
delimiter $$
create trigger verificar_peso_altura_update
before update on atleta
for each row
begin
	if(NEW.atlet_peso < 0)
    then
		set NEW.atlet_peso = OLD.atlet_peso;
    end if;
    if(NEW.atlet_altura < 0)
    then
		set NEW.atlet_altura = OLD.atlet_altura;
    end if;
end $$
delimiter ;

drop trigger if exists guardar_mudanca_resultados;
delimiter $$
create trigger guardar_mudanca_resultados
before update on resultados
for each row
begin
	insert into tbl_logs(logs_date_oper, logs_par_id, logs_prov_id,
    logs_old_pontuacao, logs_new_pontuacao, logs_classificacao) values(
	curtime(), OLD.res_atlet_par_id, OLD.res_prov_id, OLD.res_pontuacao,
    NEW.res_pontuacao, OLD.res_classificacao
    );
end $$
delimiter ;
