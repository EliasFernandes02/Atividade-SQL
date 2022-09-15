-- CRIANDO AS TABELAS DA BASE DE DADOS

CREATE DATABASE Universidade;

CREATE TABLE tb_aluno (
    ID INT AUTO_INCREMENT,
    MAT int,
    nome varchar(255),
    endereço varchar(255),
    Cidade varchar(255),
    PRIMARY KEY(ID),
    UNIQUE(MAT)
);

CREATE TABLE tb_disciplina (
    ID INT AUTO_INCREMENT,
    COD_DISC varchar(50),
    nome_disc varchar(255),
    carga_hor int
    PRIMARY KEY(ID),
    UNIQUE(COD_DISC)
);

CREATE TABLE tb_professores (
    ID INT AUTO_INCREMENT,
    COD_PROF int,
    nome varchar(255),
    endereço varchar(255),
    cidade varchar(255),
    PRIMARY KEY(ID),
    UNIQUE(COD_PROF)

);

CREATE TABLE tb_turma (
    ID INT AUTO_INCREMENT,
    COD_DISC varchar(50),
    COD_TURMA varchar(255)
    COD_PROF int,
    ano int(50),
    horário varchar(255),
    PRIMARY KEY(ID),
    FOREIGN KEY (COD_DISC) REFERENCES tb_disciplina(COD_DISC),
    FOREIGN KEY (COD_PROF) REFERENCES tb_professores(COD_PROF)
    

);

CREATE TABLE tb_historico (
    ID INT AUTO_INCREMENT,
    MAT varchar(255),
    COD_DISC int,
    COD_TURMA int,
    COD_PROF int,
    ANO int,
    FREQUENCIA float,
    NOTA float,
    PRIMARY KEY(ID),
    FOREIGN KEY(MAT_ALUNO) REFERENCES tb_alunos(MAT),
    FOREIGN KEY(ID_TURMA)

);



-- INSIRA OS SEGUINTES REGISTROS:
INSERT INTO 
    tb_aluno(MAT,nome,endereço,cidade)

VALUES
    (2015010101, JOSE DE ALENCAR, RUA DAS ALMAS, NATAL)
    (2015010102, JOÃO JOSÉ, AVENIDA RUY CARNEIRO, JOÃO PESSOA)  
    (2015010103, MARIA JOAQUINA, RUA CARROSSEL, RECIFE)(2015010104, MARIA DAS
    DORES, RUA DAS LADEIRAS, FORTALEZA)
    (2015010105, JOSUÉ CLAUDINO DOS SANTOS, CENTRO, NATAL)
    (2015010106, JOSUÉLISSON CLAUDINO DOS SANTOS, CENTRO, NATAL)


INSERT INTO 
    tb_disciplina(COD_DISC,nome_disc,carga_hor)

VALUES
    (BD, BANCO DE DADOS, 100)
    (POO, PROGRAMAÇÃO COM ACESSO A BANCO DE DADOS, 100)
    (WEB, AUTORIA WEB, 50)
    (ENG, ENGENHARIA DE SOFTWARE, 80)

INSERT INTO
    tb_professores(COD_PROF,nome,endereço,cidade)

VALUES
    (212131, NICKERSON FERREIRA, RUA MANAÍRA, JOÃO PESSOA)
    (122135, ADORILSON BEZERRA, AVENIDA SALGADO FILHO, NATAL)
    (192011, DIEGO OLIVEIRA, AVENIDA ROBERTO FREIRE, NATAL)

INSERT INTO
    tb_turma(COD_DISC,COD_TURMA,COD_PROF,ano,horario)

VALUES
    (BD, 1, 212131, 2015, 11H-12H)
    (BD, 2, 212131, 2015, 13H-14H)
    (POO, 1, 192011, 2015, 08H-09H)
    (WEB, 1, 192011, 2015, 07H-08H)
    (ENG, 1, 122135, 2015, 10H-11H)

INSERT INTO
    tb_historico(FREQUENCIA,nota,MAT_ALUNO,ID_TURMA)

VALUES
	(60.0, 9.0, 3115010153, 2),
    (70.0, 7.5, 3215010152, 4),
    (90.0, 4.7, 3315010155, 1),
    (100.0, 7.0, 3415010151, 3),
    (80.0, 7.5, 4115010157,2),
    (50.0, 10.0, 4215010132,3),
    (90.0, 10.0, 4315010133,2),
    (90.0, 9.0, 4415010134,4),
    (100.0, 6.0, 4515010121, 1),
    (100.0, 7.5, 1215010122, 3),
    (70.0, 2.0, 1315010123, 5),
    (100.0, 4.7, 1415010124, 2),
    (100.0, 4.0, 1515010112, 3),
    (100.0, 8.5, 5115010113, 4),
    (90.0, 7.5, 5215010114, 2),
    (100.0, 5.9, 5315010104, 1),
    (90.0, 10.0, 5415010106, 2),
    (100.0, 7.0, 5515010107, 3),
    (100.0, 5.9, 6115010108, 5),
    (90.0, 9.0, 6215010109, 2),
    (100.0, 4.4, 6315010102, 1),
    (100.0, 5.9, 6415010103, 3),
    (80.0, 7.0, 7615010104, 5),
    (80.0, 10.0, 7515010105, 1);


-- a) Encontre a MAT dos alunos com nota em BD em 2015 menor que 5 (obs: BD =código da disciplinas).

SELECT 
    tb_historico.MAT_ALUNO as matricula

    FROM tb_historico

    -- entrelaçando tabelas
INNER JOIN
    ON tb_historico.ID_TURMA = tb_turma.ID

    tb_turma.ano = 2015 AND tb_historico.nota <5 AND tb_turma.COD_DISC='BD';

-- b) Encontre a MAT e calcule a média das notas dos alunos na disciplina de POO em 2015.

SELECT 
    tb_historico.MAT_ALUNO as matricula
    FROM tb_historico
    -- entrelaçando tabelas
INNER JOIN tb_turma
    ON tb_historico.ID_TURMA = tb_turma.ID

WHERE 
    tb_turma.ano = 2015 AND tb_historico.nota < 5 AND tb_turma.COD_DISC = 'BD'


-- c) Encontre a MAT e calcule a média das notas dos alunos na disciplina de POO em 2015 e que esta média seja superior a 6.

-- Selecionando os dados de matricula, nota e disciplina:
SELECT 
    tb_historico.MAT_ALUNO as `matricula`,
    tb_historico.nota as `nota`,
    tb_turmas.COD_DISC as `disciplina`

        FROM tb_historico

-- Comparando os dados da tabela da esquerda com os da direita

LEFT JOIN tb_turma
        ON tb_historico.ID_TURMA = tb_turma.ID

WHERE 
        tb_turma.COD_DISC ='POO';

-- Fazendo a média
SELECT 
    AVG(tb_historico.nota) as `Média`,
    tb_turma as `disciplina`
        FROM tb_historico

-- Entrelaçando as tabelas
INNER JOIN tb_turma
        ON tb_historico.ID_TURMA = tb_turma.ID

WHERE
        tb_turmas.COD_DISC = 'POO' AND tb_turma.ano = 2015

GROUP BY
        tb_turmas.ID

HAVING 
        AVG(tb_historico.nota) > 6;



-- d) Encontre quantos alunos não são de Natal.

SELECT
	COUNT(*) as `Alunos que não moram em natal` 
FROM tb_aluno
WHERE 
	NOT cidade = 'NATAL';

