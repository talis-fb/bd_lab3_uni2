CREATE TABLE IF NOT EXISTS `Aeroporto` (
  `codigo_aeroporto` VARCHAR(10) PRIMARY KEY NOT NULL,
  `nome` VARCHAR(100) NOT NULL,
  `cidade` VARCHAR(100) NOT NULL,
  `estado` VARCHAR(2) NOT NULL
);

CREATE TABLE IF NOT EXISTS `Modelo_Aeronave` (
  `nome_modelo` VARCHAR(50) PRIMARY KEY NOT NULL,
  `empresa` VARCHAR(100) NOT NULL,
  `maximo_assentos` INT NOT NULL
);

CREATE TABLE IF NOT EXISTS `Pode_Pousar` (
  `nome_modelo` VARCHAR(50) NOT NULL,
  `codigo_aeroporto` VARCHAR(10) NOT NULL
);

CREATE TABLE IF NOT EXISTS `Aeronave` (
  `cod_aeronave` VARCHAR(20) PRIMARY KEY NOT NULL,
  `numero_total_assentos` INT NOT NULL,
  `nome_modelo` VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS `Trecho` (
  `numero_trecho` INT PRIMARY KEY NOT NULL,
  `horario_inicio` TIME NOT NULL,
  `horario_termino` TIME NOT NULL,
  `codigo_aeroporto_origem` VARCHAR(10) NOT NULL,
  `codigo_aeroporto_destino` VARCHAR(10) NOT NULL,
  `numero_voo` INT NOT NULL
);

CREATE TABLE IF NOT EXISTS `Voo` (
  `numero_voo` INT PRIMARY KEY NOT NULL,
  `companhia_aerea` VARCHAR(100) NOT NULL,
  `Dia_da_semana` VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS `Trecho_Sobrevoado` (
  `numero_trecho` INT UNIQUE NOT NULL,
  `data` DATE NOT NULL,
  `cod_aeronave` VARCHAR(20) NOT NULL,
  `codigo_aeroporto_partida` VARCHAR(10),
  `hora_partida` TIME,
  `codigo_aeroporto_chegada` VARCHAR(10),
  `hora_chegada` TIME,
  `numero_assentos_disponiveis` INT NOT NULL,
  PRIMARY KEY (`cod_aeronave`, `data`)
);

CREATE TABLE IF NOT EXISTS `Tarifa` (
  `codigo` INT PRIMARY KEY NOT NULL,
  `numero_voo` INT NOT NULL,
  `restricoes` VARCHAR(255),
  `quantidade` INT NOT NULL
);

CREATE TABLE IF NOT EXISTS `Assento` (
  `numero_assento` VARCHAR(10) PRIMARY KEY NOT NULL,
  `nome_cliente` VARCHAR(100) NOT NULL,
  `telefone_cliente` VARCHAR(20) NOT NULL,
  `cod_aeronave` VARCHAR(20) NOT NULL,
  `data` DATE NOT NULL,
  CONSTRAINT `UK_Assento` UNIQUE (`cod_aeronave`, `data`)
);

-- CREATE UNIQUE INDEX `UK_Assento` ON `Assento` (`cod_aeronave`, `data`);

ALTER TABLE `Pode_Pousar` ADD CONSTRAINT `FK_PP_Modelo` FOREIGN KEY (`nome_modelo`) REFERENCES `Modelo_Aeronave` (`nome_modelo`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `Pode_Pousar` ADD CONSTRAINT `FK_PP_Aeroporto` FOREIGN KEY (`codigo_aeroporto`) REFERENCES `Aeroporto` (`codigo_aeroporto`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `Aeronave` ADD CONSTRAINT `FK_Aeronave_Modelo` FOREIGN KEY (`nome_modelo`) REFERENCES `Modelo_Aeronave` (`nome_modelo`) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE `Trecho` ADD CONSTRAINT `FK_Trecho_Origem` FOREIGN KEY (`codigo_aeroporto_origem`) REFERENCES `Aeroporto` (`codigo_aeroporto`) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE `Trecho` ADD CONSTRAINT `FK_Trecho_Destino` FOREIGN KEY (`codigo_aeroporto_destino`) REFERENCES `Aeroporto` (`codigo_aeroporto`) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE `Trecho` ADD CONSTRAINT `FK_TS_Voo` FOREIGN KEY (`numero_voo`) REFERENCES `Voo` (`numero_voo`) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE `Trecho_Sobrevoado` ADD CONSTRAINT `FK_TS_Trecho` FOREIGN KEY (`numero_trecho`) REFERENCES `Trecho` (`numero_trecho`) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE `Trecho_Sobrevoado` ADD CONSTRAINT `FK_TS_Aeronave` FOREIGN KEY (`cod_aeronave`) REFERENCES `Aeronave` (`cod_aeronave`) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE `Trecho_Sobrevoado` ADD CONSTRAINT `FK_TS_AeroportoChegada` FOREIGN KEY (`codigo_aeroporto_chegada`) REFERENCES `Aeroporto` (`codigo_aeroporto`) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE `Trecho_Sobrevoado` ADD CONSTRAINT `FK_TS_AeroportoPartida` FOREIGN KEY (`codigo_aeroporto_partida`) REFERENCES `Aeroporto` (`codigo_aeroporto`) ON DELETE RESTRICT ON UPDATE CASCADE;

ALTER TABLE `Tarifa` ADD CONSTRAINT `FK_Tarifa_Voo` FOREIGN KEY (`numero_voo`) REFERENCES `Voo` (`numero_voo`) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `Assento` ADD CONSTRAINT `FK_Res_TS` FOREIGN KEY (`cod_aeronave`, `data`) REFERENCES `Trecho_Sobrevoado` (`cod_aeronave`, `data`) ON DELETE CASCADE ON UPDATE CASCADE;


-- 1. Aeroporto
INSERT INTO `Aeroporto` (`codigo_aeroporto`, `nome`, `cidade`, `estado`) VALUES
('GRU', 'Aeroporto Internacional de Guarulhos', 'São Paulo', 'SP'),
('GIG', 'Aeroporto Internacional do Galeão', 'Rio de Janeiro', 'RJ'),
('CNF', 'Aeroporto de Confins', 'Belo Horizonte', 'MG');

-- 2. Modelo_Aeronave
INSERT INTO `Modelo_Aeronave` (`nome_modelo`, `empresa`, `maximo_assentos`) VALUES
('Boeing 737', 'Boeing', 189),
('Airbus A320', 'Airbus', 180);

-- 3. Pode_Pousar
INSERT INTO `Pode_Pousar` (`nome_modelo`, `codigo_aeroporto`) VALUES
('Boeing 737', 'GRU'),
('Boeing 737', 'GIG'),
('Airbus A320', 'CNF');

-- 4. Aeronave
INSERT INTO `Aeronave` (`cod_aeronave`, `numero_total_assentos`, `nome_modelo`) VALUES
('PT-ABC1', 180, 'Boeing 737'),
('PT-DEF2', 175, 'Airbus A320');

-- 5. Voo
INSERT INTO `Voo` (`numero_voo`, `companhia_aerea`, `Dia_da_semana`) VALUES
(1001, 'LATAM Airlines', 'Segunda-feira'),
(1002, 'GOL Linhas Aéreas', 'Sexta-feira');

-- 6. Trecho
INSERT INTO `Trecho` (`numero_trecho`, `horario_inicio`, `horario_termino`, `codigo_aeroporto_origem`, `codigo_aeroporto_destino`, `numero_voo`) VALUES
(1, '08:00:00', '10:00:00', 'GRU', 'GIG', 1001),
(2, '12:00:00', '14:00:00', 'CNF', 'GRU', 1002);

-- 7. Trecho_Sobrevoado
INSERT INTO `Trecho_Sobrevoado` (`numero_trecho`, `data`, `cod_aeronave`, `codigo_aeroporto_partida`, `hora_partida`, `codigo_aeroporto_chegada`, `hora_chegada`, `numero_assentos_disponiveis`) VALUES
(1, '2025-06-01', 'PT-ABC1', 'GRU', '08:00:00', 'GIG', '10:00:00', 50),
(2, '2025-06-02', 'PT-DEF2', 'CNF', '12:00:00', 'GRU', '14:00:00', 70);

-- 8. Tarifa
INSERT INTO `Tarifa` (`codigo`, `numero_voo`, `restricoes`, `quantidade`) VALUES
(1, 1001, 'Não reembolsável', 30),
(2, 1002, 'Flexível', 40);

-- 9. Assento
INSERT INTO `Assento` (`numero_assento`, `nome_cliente`, `telefone_cliente`, `cod_aeronave`, `data`) VALUES
('1A', 'João Silva', '11999999999', 'PT-ABC1', '2025-06-01'),
('2B', 'Maria Souza', '21988888888', 'PT-DEF2', '2025-06-02');


select * FROM Aeroporto;
select * FROM Modelo_Aeronave;
select * FROM Pode_Pousar;
select * FROM Aeronave;
select * FROM Trecho;
select * FROM Voo;
select * FROM Trecho_Sobrevoado;
select * FROM Tarifa;
select * FROM Assento;


