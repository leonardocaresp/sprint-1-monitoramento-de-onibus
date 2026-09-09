CREATE DATABASE TabelaSprint1;

USE TabelaSprint1;

-- Tabela 1: Cadastro de Operadoras / Empresas
CREATE TABLE cliente_operadora (
    cnpj_operadora CHAR(18) PRIMARY KEY,
    razao_social VARCHAR(100) NOT NULL,
    email_contato VARCHAR(100) NOT NULL UNIQUE,
    senha_acesso VARCHAR(100) NOT NULL,
    cidade_sede VARCHAR(60) NOT NULL,
    telefone_comercial CHAR(15) NOT NULL UNIQUE  
);

INSERT INTO cliente_operadora VALUES
('11.111.111/0001-11', 'Viação Bela Vista', 'contato@belavista.com', 'senha123', 'São Paulo', '(11) 91111-2222'),
('22.222.222/0002-22', 'Expresso Lapa Grande', 'diretoria@lapagrande.com', 'senha1234', 'Montes Claros', '(38) 92222-3333'),
('33.333.333/0003-33', 'Mobilidade Primavera', 'admin@primaveramob.com', 'senha1234', 'Montes Claros', '(38) 93333-4444'),
('44.444.444/0004-44', 'TransMetrópole SP', 'gerencia@transmetropole.com', 'senha12354', 'São Paulo', '(11) 94444-5555');

SELECT * FROM cliente_operadora;

SELECT
 cnpj_operadora AS 'CNPJ',
 razao_social AS 'Razão Social',
 email_contato AS 'E-mail',
 senha_acesso AS 'Senha',
 cidade_sede AS 'Sede',
 telefone_comercial AS 'Telefone Comercial'
FROM cliente_operadora;


-- Tabela 2 - Registro de Entrada de Passageiros (Catraca)
CREATE TABLE leitura_catraca (
    id_leitura INT PRIMARY KEY AUTO_INCREMENT,
    data_hora_registro DATETIME DEFAULT CURRENT_TIMESTAMP,
    placa_veiculo CHAR(7) NOT NULL,
    nome_trajeto VARCHAR(40) NOT NULL
);

INSERT INTO leitura_catraca (placa_veiculo, nome_trajeto) VALUES
('XYZ9876', '715M - Bela Vista'),
('MNO4321', '800B - Lapa Grande'),
('QRS6543', '107T - Primavera'),
('TUV0987', '212C - Centro');

SELECT * FROM leitura_catraca;

SELECT 
 id_leitura AS 'ID',
 placa_veiculo AS 'Placa do Veículo',
 nome_trajeto AS 'Trajeto',
 DATE_FORMAT(data_hora_registro, '%d/%m/%Y %H:%i:%s') AS 'Data e Hora da Leitura'
FROM leitura_catraca;


-- Tabela 3 - Ônibus em Tempo Real
CREATE TABLE status_onibus_agora (
    placa_veiculo CHAR(7) PRIMARY KEY,
    codigo_rota VARCHAR(35) NOT NULL,
    descricao_rota VARCHAR(40),
    qnt_passageiros INT DEFAULT 0 NOT NULL,
    lotacao_maxima INT NOT NULL,
    valor_passagem DECIMAL(4,2)
);

INSERT INTO status_onibus_agora VALUES
('XYZ9876', '715M-10', 'Bela Vista - Consolação', 95, 110, 5.30),
('MNO4321', '800B-10', 'Lapa Grande - Terminal', 60, 90, 4.50),
('QRS6543', '107T-10', 'Primavera - Shopping', 45, 80, 4.50),
('TUV0987', '212C-10', 'Centro - Bairro Alto', 85, 100, 5.30);

SELECT * FROM status_onibus_agora;
 
SELECT
  placa_veiculo AS 'Placa',
  codigo_rota AS 'Código da Rota',
  descricao_rota AS 'Descrição da Rota',
  qnt_passageiros AS 'Passageiros a Bordo',
  lotacao_maxima AS 'Lotação Máxima',
  CONCAT('R$', valor_passagem) AS 'Passagem'
FROM status_onibus_agora;


-- Tabela 4 - Fechamento Diário
CREATE TABLE fechamento_diario_onibus(
    placa_veiculo CHAR(7) PRIMARY KEY,
    codigo_rota CHAR(7) NOT NULL,
    descricao_rota VARCHAR(40) NOT NULL,
    corridas_realizadas INT NOT NULL,
    turno_operacao CHAR(13) NOT NULL,
    total_transportado INT DEFAULT 0 NOT NULL,
    tarifa_atual DECIMAL(4,2),
    arrecadacao_total DECIMAL(10,2)
        AS (total_transportado * tarifa_atual)
);
 
