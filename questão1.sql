CREATE DATABASE QUESTÃO1;

CREATE TABLE tb_questao1 (
    ID_NF INT NOT NULL,
    ID_ITEM INT NOT NULL,
    COD_PROD INT NOT NULL,
    VALOR_UNIT FLOAT,
    QUANTIDADE INT NOT NULL,
    DESCONTO INT NOT NULL
);
INSERT INTO tb_questao1 (ID_NF,ID_ITEM,COD_PROD,VALOR_UNIT,QUANTIDADE,DESCONTO) 
                            VALUES (1, 1, 1, 25, 10, 5),
                            (1, 2, 2, 13.5, 3, NULL),
                            (1, 3, 3, 10, 1, NULL),
                            (1, 5, 5, 30, 1, NULL),
                            (2, 1, 3, 15, 4, NULL),
                            (2, 2, 4, 10, 5, NULL),
                            (2, 3, 5, 30, 7, NULL),
                            (3, 1, 1, 25, 5, NULL),
                            (3, 2, 4, 10, 4, NULL),
                            (3, 5, 5, 30, 5, NULL),
                            (3, 4, 2, 13.5, 7, NULL),
                            (4, 1, 5, 30, 10, 15),
                            (4, 2, 4, 10, 12, 5),
                            (4, 3, 1, 25, 13, 5),
                            (4, 4, 2, 13.5, 15, 5),
                            (5, 1, 3, 15, 3, NULL),
                            (5, 2, 5, 30, 6, NULL),
                            (6, 1, 1, 25, 22, 15),
                            (6, 2, 3, 15, 25, 20),
                            (7, 1, 1, 25, 10, 3),
                            (7, 2, 2, 13.5, 10, 4),
                            (7, 3, 3, 15, 10, 4),
                            (7, 4, 5, 30, 10, 1);


--  a) Pesquise os itens que foram vendidos sem desconto. As colunas presentes no 
-- resultado da consulta são: ID_NF, ID_ITEM, COD_PROD E VALOR_UNIT --


SELECT  ID_NF, ID_ITEM, COD_PROD E VALOR_UNIT 
FROM tb_questao1
WHERE DESCONTO IS NULL



-- b) Pesquise os itens que foram vendidos com desconto. As colunas presentes no resultado 
-- da consulta são: ID_NF, ID_ITEM, COD_PROD, VALOR_UNIT E O VALOR VENDIDO.

-- OBS: O valor vendido é igual ao VALOR_UNIT - (VALOR_UNIT*(DESCONTO/100)).



SELECT ID_NF, ID_ITEM, COD_PROD, VALOR_UNIT,VALOR_UNIT - (VALOR_UNIT * (DESCONTO/100)) AS VALOR_COM_DESCONTO 
FROM tb_questao1 
WHERE DESCONTO IS NOT NULL



-- c) Altere o valor do desconto (para zero) de todos os registros onde este campo é nulo

    SELECT Coalesce(DESCONTO, 0) AS DESCONTO FROM tb_questao1   

-- d) Pesquise os itens que foram vendidos. As colunas presentes no resultado da consulta
-- são: ID_NF, ID_ITEM, COD_PROD, VALOR_UNIT, VALOR_TOTAL, DESCONTO,
-- VALOR_VENDIDO. OBS: O VALOR_TOTAL é obtido pela fórmula: QUANTIDADE * VALOR_UNIT.
-- O VALOR_VENDIDO é igual a VALOR_UNIT - (VALOR_UNIT*(DESCONTO/100)).

SELECT ID_NF, ID_ITEM, COD_PROD, VALOR_UNIT, QUANTIDADE * VALOR_UNIT AS VALOR_TOTAL, 
DESCONTO, VALOR_UNIT - (VALOR_UNIT*(DESCONTO/100)) AS VALOR_VENDIDO 
FROM tb_questao1 


