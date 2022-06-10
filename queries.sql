use proj2;
-- Mostrar informações gerais sobre alojamento
select aloj_morada as 'Morada', aloj_area as 'Área', aloj_tipol_tipologia as 'Tipologia',
aloj_freg_codigo as 'Código Freguesia', aloj_conc_codigo as 'Código Concelho', aloj_conc_dist_codigo
as 'Código Distrito' from alojamento;
-- Mostrar informações gerais sobre atleta
select atlet_peso as 'Peso', atlet_altura as 'Altura', atlet_par_id as 'Id do Atleta' from atleta;
-- Mostrar informações gerais sobre cacarterísticasaloj
select caracaloj_aloj_morada as 'Morada do alojamento', caracaloj_carac_code as 'Código do alojamento'
from caracteristicasaloj;
-- Mostrar informações gerais sobre características
select carac_caracteristica as 'Característica de alojamento', carac_code as 'Código da característica'
from características;
-- Mostrar informações gerais sobre certificado
select cert_certificado as 'Certificados' from certificado;
-- Mostrar informações gerais sobre compra
select comp_ip as 'Id da compra', comp_preco as 'Preço da compra',
comp_datadecompra as 'Data da compra', comp_prod_nome as 'Produto comprado',
comp_serv_fornecedor as 'Fornecedor', comp_aloj_morada as 'Morada do fornecedor' from compra;
-- Mostrar informações gerais de concelho AQUI NAO ENTENDI BEM QUE ATRIBUTOS SAO ESTES.
select conc_concelho as 'Concelho', conc_codigo as 'Código do concelho', conc_dist_codigo from concelho;
-- Mostrar informações gerais de distrito
select dist_distrito as 'Distrito', dist_codigo as 'Código do distrito' from distrito;
-- Mostrar informações gerais de equipa
select equip_sigla as 'Sigla', equip_nome as 'Nome da equipa' from equipa;
-- Mostrar informações sobre equipaevento
select eqev_equip_sigla as 'Sigla', eqev_even_code as 'Código' from equipaevento;
-- Mostrar informações sobre evento
select even_descricao as 'Descrição do Evento', even_perinicio as 'Data prevista de início',
even_perfim as 'Data prevista de término', even_nome as 'Nome do evento',
even_morada as 'Local onde ocorrerá o evento', even_code as 'Código do evento',
even_org_nome as 'Organização responsável' from evento;
-- Mostrar informações gerais sobre freguesia NAO ENTEDI ESTES ATRIBUTOS.
select freg_freguesia as 'Freguesia', freg_codigo as 'Código da freguesia',
freg_conc_codigo, freg_conc_dist_codigo from freguesia;
-- Mostrar informações gerais sobre modalidade
select mod_nome as 'Nome da Modalidade', mod_code as 'Código da Modalidade' from modalidade;
-- Mostrar informações gerais sobre organizador
select org_nome as 'Nome da organização' from organizador;
-- Mostrar informações gerais sobre participante
select par_sexo as 'Sexo', par_nome as 'Nome', par_id as 'Id do participante', par_dnsc as 'Data de Nascimento',
par_aloj_morada as 'Morada do participante' from participante;
-- Mostrar informações gerais sobre participanteequipa
select parequip_equip_sigla as 'Sigla', parequip_par_id as 'Id' from participanteequipa;

-- Mostrar informações gerais sobre produto
select prod_nome as 'Nome do produto' from produto;

-- Mostrar informações gerais sobre prova
select prov_localizacao as 'Localização da prova', prov_id as 'Id da prova',
prov_data as 'Data da prova', prov_duracao as 'Duração', prov_even_code as 'Código do evento',
prov_mod_code as 'Código da Modalidade', prov_conc_codigo as 'Código do concelho onde decorre a prova',
prov_conc_dist_codigo as 'Código do distrito onde decorre a prova' from prova;

-- Mostrar informações gerais sobre resultados
select res_classificacao as 'Classificação', res_atlet_par_id as 'Id do atleta',
res_prov_id as 'Id da prova', res_pontuacao as 'Pontuação Obtida' from resultados;

-- Mostrar informações gerais sobre serviço
select serv_fornecedor as 'Fornecedor' from serviço;

