CREATE DATABASE DataBus;

USE DataBus;

CREATE TABLE cadastro (
cnpj CHAR(18) PRIMARY KEY,
nome_empresa VARCHAR(100) NOT NULL,
email VARCHAR(100) NOT NULL UNIQUE,
senha VARCHAR(100) NOT NULL,
regiao VARCHAR(60) NOT NULL,
telefone CHAR(15) NOT NULL UNIQUE  
);

INSERT INTO cadastro VALUES
('00.000.000/0001-91', 'Mobi Brasil', 'mobi@email.com', 'senha123', 'São Paulo', '(11) 98765-4321'),
('00.121.011/0041-31', 'SPTrans', 'sptrans@email.com', 'senha1234', 'São Paulo','(11) 98765-4320'),
('00.011.011/0011-11', 'MobiRio', 'mobirio@email.com', 'senha1234', 'Rio de Janeiro', '(21) 98765-1520'),
('12.713.901/1021-51', 'Transcon', 'transcon@email.com', 'senha12354', 'Belo Horizonte', '(31) 98325-4320');

SELECT * FROM cadastro;

SELECT
 cnpj AS 'Cnpj',
 nome_empresa AS 'Nome da Empresa',
 email AS 'E-mail',
 senha AS 'Senha',
 regiao AS 'Região',
 telefone AS 'Telefone para Contato'
FROM cadastro;

CREATE TABLE registro_entrada_passageiro (
id INT PRIMARY KEY AUTO_INCREMENT,
horario_data DATETIME DEFAULT CURRENT_TIMESTAMP,
placa CHAR(7) NOT NULL,
linha VARCHAR(35) NOT NULL
);

INSERT INTO registro_entrada_passageiro (placa, linha) VALUES
('ABC1234', '607C-10'),
('DEF5678', '5106-10'),
('GHI9012', '483 - Penha'),
('JKL3456', '8150 - União');

SELECT * FROM registro_entrada_passageiro;

SELECT 
 id AS 'ID',
 placa AS 'Placa',
 linha AS 'Linha',
  DATE_FORMAT(horario_data, '%d/%m/%Y %H:%m:%s')AS 'Data e hora'
FROM registro_entrada_passageiro;

CREATE TABLE onibus_tempo_real(
placa CHAR(7) PRIMARY KEY,
codigo_linha VARCHAR(35) NOT NULL,
nome_linha VARCHAR(30),
passageiros INT DEFAULT 0 NOT NULL,
capacidade_maxima INT NOT NULL,
tarifa DECIMAL(4,2)
);

INSERT INTO onibus_tempo_real VALUES
('ABC1134', '607C-10', 'Jardim Miriam - Itaim Bibi', 110, 120, 5.30),
('CBA1234', '5106-10', 'Mar Paulista - São Francisco', 80, 120, 5.30),
('JCC3412', '483 - Penha', 'Penha - Ipanema', 33, 80, 5.30),
('LEO6671', '8150 - União', ' União - Serra', 60, 80, 5.30);

 SELECT * from onibus_tempo_real;
 
 SELECT
  placa AS 'Placa',
  codigo_linha AS 'Cód. da Linha',
  nome_linha AS 'Nome da Linha',
  passageiros AS 'Quantidade de Passageiros',
  capacidade_maxima AS 'Capacidade Máxima',
  CONCAT('R$', tarifa) AS 'Valor da Tarifa'
 FROM onibus_tempo_real;
 
 CREATE TABLE onibus_final(
placa CHAR(7) PRIMARY KEY,
codigo_linha CHAR(7) NOT NULL,
nome_linha VARCHAR(35) NOT NULL,
viagens INT NOT NULL,
horario_rodando CHAR(13) NOT NULL,
total_passageiros INT DEFAULT 0 NOT NULL,
tarifa DECIMAL(4,2),
valor_total DECIMAL(10,2)
	AS (total_passageiros * tarifa)
 );
 
 INSERT INTO onibus_final
(placa, codigo_linha, nome_linha, viagens, horario_rodando, total_passageiros, tarifa) VALUES
('ABC1134', '607C-10', 'Jardim Miriam - Itaim Bibi', 12, '08:30 - 18:30', 8000, 5.30),
('CBA1234', '5106-10', 'Mar Paulista - São Francisco', 10, '09:00 - 19:00', 6000, 5.30),
('JCC3412', '483', 'Penha - Ipanema', 10, '10:00 - 18:00', 3500, 5.00),
('LEO6671', '8150', 'União - Serra', 12, '07:30 - 17:30', 4000, 6.25);

SELECT * FROM onibus_final;

SELECT
 placa AS 'Placa',
 codigo_linha AS 'Cód. da Linha',
 viagens AS 'Quantidade de Viagens',
 horario_rodando AS 'Horário de Ronda',
 total_passageiros AS 'Total de Passageiros',
 CONCAT('R$', tarifa) AS 'Valor da Tarifa',
 CONCAT('R$', valor_total) AS 'Valor Arrecadado'
FROM onibus_tempo_real;

CREATE TABLE linha(
codigo CHAR(7) NOT NULL,
nome VARCHAR(100) NOT NULL,
passageiros_total INT DEFAULT 0,
passageiros_manha INT DEFAULT 0,
passageiros_tarde INT DEFAULT 0,
passageiros_noite INT DEFAULT 0,
tarifa DECIMAL(4,2),
valor_total DECIMAL(10,2)
        AS (passageiros_total * tarifa)
);

INSERT INTO linha
(codigo, nome, passageiros_total, passageiros_manha, passageiros_tarde, passageiros_noite, tarifa) VALUES
('607C-10', 'Jardim Miriam - Itaim Bibi', 8000, 3000, 3200, 1800, 5.30),
('5106-10', 'Mar Paulista - São Francisco', 6000, 2200, 2500, 1300, 5.30),
('483', 'Penha - Ipanema', 3500, 1300, 1400, 800, 5.00),
('8150', 'União - Serra', 4000, 1500, 1600, 900, 6.25);

SELECT * FROM linha;

SELECT 
 codigo AS 'Código',
 nome AS 'Nome da Linha',
 passageiros_total AS 'Total de Passageiros',
 passageiros_manha AS 'Passageiros - 04:30 - 12:00',
 passageiros_tarde AS 'Passageiros - 12:00 - 18:00',
 passageiros_noite AS 'Passageiros - 18:00 - 00:00',
 CONCAT('R$', tarifa) AS 'Valor da Tarifa',
 CONCAT('R$', valor_total) AS 'Valor Arrecadado' 
FROM linha;







 
 











