-- Mostra os resultados de um determinado atleta por ID
call sp_mostrar_resultados_atleta(6);
-- Mostar a quantidade de medalhas por cada medalha de um determinado atleta por ID
call sp_mostrar_medalhas_atleta(2);
-- Efetua uma compra para uma morada
call sp_efetuar_compra(200,'Fogão','Worten','Praceta de António Atum, Nº1, 2ºE');
-- Mostra o valor gasto em produtos numa morada
call sp_mostrar_valor_gasto_alojamento('Praceta de António Atum, Nº1, 2ºE');
-- Adicionar alojamento
call sp_adicionar_alojamento('Rua General Humberto Delgado, Nº42, 1ºE', '23.4/21.3', 150, 'T2', 1,2,5);
-- Adicionar equipa
call sp_adicionar_equipa_evento(2, 'SLB');
-- Adicionar modalidade
call sp_alojar_participante(4,'Rua General Humberto Delgado, Nº42, 1ºE');
-- Criar caracteristica
call sp_criar_caracteristica('Possui lareira');
-- Criar evento
call sp_criar_evento('Evento em que vão decorrer atividades de atletismo', '2022-6-10', '2022-9-30', 'Evento de Verão Atletismo', 'Complexo Municipal de Atletismo Carla Sacramento', 'Cruz Vermelha');
-- Criar participante
call sp_criar_participante('F','Joana Ribeiro','2005-12-24');
-- Criar produto
call sp_criar_produto('Passadeira');
-- Criar prova
call sp_criar_prova('21.4/25.2',curdate(),'2 Horas',3,3,1,2,5);
-- Definir atleta
call sp_definir_atleta(39,80,1.80);
-- Definir treinador
call sp_definir_treinador(25,'Certificado de excelência');
-- Remover prova
call sp_remover_prova(12);
-- Update classificação de um atleta
call sp_update_classificacao_prova(1,1,34);
-- Mostra todos os alojamentos dos participantes de uma determinada equipa
call sp_mostrar_aloj_equipa('SCP');
-- Cria uma cópia da prova
call sp_clonar_prova(8);