-- e) Pesquise o valor total das NF e ordene o resultado do maior valor para o menor. As
-- colunas presentes no resultado da consulta são: ID_NF, VALOR_TOTAL. OBS: OVALOR_TOTAL
-- é obtido pela fórmula: ∑ QUANTIDADE * VALOR_UNIT. Agrupe o resultado da consulta por
-- ID_NF.

select ID_NF, sum(QUANTIDADE * VALOR_UNIT ) as VALOR_TOTAL 
from  NF
group by ID_NF
order by VALOR_TOTALdesc

-- f) Pesquise o valor vendido das NF e ordene o resultado do maior valor para o menor. As
-- colunas presentes no resultado da consulta são: ID_NF, VALOR_VENDIDO.
-- OBS:
-- O VALOR_TOTAL é obtido pela fórmula: ∑ QUANTIDADE * VALOR_UNIT.
-- O VALOR_VENDIDO é igual a ∑ VALOR_UNIT - (VALOR_UNIT*(DESCONTO/100)).
-- Agrupe o resultado da consulta por ID_NF.


SELECT ID_NF,VALOR_UNIT - (VALOR_UNIT*(DESCONTO/100)) as VALOR_TOTAL
from NF
group by ID_NF
order by VALOR_TOTAL desc

-- g) Consulte o produto que mais vendeu no geral. As colunas presentes no resultado da consulta são: COD_PROD, QUANTIDADE. Agrupe o resultado da consulta por COD_PROD.

SELECT COD_PROD, sum(QUANTIDADE) AS QUANTIDADE
FROM tb_questao1 GROUP BY COD_PRO ORDER BY QUANTIDADE DESC


-- h) Consulte as NF que foram vendidas mais de 10 unidades de pelo menos um produto.
-- As colunas presentes no resultado da consulta são: ID_NF, COD_PROD, QUANTIDADE.
-- Agrupe o resultado da consulta por ID_NF, COD_PROD.

SELECT ID_NF, COD_PRO, sum(QUANTIDADE) FROM tb_questao1 WHERE QUANTIDADE > 10
GROUP BY ID_NF, COD_PROD

-- i) Pesquise o valor total das NF, onde esse valor seja maior que 500, e ordene o resultado do
-- maior valor para o menor. As colunas presentes no resultado da consulta são: ID_NF,
-- VALOR_TOT. OBS: O VALOR_TOTAL é obtido pela fórmula: ∑ QUANTIDADE * VALOR_UNIT.
-- Agrupe o resultado da consulta por ID_NF.

SELECT id_nf ,
SUM(QUANTIDADE * VALOR_UNIT) as QUANTIDADE
from NF
GROUP by ID_NF
having QUANTIDADE > 500
order by QUANTIDADE desc

-- j) Qual o valor médio dos descontos dados por produto. As colunas presentes no resultado da
-- consulta são: COD_PROD, MEDIA. Agrupe o resultado da consulta por COD_PROD.
SELECT
COD_PROD, AVG(DESCONTO) AS MEDIA
FROM NF
GROUP by COD_PROD

-- k) Qual o menor, maior e o valor médio dos descontos dados por produto. As colunas
-- presentes no resultado da consulta são: COD_PROD, MENOR, MAIOR, MEDIA. Agrupe
-- o resultado da consulta por COD_PROD.

SELECT
COD_PROD,
MAX(DESCONTO) AS MAIOR,
MIN(DESCONTO) AS MENOR,
AVG(DESCONTO) AS MEDIA
FROM NF
GROUP by COD_PROD




-- l) Quais as NF que possuem mais de 3 itens vendidos. As colunas presentes no resultado
-- da consulta são: ID_NF, QTD_ITENS. OBS:: NÃO ESTÁ RELACIONADO A QUANTIDADE
-- VENDIDA DO ITEM E SIM A QUANTIDADE DE ITENS POR NOTA FISCAL. Agrupe o
-- resultado da consulta por ID_NF.

SELECT
ID_NF,
COUNT(QUANTIDADE) as quantidade
FROM NF
GROUP BY ID_NF
having quantidade > 3




