-- Adiciona no tbl_logs as informações do resultado alterado
call sp_update_classificacao_prova(1,1,33);
select * from vTBLLogs;
-- Quando se adiciona ou se altera um participante impossível por um sexo diferente de M ou F
call sp_criar_participante('X','Tiago Emanuel Fonseca','2007-10-2');
select * from vParticipante;
update participante
set par_sexo = 'K'
where par_id = 33;
select * from vParticipante;
-- Quando se tenta adicionar ou alterar o valor do peso e altura
call sp_definir_atleta(40, -32,-1.5);
select * from vAtletaInformacao;
update atleta
set atlet_peso = -2 and atlet_altura = -2
where atlet_par_id = 39;
select * from vAtletaInformacao;
-- Quando se tenta adicionar ou alterar o valor do preço
call sp_efetuar_compra(-2,'Bola de futebol','Sport++','Praceta de António Atum, Nº1, 2ºE');
select * from vCompras;
update compra
set comp_preco = -2
where comp_ip = 6;
select * from vCompras;
