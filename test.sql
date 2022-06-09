-- Mostra os resultados de um determinado atleta por ID
call sp_mostrar_resultados_atleta(6);
-- Mostar a quantidade de medalhas por cada medalha de um determinado atleta por ID
call sp_mostrar_medalhas_atleta(2);
-- Efetua uma compra para uma morada
call sp_efetuar_compra(200,'Fogão','Worten','Praceta de António Atum, Nº1, 2ºE');
-- Mostra o valor gasto em produtos numa morada
call sp_mostrar_valor_gasto_alojamento('Praceta de António Atum, Nº1, 2ºE');