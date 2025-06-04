INSERT INTO Aeroporto VALUES 
('GRU', 'Aeroporto Internacional de Guarulhos', 'São Paulo', 'SP'),
('GIG', 'Aeroporto Internacional do Galeão', 'Rio de Janeiro', 'RJ'),
('BSB', 'Aeroporto Internacional de Brasília', 'Brasília', 'DF'),
('SSA', 'Aeroporto Internacional de Salvador', 'Salvador', 'BA'),
('REC', 'Aeroporto Internacional do Recife', 'Recife', 'PE');



INSERT INTO Modelo_Aeronave VALUES 
('Boeing 737', 'Boeing', 180),
('Airbus A320', 'Airbus', 170),
('Embraer E195', 'Embraer', 124),
('Boeing 777', 'Boeing', 396);


INSERT INTO Pode_Pousar VALUES 
('Boeing 737', 'GRU'),
('Boeing 737', 'GIG'),
('Airbus A320', 'GRU'),
('Airbus A320', 'BSB'),
('Embraer E195', 'SSA'),
('Embraer E195', 'REC'),
('Boeing 777', 'GRU'),
('Boeing 777', 'GIG');

INSERT INTO Aeronave VALUES 
('PT-ABC', 180, 'Boeing 737'),
('PT-DEF', 170, 'Airbus A320'),
('PT-GHI', 124, 'Embraer E195'),
('PT-JKL', 396, 'Boeing 777');

INSERT INTO Voo (companhia_aerea, Dia_da_semana) VALUES 
('LATAM', 'Segunda'),
('GOL', 'Terça'),
('AZUL', 'Quarta');

INSERT INTO Trecho (horario_inicio, horario_termino, codigo_aeroporto_origem, codigo_aeroporto_destino, numero_voo) VALUES
('08:00:00', '10:00:00', 'GRU', 'GIG', 1),
('12:00:00', '14:00:00', 'GIG', 'BSB', 1),
('16:00:00', '18:00:00', 'BSB', 'REC', 2),
('09:00:00', '11:00:00', 'SSA', 'GRU', 3);


INSERT INTO Trecho_Sobrevoado VALUES 
('2025-06-10', 1, 'PT-ABC', 'GRU', '08:00:00', 'GIG', '10:00:00', 50),
('2025-06-10', 2, 'PT-DEF', 'GIG', '12:00:00', 'BSB', '14:00:00', 60),
('2025-06-11', 3, 'PT-GHI', 'BSB', '16:00:00', 'REC', '18:00:00', 40),
('2025-06-12', 4, 'PT-JKL', 'SSA', '09:00:00', 'GRU', '11:00:00', 100);


INSERT INTO Tarifa (numero_voo, restricoes, quantidade) VALUES 
(1, 'Reembolsável', 20),
(1, 'Não-reembolsável', 30),
(2, 'Bagagem incluída', 15),
(3, 'Assento premium', 10);


INSERT INTO Assento VALUES 
('1A', 1, '2025-06-10', 'Maria Silva', '11999999999'),
('1B', 1, '2025-06-10', 'João Pereira', '21988888888'),
('2A', 2, '2025-06-10', 'Carlos Souza', '61977777777'),
('3C', 3, '2025-06-11', 'Ana Costa', '81966666666'),
('4D', 4, '2025-06-12', 'Fernanda Lima', '71955555555');


