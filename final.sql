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
