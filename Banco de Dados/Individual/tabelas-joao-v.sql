CREATE DATABASE data_bus;

USE data_bus;

CREATE TABLE cadastro(
id_cnpj CHAR(18) PRIMARY KEY,
nome_empresa VARCHAR(50) NOT NULL,
email VARCHAR(100) NOT NULL UNIQUE,
telefone CHAR(11) NOT NULL UNIQUE,
senha VARCHAR(100) NOT NULL 
);

INSERT INTO cadastro VALUES
('00.000.000/0001-91', 'Mobi Brasil', 'mobi@email.com', '11987654321', 'senha123'),
('00.011.011/0011-11', 'SPTrans', 'sptrans@email.com', '11987654320', 'senha1234'),
('12.345.678/0001-90', 'Viação Paulista', 'viacao@email.com', '11987654322', 'senha456'),
('23.456.789/0001-80', 'TransMob', 'transmob@email.com', '11987654323', 'senha789'),
('34.567.890/0001-70', 'BusTech', 'bustech@email.com', '11987654324', 'senha321');

-- Seleção de todos os dados cadastrados
SELECT * FROM cadastro;

-- Exibição apenas das empresas parceiras
SELECT nome_empresa 'Nome da empresa' FROM cadastro;

-- Exibindo apenas uma empresa em específico
SELECT * FROM cadastro WHERE nome_empresa = 'SPTrans';

-- Exibindo apenas por uma letra em específica
SELECT * FROM cadastro WHERE nome_empresa LIKE 'M%';

-- Exibindo o nome da empresa em ordem crescente
SELECT * FROM cadastro ORDER BY nome_empresa ASC;

CREATE TABLE registro_entrada_passageiro(
    id INT PRIMARY KEY AUTO_INCREMENT,
    horario_entrada DATETIME DEFAULT CURRENT_TIMESTAMP,
    placa CHAR(7) NOT NULL,
    linha CHAR(7) NOT NULL
);

INSERT INTO registro_entrada_passageiro (placa, linha)
VALUES
('ABC1234', '607C-10'),
('DEF5678', '6000-10'),
('GHI9012', '6450-10'),
('JKL3456', '606C-10'),
('MNO7890', '372F-10'),
('PQR1234', '1018-10');

SELECT * FROM registro_entrada_passageiro;

-- Exibir apenas dados específicos
SELECT horario_entrada, linha
FROM registro_entrada_passageiro;

-- Exibir apenas uma linha
SELECT *
FROM captura_entrada
WHERE linha = '607C-10';

-- horario de entrada mais recente
SELECT *
FROM captura_entrada
ORDER BY horario_entrada DESC;

CREATE TABLE monitoramento_onibus(
placa CHAR(7) PRIMARY KEY,
linha CHAR(7) NOT NULL,
nome_linha_ida VARCHAR(50) NOT NULL,
nome_linha_volta VARCHAR(50) NOT NULL,
quantidade_pessoas INT NOT NULL,
quantidade_paradas INT NOT NULL,
horario_rodando CHAR(13) NOT NULL,
capacidade_maxima INT NOT NULL
);

INSERT INTO monitoramento_onibus
(placa, linha, nome_linha_ida, nome_linha_volta, quantidade_pessoas, quantidade_paradas, horario_rodando, capacidade_maxima)
VALUES
('ABC1234', '607C-10', 'Jd. Miriam - Itaim Bibi', 'Itaim Bibi - Jd. Miriam', 0, 42, '04:00 - 18:00', 80),
('DEF5678', '6000-10', 'Term. Parelheiros - Term. Santo Amaro', 'Term. Santo Amaro - Term. Parelheiros', 0, 48, '04:00 - 18:00', 80),
('GHI9012', '6450-10', 'Capelinha - Term. Bandeira', 'Term. Bandeira - Capelinha', 0, 36, '05:00 - 23:00', 80),
('JKL3456', '606C-10', 'Jd. Miriam - Santo Amaro', 'Santo Amaro - Jd. Miriam', 0, 34, '04:00 - 18:00', 80),
('MNO7890', '372F-10', 'Jd. Itápolis - Metrô Itaquera', 'Metrô Itaquera - Jd. Itápolis', 0, 40, '04:30 - 23:00', 80),
('PQR1234', '1018-10', 'Jd. Vila Formosa - Metrô Belém', 'Metrô Belém - Jd. Vila Formosa', 0, 29, '05:00 - 22:00', 80);

-- Inserir dados fictícios para mostrar onibus mais cheio e mais vazio
-- Fazer updates 
-- Alterar a capacidade maxima 

SELECT placa 'Placa', linha 'Linha', nome_linha_ida 'Nome da linha IDA', nome_linha_volta 'Nome da linha VOLTA', quantidade_pessoas 'Quantidade de passageiros',
 quantidade_paradas 'Quantidade de paradas', horario_rodando 'Horario rodando', capacidade_maxima 'Capacidade maxima' FROM monitoramento_onibus;
 
 -- Exibindo apenas placa e linha
 SELECT placa AS 'Placa',
       linha AS 'Linha'
FROM monitoramento_onibus;

-- Exibindo apenas onibus com a capacidade quase total
SELECT placa AS 'Placa',
       linha AS 'Linha',
       quantidade_pessoas AS 'Passageiros'
FROM monitoramento_onibus
WHERE quantidade_pessoas > 50;

-- Mostrar ônibus que ainda têm espaço
SELECT placa AS 'Placa',
       linha AS 'Linha',
       quantidade_pessoas AS 'Passageiros',
       capacidade_maxima AS 'Capacidade'
FROM monitoramento_onibus
WHERE quantidade_pessoas < capacidade_maxima;

