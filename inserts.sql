---  Inserindo Aeroportos
INSERT INTO Aeroporto (codigo_aeroporto, nome, cidade, estado) VALUES
('GRU', 'Aeroporto Internacional de São Paulo', 'Guarulhos', 'SP'),
('GIG', 'Aeroporto Internacional do Rio de Janeiro', 'Rio de Janeiro', 'RJ'),
('BSB', 'Aeroporto Internacional de Brasília', 'Brasília', 'DF'),
('SSA', 'Aeroporto Internacional de Salvador', 'Salvador', 'BA'),
('POA', 'Aeroporto Internacional de Porto Alegre', 'Porto Alegre', 'RS');

-- Inserindo Modelos de Aeronaves
INSERT INTO Modelo_Aeronave (nome_modelo, empresa, maximo_assentos) VALUES
('Airbus A320', 'Airbus', 180),
('Boeing 737', 'Boeing', 189),
('Embraer E195', 'Embraer', 124);

-- Relacionando onde cada modelo pode pousar
INSERT INTO Pode_Pousar (nome_modelo, codigo_aeroporto) VALUES
('Airbus A320', 'GRU'),
('Airbus A320', 'GIG'),
('Airbus A320', 'BSB'),
('Airbus A320', 'SSA'),
('Boeing 737', 'GRU'),
('Boeing 737', 'GIG'),
('Boeing 737', 'POA'),
('Embraer E195', 'GRU'),
('Embraer E195', 'POA'),
('Embraer E195', 'SSA'),
('Embraer E195', 'BSB');

-- Inserindo Aeronaves
INSERT INTO Aeronave (cod_aeronave, numero_total_assentos, nome_modelo) VALUES
('PT-ABC', 180, 'Airbus A320'),
('PT-DEF', 189, 'Boeing 737'),
('PT-GHI', 124, 'Embraer E195');

-- Inserindo Voos
INSERT INTO Voo (numero_voo, companhia_aerea, Dia_da_semana) VALUES
(1001, 'LATAM', 'Segunda'),
(1002, 'GOL', 'Quarta'),
(1003, 'AZUL', 'Sexta');

-- Inserindo Trechos
INSERT INTO Trecho (numero_trecho, horario_inicio, horario_termino, codigo_aeroporto_origem, codigo_aeroporto_destino, numero_voo) VALUES
(1, '08:00:00', '10:00:00', 'GRU', 'GIG', 1001),
(2, '14:00:00', '16:00:00', 'BSB', 'SSA', 1002),
(3, '18:00:00', '20:00:00', 'POA', 'GRU', 1003);

-- Inserindo Trechos Sobrevoados
INSERT INTO Trecho_Sobrevoado (numero_trecho, data, cod_aeronave, codigo_aeroporto_partida, hora_partida, codigo_aeroporto_chegada, hora_chegada, numero_assentos_disponiveis) VALUES
(1, '2025-06-10', 'PT-ABC', 'GRU', '08:10:00', 'GIG', '10:05:00', 150),
(2, '2025-06-10', 'PT-DEF', 'BSB', '14:05:00', 'SSA', '16:10:00', 160),
(3, '2025-06-10', 'PT-GHI', 'POA', '18:00:00', 'GRU', '20:05:00', 100);

-- Inserindo Tarifas
INSERT INTO Tarifa (codigo, numero_voo, restricoes, quantidade) VALUES
(1, 1001, 'Bagagem de mão até 10kg', 50),
(2, 1001, 'Bagagem despachada até 23kg', 30),
(3, 1002, 'Somente assento padrão', 40),
(4, 1003, 'Inclui refeição e bagagem', 20);