INSERT INTO fechamento_diario_onibus
(placa_veiculo, codigo_rota, descricao_rota, corridas_realizadas, turno_operacao, total_transportado, tarifa_atual) VALUES
('XYZ9876', '715M-10', 'Bela Vista - Consolação', 14, '06:00 - 16:00', 7500, 5.30),
('MNO4321', '800B-10', 'Lapa Grande - Terminal', 12, '07:00 - 17:00', 5800, 4.50),
('QRS6543', '107T-10', 'Primavera - Shopping', 15, '05:30 - 15:30', 6200, 4.50),
('TUV0987', '212C-10', 'Centro - Bairro Alto', 10, '08:00 - 18:00', 4100, 5.30);

SELECT * FROM fechamento_diario_onibus;

SELECT
 placa_veiculo AS 'Placa',
 codigo_rota AS 'Código da Rota',
 corridas_realizadas AS 'Total de Corridas',
 turno_operacao AS 'Turno',
 total_transportado AS 'Total Transportado',
 CONCAT('R$', tarifa_atual) AS 'Tarifa',
 CONCAT('R$', arrecadacao_total) AS 'Arrecadação do Dia'
FROM fechamento_diario_onibus;


-- Tabela 5 - Resumo por Linha
CREATE TABLE resumo_operacao_linha (
    codigo_linha CHAR(7) NOT NULL,
    nome_linha VARCHAR(100) NOT NULL,
    volume_total INT DEFAULT 0,
    volume_manha INT DEFAULT 0,
    volume_tarde INT DEFAULT 0,
    volume_noite INT DEFAULT 0,
    preco_tarifa DECIMAL(4,2),
    faturamento_bruto DECIMAL(10,2)
        AS (volume_total * preco_tarifa)
);

INSERT INTO resumo_operacao_linha
(codigo_linha, nome_linha, volume_total, volume_manha, volume_tarde, volume_noite, preco_tarifa) VALUES
('715M-10', 'Bela Vista - Consolação', 7500, 3100, 2900, 1500, 5.30),
('800B-10', 'Lapa Grande - Terminal', 5800, 2000, 2400, 1400, 4.50),
('107T-10', 'Primavera - Shopping', 6200, 2500, 2500, 1200, 4.50),
('212C-10', 'Centro - Bairro Alto', 4100, 1400, 1700, 1000, 5.30);

SELECT * FROM resumo_operacao_linha;

SELECT 
 codigo_linha AS 'Código',
 nome_linha AS 'Linha',
 volume_total AS 'Volume Total',
 volume_manha AS 'Fluxo Manhã',
 volume_tarde AS 'Fluxo Tarde',
 volume_noite AS 'Fluxo Noite',
 CONCAT('R$', preco_tarifa) AS 'Tarifa',
 CONCAT('R$', faturamento_bruto) AS 'Faturamento Bruto' 
FROM resumo_operacao_linha;


-- SELECTS

-- Filtrar empresas que ficam apenas em São Paulo (Uso do WHERE)
SELECT * FROM cliente_operadora WHERE cidade_sede = 'São Paulo';

-- Buscar ônibus em tempo real onde a quantidade de passageiros é maior que 80
SELECT placa_veiculo, codigo_rota, qnt_passageiros, lotacao_maxima 
FROM status_onibus_agora 
WHERE qnt_passageiros > 80;

-- Ordenar as linhas com maior faturamento bruto do maior para o menor (Uso do ORDER BY DESC)
SELECT codigo_linha, nome_linha, faturamento_bruto 
FROM resumo_operacao_linha 
ORDER BY faturamento_bruto DESC;

-- Pesquisar linhas que contêm a palavra 'Consolação' no nome (Uso do LIKE)
SELECT * FROM resumo_operacao_linha 
WHERE nome_linha LIKE '%Consolação%';

-- Consulta com AND: Ônibus com mais de 5000 passageiros e tarifa menor que R$ 5.00
SELECT placa_veiculo, codigo_rota, total_transportado, tarifa_atual 
FROM fechamento_diario_onibus 
WHERE total_transportado > 5000 AND tarifa_atual < 5.00;