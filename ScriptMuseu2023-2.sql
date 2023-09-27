-- Geração de Modelo físico
-- Sql ANSI 2003 - brModelo.

CREATE DATABASE MUSEU_ADS;

USE MUSEU_ADS;


CREATE TABLE Manutencao (
CodManutencao INTEGER PRIMARY KEY AUTO_INCREMENT,
DescrServico VARCHAR(500),
DataInicio DATE,
DataPrevTErmino DATE,
CodRestaurador INTEGER NOT NULL,
CodObra INTEGER NOT NULL
);

CREATE TABLE Obra (
CodObra INTEGER PRIMARY KEY AUTO_INCREMENT,
Titulo VARCHAR(200),
AnoCriacao SMALLINT,
Estilo VARCHAR(20),
Peso DECIMAL(12,2),
TipoObra CHAR(9),
CodAutor INTEGER NOT NULL
);

CREATE TABLE Autor (
CodAutor INTEGER PRIMARY KEY AUTO_INCREMENT,
Nome VARCHAR(200) NOT NULL,
Nacionalidade VARCHAR(20) DEFAULT 'Brasileiro'
);

CREATE TABLE Posicao (
CodSalao INTEGER,
CodPosicao INTEGER,
Posicao VARCHAR(50) NOT NULL,
CodObra INTEGER,
PRIMARY KEY(CodSalao,CodPosicao),
FOREIGN KEY(CodObra) REFERENCES Obra (CodObra)
);

CREATE TABLE Salao (
CodSalao INTEGER PRIMARY KEY AUTO_INCREMENT,
NumSalao VARCHAR(10),
Andar VARCHAR(15)
);

CREATE TABLE Restaurador (
CodRestaurador INTEGER PRIMARY KEY AUTO_INCREMENT,
Nome VARCHAR(200) NOT NULL,
CPF CHAR(14) NOT NULL,
Especialidade VARCHAR(20),
SalarioMensal DECIMAL(12,2)
);

CREATE TABLE Guarda (
CodGuarda INTEGER PRIMARY KEY AUTO_INCREMENT,
Nome VARCHAR(200) NOT NULL,
CPF CHAR(14) NOT NULL,
HoraEntrada TIME,
HoraSaida TIME,
SalarioMensal DECIMAL(12,2),
CodSalao INTEGER,
FOREIGN KEY(CodSalao) REFERENCES Salao (CodSalao)
);

CREATE TABLE ManutencaoMaterial (
CodMaterial INTEGER,
CodManutencao INTEGER,
QuantUsada DECIMAL(12,2),
PRIMARY KEY(CodMaterial,CodManutencao),
FOREIGN KEY(CodManutencao) REFERENCES Manutencao (CodManutencao)
);

CREATE TABLE EsculturaMaterial (
CodObra INTEGER,
CodMaterial INTEGER,
PRIMARY KEY(CodObra,CodMaterial),
FOREIGN KEY(CodObra) REFERENCES Obra (CodObra) ON UPDATE RESTRICT ON DELETE CASCADE
);

CREATE TABLE Material (
CodMaterial INTEGER PRIMARY KEY AUTO_INCREMENT,
Nome VARCHAR(200) NOT NULL,
QuantEstoque DECIMAL(12,2),
CustoMaterial DECIMAL(12,2)
);

CREATE TABLE TelefoneRestaurador (
CodRestaurador INTEGER,
CodTelefone DECIMAL(2,0),
DDI DECIMAL(3,0),
DDD DECIMAL(3,0),
NumTElefone INTEGER,
PRIMARY KEY(CodRestaurador,CodTelefone),
FOREIGN KEY(CodRestaurador) REFERENCES Restaurador (CodRestaurador)
);

CREATE TABLE TelefoneGuarda (
CodGuarda INTEGER,
CodTelefone DECIMAL(2,0),
DDI DECIMAL(3,0),
DDD DECIMAL(3,0),
NumTElefone INTEGER,
PRIMARY KEY(CodGuarda,CodTelefone),
FOREIGN KEY(CodGuarda) REFERENCES Guarda (CodGuarda)
);

ALTER TABLE Manutencao ADD FOREIGN KEY(CodRestaurador) REFERENCES Restaurador (CodRestaurador) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE Manutencao ADD FOREIGN KEY(CodObra) REFERENCES Obra (CodObra);
ALTER TABLE Obra ADD FOREIGN KEY(CodAutor) REFERENCES Autor (CodAutor) ON DELETE RESTRICT;
ALTER TABLE Posicao ADD FOREIGN KEY(CodSalao) REFERENCES Salao (CodSalao) ON UPDATE RESTRICT ON DELETE RESTRICT;
ALTER TABLE ManutencaoMaterial ADD FOREIGN KEY(CodMaterial) REFERENCES Material (CodMaterial);
ALTER TABLE EsculturaMaterial ADD FOREIGN KEY(CodMaterial) REFERENCES Material (CodMaterial) ON UPDATE RESTRICT ON DELETE RESTRICT;
