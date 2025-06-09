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
