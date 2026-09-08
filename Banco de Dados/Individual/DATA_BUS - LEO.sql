CREATE DATABASE databus;

USE databus;

CREATE TABLE cadastro_empresa (
cnpj CHAR(18) PRIMARY KEY, -- ex: 00.000.000/0001-91
nome VARCHAR(50) NOT NULL,
email VARCHAR(100) NOT NULL,
senha VARCHAR(50) NOT NULL,
telefone CHAR(14) -- ex: (11) 3831-0361 - TELEFONE FIXO
);
-- IDEIA: deixar o tipo do telefone como CHAR(9), pois todas empresas que vamos trabalhar sao de Sao Paulo
-- entao nao precisa do "(11)"

INSERT INTO cadastro_empresa VALUES
('11.031.202/0001-17', 'MobiBrasil', 'fiscal@mobibrasil.com', 'senhamobi@123', '(11) 2155-2500'),
('01.751.967/0001-78', 'Sambaiba', 'sambaiba@email.com', 'sambaiba@brasil', '(11) 2990-4445'),
('31.974.104/0001-20', 'Metrópole Paulista', 'metropole@paulista.com', 'euamosaopaulo098', '(11) 5121-2124');

SELECT * FROM cadastro_empresa;

CREATE TABLE captura_entrada (
id INT PRIMARY KEY AUTO_INCREMENT,
horario_entrada TIME DEFAULT (CURRENT_TIME), -- perguntar se pode usar o CURRENT_TIME
placa CHAR(7) NOT NULL,
linha CHAR(7) NOT NULL
);

INSERT INTO captura_entrada (placa, linha) VALUES
('ABC1234', '971A-10');

SELECT * FROM captura_entrada;

CREATE TABLE onibus_total (
placa CHAR(7) NOT NULL,
linha CHAR(7) NOT NULL,
nome_linha VARCHAR(100) NOT NULL,
paradas TINYINT NOT NULL,
horario_ronda CHAR(13) NOT NULL, -- ex: 06:00 - 16:00
passageiros INT DEFAULT 0 
);

INSERT INTO onibus_total (placa, linha, nome_linha, paradas, horario_ronda) VALUES
('ABC1234', '971A-10', 'Jd. Primavera - Shopping D', 38, '04:00 - 18:00');

SELECT * FROM onibus_total;

CREATE TABLE onibus_tempo_real (
placa CHAR(7) NOT NULL,
linha CHAR(7) NOT NULL,
nome_linha VARCHAR(100) NOT NULL,
paradas TINYINT NOT NULL,
passageiros TINYINT DEFAULT 0,
capacidade TINYINT NOT NULL,
condicao VARCHAR(24)
);

INSERT INTO onibus_tempo_real VALUES
('ABC1234', '971A-10', 'Jd. Primavera - Shopping D', 38, DEFAULT, 80, 'Vazio');

SELECT * FROM onibus_tempo_real;

CREATE TABLE linha (
codigo CHAR(7) NOT NULL,
nome VARCHAR(100) NOT NULL,
passageiros_total INT DEFAULT 0,
passageiros_manha INT DEFAULT 0,
passageiros_tarde INT DEFAULT 0,
passageiros_noite INT DEFAULT 0
);

INSERT INTO linha VALUES
('971A-10', 'Jd. Primavera - Shopping D', 1000, 300, 300, 400);

SELECT codigo, nome, passageiros_total AS 'Total de passageiros',
passageiros_manha AS 'Passageiros (04h - 12h)', passageiros_tarde AS 'Passageiros (12h - 18h)',
passageiros_noite AS 'Passageiros (18h - 22h)'
FROM linha;