-- Mostrar ônibus com lotação máxima
SELECT placa AS 'Placa',
       linha AS 'Linha',
       quantidade_pessoas AS 'Passageiros',
       capacidade_maxima AS 'Capacidade'
FROM monitoramento_onibus
WHERE quantidade_pessoas >= capacidade_maxima;

-- Ordenar do ônibus mais cheio para o mais vazio
SELECT placa AS 'Placa',
       linha AS 'Linha',
       quantidade_pessoas AS 'Passageiros'
FROM monitoramento_onibus
ORDER BY quantidade_pessoas DESC;

-- Calcular quantas vagas ainda existem
SELECT placa AS 'Placa',
       linha AS 'Linha',
       quantidade_pessoas AS 'Passageiros',
       capacidade_maxima AS 'Capacidade',
       (capacidade_maxima - quantidade_pessoas) AS 'Vagas disponíveis'
FROM monitoramento_onibus;


CREATE TABLE monitoramento_final_dia(
    placa CHAR(7) PRIMARY KEY,
    codigo CHAR(7) NOT NULL,
    nome_linha_ida VARCHAR(50) NOT NULL,
    nome_linha_volta VARCHAR(50) NOT NULL,
    quantidade_paradas INT NOT NULL,
    horario_rodando CHAR(13) NOT NULL,
    total_passageiros INT NOT NULL
);

INSERT INTO monitoramento_final_dia
(placa, codigo, nome_linha_ida, nome_linha_volta, quantidade_paradas, horario_rodando, total_passageiros)
VALUES
('ABC1234', '607C-10', 'Jd. Miriam - Itaim Bibi', 'Itaim Bibi - Jd. Miriam', 42, '04:00 - 18:00', 791263),
('DEF5678', '6000-10', 'Term. Parelheiros - Term. Santo Amaro', 'Term. Santo Amaro - Term. Parelheiros', 48, '04:00 - 18:00', 680617),
('GHI9012', '6450-10', 'Capelinha - Term. Bandeira', 'Term. Bandeira - Capelinha', 36, '05:00 - 23:00', 572114),
('JKL3456', '606C-10', 'Jd. Miriam - Santo Amaro', 'Santo Amaro - Jd. Miriam', 34, '04:00 - 18:00', 12000),
('MNO7890', '372F-10', 'Jd. Itápolis - Metrô Itaquera', 'Metrô Itaquera - Jd. Itápolis', 40, '04:30 - 23:00', 8500),
('PQR1234', '1018-10', 'Jd. Vila Formosa - Metrô Belém', 'Metrô Belém - Jd. Vila Formosa', 29, '05:00 - 22:00', 6200);

SELECT * FROM monitoramento_final_dia;

-- Ordenar do ônibus com mais passageiros para o menos
SELECT placa AS 'Placa',
       codigo AS 'Linha',
       total_passageiros AS 'Passageiros'
FROM monitoramento_final_dia
ORDER BY total_passageiros DESC;

-- Multiplicar passageiros por 2 (simulação de 2 dias)
SELECT placa,
       codigo,
       total_passageiros * 2 AS 'Quantidade de passageiros em 2 dias'
FROM monitoramento_final_dia;

-- Ver ônibus com mais de 500.000 passageiros
SELECT *
FROM monitoramento_final_dia
WHERE total_passageiros > 500000;

-- Dividindo a capacidade de passageiros pela metade
SELECT placa,
       codigo,
       total_passageiros / 2 AS 'Metade dos passageiros'
FROM monitoramento_final_dia;

CREATE TABLE linha_onibus(
codigo CHAR(7) NOT NULL,
nome VARCHAR(100) NOT NULL,
passageiros_total INT DEFAULT 0,
passageiros_manha INT DEFAULT 0,
passageiros_tarde INT DEFAULT 0,
passageiros_noite INT DEFAULT 0
);

INSERT INTO linha_onibus
(codigo, nome, passageiros_total, passageiros_manha, passageiros_tarde, passageiros_noite)
VALUES
('607C-10', 'Jd. Miriam - Itaim Bibi', 791263, 280000, 310000, 201263),
('6000-10', 'Term. Parelheiros - Term. Santo Amaro', 680617, 240000, 270000, 170617),
('6450-10', 'Capelinha - Term. Bandeira', 572114, 210000, 220000, 142114),
('606C-10', 'Jd. Miriam - Santo Amaro', 12000, 4500, 5000, 2500),
('372F-10', 'Jd. Itápolis - Metrô Itaquera', 8500, 3200, 3500, 1800),
('1018-10', 'Jd. Vila Formosa - Metrô Belém', 6200, 2300, 2500, 1400);

SELECT codigo 'Código', nome 'Nome', passageiros_total 'Total de passageiros', passageiros_manha 'Passageiros periodo Diurno', 
passageiros_tarde 'Passageiros periodo Vespertino', passageiros_noite 'Passageiros periodo Noturno' FROM linha_onibus;

-- Mostrar apenas nome e total de passageiros
SELECT nome, passageiros_total
FROM linha_onibus;

-- Somar manhã + tarde
SELECT codigo,
       nome,
       passageiros_manha + passageiros_tarde AS 'Manhã + Tarde'
FROM linha_onibus;

-- Conferir o total de passageiros
SELECT codigo,
       nome,
       passageiros_manha + passageiros_tarde + passageiros_noite AS 'Total calculado'
FROM linha_onibus;

-- Calcular a diferença entre manhã e noite
SELECT codigo,
       nome,
       passageiros_manha - passageiros_noite AS 'Diferença'
FROM linha_onibus;

-- Ver linhas com menos de 10.000 passageiros
SELECT *
FROM linha_onibus
WHERE passageiros_total < 10000;

-- Ordenar do maior para o menor
SELECT codigo, nome, passageiros_total
FROM linha_onibus
ORDER BY passageiros_total DESC;




