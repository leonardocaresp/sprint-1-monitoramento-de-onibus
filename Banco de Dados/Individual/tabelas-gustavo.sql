CREATE DATABASE busao;

USE busao;

CREATE TABLE empresaContratante (
	cnpj CHAR(18) PRIMARY KEY,
    razaoSocial VARCHAR(75),
    email VARCHAR(75) NOT NULL UNIQUE,
    telefone VARCHAR(11),
    senha VARCHAR(75) NOT NULL,
    statusContrato VARCHAR(30) -- Ativo, desativado, renegociação, enfim, vai do nosso gosto.
);

CREATE TABLE onibus/*TempoReal*/ (
	placa CHAR(7) PRIMARY KEY,
    nome VARCHAR(45), -- nome do letreiro principal do ônibus, talvez seja redundante com a linha, mas como não tem chave estrangeira eu quis pôr
    quantddPassageirosDia INT,
    quantddPassageirosAtual INT, -- pode haver incongruências, pois o sensor não tem IA nem nada assim pra garantir que cada pessoa tenha somente uma entrada/saída
    condicaoLotacao VARCHAR(30), -- se está cheio, normal ou vazio
    paradas INT,
    capaciMaximaPassageiros INT,
    statusOnibus VARCHAR(30), -- ativo, inativo, desativado, em manutenção, em reserva etc.
    linhaAtualOperacao VARCHAR(45), -- pro caso do cliente remanejar suas linhas, mas esse campo pode ser removido daqui, uma vez que essa decisão é totalmente do cliente
    linhaOriginalOperacao VARCHAR(45)
);

CREATE TABLE monitoraEntradaSaida (
	id INT PRIMARY KEY AUTO_INCREMENT,
    tipoDado TINYINT NOT NULL, -- 0 para saídas e 1 para entradas
    horario DATETIME DEFAULT (CURRENT_TIMESTAMP),
    codigoLinha CHAR(7) NOT NULL,
    placaOnibus CHAR(7) NOT NULL,
    
    CONSTRAINT chTipoDado CHECK(tipoDado IN(0, 1))
);

CREATE TABLE linha (
	numeracao CHAR(7) PRIMARY KEY,
    nome VARCHAR(45), -- nome da linha
    horarioOperacional VARCHAR(12), -- não sei se cabe, pode mudar dependendo se é feriado ou final de semana
    diasDeOperacao VARCHAR(45), -- Ex.: seg. a sex. Pode ser feito usando abreviações ou ignorado, visto que só observaremos lotação
    statusLinha VARCHAR(45), -- ativa, inativa. Passível de remoção tbm
    valorTarifa DECIMAL(5,2),
    totalPassageirosDia INT,
    quantddOnibusLinha INT
);

/* NO CASO DE DIFERENCIARMOS a tabela de ônibus em tempo real da que tem dados constantes
CREATE TABLE onibusAssincrono (
	placa CHAR(7) PRIMARY KEY,
    nome VARCHAR(45), -- nome do ônibus
    quantddPassageirosDia INT,
    paradas INT,
    capaciMaximaPassageiros INT,
    statusOnibus VARCHAR(30), -- ativo, desativado, em manutenção, em reserva para casualidades etc.
    linhaOriginalOperacao VARCHAR(45)
);*/

INSERT INTO empresaContratante (cnpj, razaoSocial, email, senha, statusContrato) VALUES
('11.031.202/0001-17', 'MOBIBRASIL TRANSPORTE SAO PAULO LTDA', 'mobibrasil@email.com', '01234567abc', 'Ativo'),
('61.084.018/0001-03', 'Viação Cometa S/A', 'fiscal@integrajca.com.br', '95847kbjgs~', 'Ativo'),
('30.069.314/0001-01', 'Auto Viação 1001 Ltda', 'Gustavo.rodrigues@jcatlm.com.br', '2829fvs~]a', 'Desativado');

SELECT * FROM empresaContratante
WHERE statusContrato = 'Ativo';





INSERT INTO onibus VALUES
('ajac952', 'Itaquera', 16000, 17, 'Vazio', 39, 80, 'Ativo', 'Itaquera/Inácio Monteiro', 'Itaquera/Inácio Monteiro'),
('onfv380', 'Guaianazes', 11000, 37, 'Normal', 28, 80, 'Ativo', 'Guaianazes/Jardim São Paulo', 'Guaianazes/Jardim São Paulo');

SELECT * FROM onibus
ORDER BY nome;




INSERT INTO monitoraEntradaSaida (tipoDado, codigoLinha, placaOnibus) VALUES
(1, '4051-10', '5692AGO'),
(0, '4051-10', '5692AGO');

SELECT
id AS 'Código',
CASE
	WHEN tipoDado = 1 THEN 'Entrada'
    ELSE 'Saída'
END  AS 'Valor rcebido',
codigoLinha AS 'Linha de ônibus',
placaOnibus AS 'Placa do veículo',
horario AS 'Momento da ação'
FROM monitoraEntradaSaida;



INSERT INTO linha VALUES
('4051-10', 'Guaianazes/Jardim São Paulo', '05:00-23:30', 'Seg. a sex.', 'Inativa', 5.60, 83000, 16),
('412n-10', 'Terminal Cidade Tiradentes/São Miguel', '05:00-00:30', 'Domingo a domingo', 'Ativa', 5.60, 152000, 20),
('3754-10', 'Itaquera/Inácio Monteiro', '04:30-23:30', 'Seg. a sáb.', 'Ativa', 5.60, 107000, 19);

SELECT 
CONCAT('A linha ', numeracao, ' (', nome, ') opera de ', diasDeOperacao, ' das ', 
horarioOperacional, ' com cerca de ', quantddOnibusLinha, ' ônibus, transportando cerca de ', totalPassageirosDia,' passageiros ao dia')
AS 'Resumo da linha'
FROM linha
WHERE totalPassageirosDia > 100000
ORDER BY quantddOnibusLinha DESC;
