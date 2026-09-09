CREATE DATABASE pi;

USE pi;
CREATE TABLE cadastro (
id INT PRIMARY KEY,
nome VARCHAR (60),
CNPJ CHAR (18),
email VARCHAR (60),
senha VARCHAR (100),
região_empresa VARCHAR(30)
);

INSERT INTO cadastro VALUES
(1, 'SPTrans', '74.608.768/0001-89', 'sptrans@gmail.com', 'sp123', 'São Paulo'),
(2, 'Transcon', '74.406.745/0001-89', 'transcon@gmail.com', 'tra123', 'Minas Gerais'),
(3, 'MobiRio', '34.408.925/0001-89', 'mobirio@gmail.com', 'rio123', 'Rio de Janeiro');

SELECT * FROM cadastro;


CREATE TABLE relatório (
id INT PRIMARY KEY, 
linha_onibus VARCHAR (10), 
qtd_onibus INT,
qtd_Passageiros INT,
tarifa DECIMAL (6,2),
arrecadação DECIMAL (10,2)
  AS (qtd_Passageiros * tarifa)
);

INSERT INTO relatório (id, linha_onibus, qtd_onibus, qtd_Passageiros, tarifa) VALUES
(1, '3766-10', 6, 800, 5.40),
(2, '2766-10', 9, 500, 5.40),
(3, '2755-10', 7, 700, 5.40),
(4, '2733-10', 4, 700, 5.40),
(5, '354M-10', 9, 1100, 5.40);

SELECT * FROM relatório;


CREATE TABLE onibus_tempo_real (
id INT PRIMARY KEY,
nome VARCHAR (40),
placa VARCHAR(10) UNIQUE,
qtd_passageiros INT,
qtd_viagens INT,
capacidade INT
);

INSERT INTO onibus_tempo_real VALUE 
(1, 'JD.Camargo Velho', 'RHU-7P00', 58, 5, 80),
(2, 'JD.Camargo Novo', 'IJK-1X49', 75, 8, 80),
(3, 'PQ. Guarani', 'SZA-8Z22', 86, 9, 80),
(4, 'Itaim Paulista', 'HAO-4R95', 18, 3, 80);

SELECT * FROM onibus_tempo_real;