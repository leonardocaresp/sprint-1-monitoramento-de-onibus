use databus;

create table empresa (
	idEmpresa int primary key auto_increment,
    nome varchar(45) not null,
    email varchar(60) not null,
    cnpj char(18) not null,
    endereco varchar(60),
    telefone char(11) not null
);


INSERT INTO empresa (nome, email, cnpj, endereco, telefone) VALUES 
('Viação Cometa Paulistana', 'contato@cometapaulistana.com.br', '12.345.678/0001-01', 'Av. Cruzeiro do Sul, 1800 - Santana - SP', '11123456789'),
('Consórcio Transvida SP', 'atendimento@transvidasp.com.br', '98.765.432/0001-99', 'Rua das Juntas Provisorias, 500 - Ipiranga - SP', '11987654321'),
('Expresso Zona Sul S.A.', 'sac@expressozonasul.com.br', '45.678.912/0001-55', 'Av. Interlagos, 3200 - Campo Grande - SP', '11334455667'),
('Viação Metrópole Leste', 'ouvidoria@metropoleleste.com.br', '23.456.789/0001-22', 'Estada do Imperador, 1200 - Itaquera - SP', '11223344556'),
('Sambaíba Transportes Fictícia', 'faleconosco@sambaibaficticia.com.br', '34.567.890/0001-44', 'Av. Projetada, 100 - Vila Maria - SP', '11556677889');

select * from empresa;

select nome, email from empresa where endereco like '%SP';

select nome from empresa where nome like "Viação%";

create table onibus (
	idOnibus int primary key auto_increment,
	linha varchar(15) not null,
    placa varchar(45) not null,
    qtdPontos int not null,
    tipoOnibus varchar(45) not null
);

USE databus;

INSERT INTO onibus (linha, placa, qtdPontos, tipoOnibus) VALUES 
('8000-10', 'ABC1D23', 35, 'Articulado'),
('4310-10', 'XYZ9W87', 42, 'Biarticulado'),
('175T-10', 'MNO4V56', 28, 'Padrão (Padron)'),
('2290-10', 'KJH7G65', 30, 'Trólebus'),
('917M-10', 'QWE3R21', 25, 'Midi (Micrão)');

select * from onibus;

select linha, placa from onibus where qtdPontos > 30;

select linha, placa,

case
	when qtdPontos >= 60 then 'Muitos Pontos'
    when qtdPontos > 30 then 'Até que tem bastante'
    else 'Tem pontos razoaveis'
	end as "Muitos pontos?"
    from onibus;
    
select linha,
case
	when tipoOnibus = 'Articulado' then '140 Passageiros'
    when tipoOnibus = 'Padrão (Padron)' then '80 Passageiros'
    else "Especificar"
end as CapacidadeMaxima

from onibus;

select linha from onibus where tipoOnibus = "Articulado";

select linha from onibus where qtdPontos between 20 and 30;


create table registroEntrada (
id int primary key auto_increment,
horario_data DATETIME DEFAULT CURRENT_TIMESTAMP,
placa CHAR(7) not null,
linha VARCHAR(35) not null
);

insert into registroEntrada (placa, linha) values
('ABC1234', '475RC-10'),
('DEF5678', '8123-10'),
('GHI9012', '6783 - Arthur Alvim'),
('JKL3456', '0124 - Vila Guilherme');

select * from registroEntrada;

select linha from registroEntrada where horario_data = '2026-09-09 11:12:00';