-- Mostrar informações gerais sobre tbl_logs
select * from tbl_logs;  -- POR FAZER!

-- Mostrar informações gerais sobre tipologia
select tipol_tipologia as 'Tipologia' from tipologia;

-- Mostrar informações gerais sobre treinador
select trein_par_id as 'Id do treinador', trein_cert_certificado as 'Certificado do treinador' from treinador;

-- Lista de participantes segundo, pelo menos, 2 critérios de consulta

-- Lista de participantes masculinos
select par_sexo as 'Sexo', par_nome as 'Nome', par_id as 'Id do participante', par_dnsc as 'Data de Nascimento',
par_aloj_morada as 'Morada do participante' from participante where par_sexo = 'M';

-- Lista de participantes femininos
select par_sexo as 'Sexo', par_nome as 'Nome', par_id as 'Id do participante', par_dnsc as 'Data de Nascimento',
par_aloj_morada as 'Morada do participante' from participante where par_sexo = 'F';

-- Lista de participantes acima dos 18 anos
select par_sexo as 'Sexo', par_nome as 'Nome', par_id as 'Id do participante', par_dnsc as 'Data de Nascimento',
par_aloj_morada as 'Morada do participante' from participante where timestampdiff(year, par_dnsc, now()) >= 18;

-- Lista de participantes, mas onde a morada é nula dizer '(Morada Por Preencher)'
select par_sexo as 'Sexo', par_nome as 'Nome', par_id as 'Id do participante', par_dnsc as 'Data de Nascimento',
ifnull(par_aloj_morada, '(Morada por preencher)')  as 'Morada do participante' from participante;

-- Lista de equipas e respetivos elementos cuja equipa 
select equip_nome, par_nome from equipa e
join ;



-- Lista de provas do evento (por todos os id's de prova do mesmo evento na mesma linha!)
select even_nome as 'Evento', prov_id as 'Id da prova' from evento e
join prova p on e.even_code=p.prov_even_code
;

-- Lista de provas com menos de 5 participantes num evento -------------duvidas aqui :( mas se gostares da sugestão tenta completar
select prov_id as 'Id das provas com menos de 5 participantes', even_code as 'Evento na qual decorrem'
from evento e 
join prova p on e.even_code=p.prov_even_code
;

-- Lista de alojamentos dos participantes com pelo menos 1 medalha

-- Lista de alojamentos dos participantes de uma equipa específica (escolher uma qualquer)

-- Lista de alojamentos de uma freguesia

-- Lista de alojamentos de um concelho

-- Lista de alojamentos de um distrito

-- Lista de alojamentos com uma área superior a 500m2

-- Lista resultados com os primeiros três em cada prova
select * from vResultadosOrdenado
where Lugar <= 3;

-- Lista de participantes que não participaram em qualquer prova
select * from vNaoParticiparam;

-- Lista organizada por tipologia, com área média, mínima, máxima e desvio de padrão
select * from vCalculoAreaAlojamento;

-- Lista da média, máximo, mínimo e desvio padrão de idade de participantes por evento
select * from vCalculoIdadePorEvento;

-- Lista de média, máximo, mínimo e desvio padrão de altura de participantes por evento
select * from vCalculoAlturaPorEvento;

-- Lista de média, máximo, mínimo e desvio padrão de peso de participantes por evento
select * from vCalculoPesoPorEvento;

-- Lista de média, máximo, mínimo e desvio padrão de altura de participantes por prova
select * from vCalculoAlturaPorProva;

-- Lista de média, máximo, mínimo e desvio padrão de peso de participantes por prova
select * from vCalculoPesoPorProva;

-- Lista de média, máximo, mínimo e desvio padrão de pontuação de participantes por prova
select * from vCalculoPontuacaoPorProva;

-- Lista de alojamentos cujo total de itens associados (micro-ondas, forno, A/C, etc.) é superior a 4.
select Morada, count(*) as 'Produtos' from vMoradaProdutos
group by Morada
having count(*) > 4
order by count(*) desc;

-- Lista dos 5 participantes com mais medalhas (seja a participação individual ou coletiva);
select * from vParticipanteNumMedalhas
limit 5;

select * from participanteequipa;



select * from participanteequipa;
