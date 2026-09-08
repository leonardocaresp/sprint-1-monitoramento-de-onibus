CREATE DATABASE databus;
USE databus;

CREATE TABLE cadastro (
CNPJ CHAR(18) PRIMARY KEY,
empresa VARCHAR(45) NOT NULL,
gmail VARCHAR(70) NOT NULL,
contato CHAR(11),
senha VARCHAR(100) NOT NULL
);

DROP TABLE cadastro;

CREATE TABLE onibus (
placa CHAR(7) PRIMARY KEY,  -- empresa do onibus?
codigo CHAR(7) NOT NULL,
tipo VARCHAR(30),
CONSTRAINT chTipo CHECK (tipo = 'Articulado' OR tipo = 'Micro-onibus' OR tipo = 'Onibus'),
capacidade INT NOT NULL
);

-- linha != onibus
CREATE TABLE linha (
NumLinha VARCHAR(10) PRIMARY KEY, -- placa como pk? horario tambem? horInicio/horFim
nomeIda VARCHAR(50) NOT NULL,
nomeVolta VARCHAR(50) NOT NULL,
paradas INT NOT NULL, -- paradas os Kms por rota + custo por km?
tarifa DECIMAL(5,2) NOT NULL 
);

-- sensor
CREATE TABLE monitoramento (
idMonitoramento INT PRIMARY KEY AUTO_INCREMENT, -- tarifa como FK facilita calculo da mesma tabela?
placa CHAR(7) NOT NULL,
NumLinha VARCHAR(10) NOT NULL,
qtdPessoas INT,
dataHora DATETIME DEFAULT CURRENT_TIMESTAMP,

CONSTRAINT fkMonitoramentoOnibus
FOREIGN KEY (placa) REFERENCES onibus(placa),

CONSTRAINT fkMonitoramentoLinha
FOREIGN KEY (NumLinha) REFERENCES linha(NumLinha)
);

INSERT INTO cadastro (CNPJ, empresa, gmail, contato, senha) VALUES
('12.345.678/0001-90', 'BusTech', 'contato@bustech.com', '11987654321', 'senha123'),
('98.765.432/0001-10', 'TransData', 'contato@transdata.com', '11976543210', 'senha456'),
('45.678.912/0001-55', 'Mobility SP', 'contato@mobilitysp.com', '11965432109', 'senha789');

INSERT INTO onibus (placa, codigo, tipo, capacidade) VALUES
('ABC1234', 'BUS0001', 'Articulado', 100),
('DEF5678', 'BUS0002', 'Onibus', 70),
('GHI9012', 'BUS0003', 'Micro-onibus', 30);

INSERT INTO linha (NumLinha, nomeIda, nomeVolta, paradas, tarifa) VALUES
('875A-10', 'Campo Limpo - Centro', 'Centro - Campo Limpo', 25, 5.50),
('807A-10', 'Term. Campo Limpo - Term.Santo Amaro', 'Term.Santo Amaro - Term. Campo Limpo', 25, 5.30),
('975P-10', 'Paraiso - Term. Campo Limpo', 'Term. Campo Limpo - Paraiso', 25, 5.30);

INSERT INTO monitoramento (placa, NumLinha, qtdPessoas, dataHora) VALUES
('ABC1234', '875A-10', 35, '2026-08-26 06:30:00'),
('ABC1234', '875A-10', 48, '2026-08-26 07:00:00'),
('ABC1234', '875A-10', 62, '2026-08-26 07:30:00'),
('ABC1234', '875A-10', 78, '2026-08-26 20:00:00'),
('DEF5678', '875A-10', 40, '2026-08-26 08:30:00'),
('DEF5678', '875A-10', 55, '2026-08-26 09:00:00'),
('DEF5678', '875A-10', 63, '2026-08-26 16:30:00'),
('GHI9012', '875A-10', 18, '2026-08-26 17:00:00'),
('GHI9012', '875A-10', 25, '2026-08-26 17:30:00'),
('GHI9012', '875A-10', 29, '2026-08-26 19:00:00');

SELECT qtdPessoas, NumLinha, dataHora FROM monitoramento WHERE dataHora BETWEEN '2026-08-26 04:00:00' AND '2026-08-26 12:00:00';
SELECT qtdPessoas, NumLinha, dataHora FROM monitoramento WHERE dataHora BETWEEN '2026-08-26 12:00:01' AND '2026-08-26 18:00:00';
SELECT qtdPessoas, NumLinha, dataHora FROM monitoramento WHERE dataHora BETWEEN '2026-08-26 18:00:01' AND '2026-08-26 23:00:00';

SELECT capacidade FROM onibus WHERE tipo = 'Articulado';
SELECT capacidade FROM onibus WHERE tipo = 'Micro-onibus';
SELECT capacidade FROM onibus WHERE tipo = 'Onibus';

SELECT tarifa, NumLinha FROM linha;

SELECT * FROM Monitoramento WHERE NumLinha = '875A-10';

SELECT qtdPessoas, dataHora, NumLinha FROM Monitoramento WHERE qtdPessoas <40;

SELECT qtdPessoas, tipo FROM monitoramento, onibus WHERE tipo ='Articulado'; -- tem como puxar o tipo pela placa de onibus? nao sei
SELECT qtdPessoas, tipo FROM monitoramento, onibus WHERE tipo ='Micro-onibus';
SELECT qtdPessoas, tipo FROM monitoramento, onibus WHERE tipo ='Onibus';

SELECT qtdPessoas, capacidade, capacidade - qtdPessoas AS Aproveitamento FROM monitoramento, onibus;

SELECT 
capacidade, qtdPessoas, tarifa, dataHora, linha.NumLinha, tarifa * qtdPessoas AS arrecadação, CONCAT ((capacidade - qtdPessoas) / 100 * 100, '%') AS PerdaPorcentagem 
FROM linha, monitoramento, onibus 
WHERE linha.NumLinha = monitoramento.NumLinha -- AND qtdPessoas <40; filtro bem legal
ORDER BY qtdPessoas; 

SELECT qtdPessoas, qtdPessoas + qtdPessoas AS totalDia FROM Monitoramento;


