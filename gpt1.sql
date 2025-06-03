
CREATE DATABASE IF NOT EXISTS companhia_aerea;
USE companhia_aerea;

-- Entidade: AEROPORTO
CREATE TABLE AEROPORTO (
    Codigo_aeroporto VARCHAR(10) PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Cidade VARCHAR(100) NOT NULL,
    Estado VARCHAR(100) NOT NULL
);

-- Entidade: MODELO_AERONAVE
CREATE TABLE MODELO_AERONAVE (
    Nome_modelo VARCHAR(50) PRIMARY KEY,
    Empresa VARCHAR(50) NOT NULL,
    Maximo_assentos INT NOT NULL
);

-- Entidade: AERONAVE
CREATE TABLE AERONAVE (
    Cod_aeronave VARCHAR(20) PRIMARY KEY,
    Nome_modelo VARCHAR(50) NOT NULL,
    Numero_total_assentos INT NOT NULL,
    FOREIGN KEY (Nome_modelo) REFERENCES MODELO_AERONAVE(Nome_modelo)
);

-- Entidade: TRECHO
CREATE TABLE TRECHO (
    Numero_trecho INT PRIMARY KEY,
    Aeroporto_inicio VARCHAR(10) NOT NULL,
    Aeroporto_fim VARCHAR(10) NOT NULL,
    Horario_inicio TIME NOT NULL,
    Horario_termino TIME NOT NULL,
    FOREIGN KEY (Aeroporto_inicio) REFERENCES AEROPORTO(Codigo_aeroporto),
    FOREIGN KEY (Aeroporto_fim) REFERENCES AEROPORTO(Codigo_aeroporto)
);

-- Entidade: VOO
CREATE TABLE VOO (
    Numero INT PRIMARY KEY,
    Companhia_aerea VARCHAR(50) NOT NULL,
    Dias_da_semana VARCHAR(50) NOT NULL
);

-- Relacionamento: PERCORRE
CREATE TABLE PERCORRE (
    Numero_voo INT,
    Numero_trecho INT,
    PRIMARY KEY (Numero_voo, Numero_trecho),
    FOREIGN KEY (Numero_voo) REFERENCES VOO(Numero),
    FOREIGN KEY (Numero_trecho) REFERENCES TRECHO(Numero_trecho)
);

-- Relacionamento: TARIFADO
CREATE TABLE TARIFA (
    Codigo VARCHAR(20) PRIMARY KEY,
    Restricoes VARCHAR(100),
    Quantidade INT NOT NULL
);

CREATE TABLE TARIFADO (
    Codigo_tarifa VARCHAR(20),
    Numero_voo INT,
    PRIMARY KEY (Codigo_tarifa, Numero_voo),
    FOREIGN KEY (Codigo_tarifa) REFERENCES TARIFA(Codigo),
    FOREIGN KEY (Numero_voo) REFERENCES VOO(Numero)
);

-- Entidade: TRECHO_SOBREVOADO
CREATE TABLE TRECHO_SOBREVOADO (
    Numero_trecho INT,
    Numero_voo INT,
    Data DATE,
    Numero_assentos_disponiveis INT NOT NULL,
    Hora_partida TIME NOT NULL,
    Hora_chegada TIME NOT NULL,
    PRIMARY KEY (Numero_trecho, Numero_voo, Data),
    FOREIGN KEY (Numero_trecho) REFERENCES TRECHO(Numero_trecho),
    FOREIGN KEY (Numero_voo) REFERENCES VOO(Numero)
);

-- Relacionamento: DESIGNADA (AERONAVE designada a TRECHO_SOBREVOADO)
CREATE TABLE DESIGNADA (
    Cod_aeronave VARCHAR(20),
    Numero_trecho INT,
    Numero_voo INT,
    Data DATE,
    PRIMARY KEY (Cod_aeronave, Numero_trecho, Numero_voo, Data),
    FOREIGN KEY (Cod_aeronave) REFERENCES AERONAVE(Cod_aeronave),
    FOREIGN KEY (Numero_trecho, Numero_voo, Data) 
        REFERENCES TRECHO_SOBREVOADO(Numero_trecho, Numero_voo, Data)
);

-- Entidade: ASSENTO
CREATE TABLE ASSENTO (
    Numero_assento VARCHAR(10) PRIMARY KEY
);

-- Relacionamento: RESERVA
CREATE TABLE RESERVA (
    Numero_assento VARCHAR(10),
    Numero_trecho INT,
    Numero_voo INT,
    Data DATE,
    Nome_cliente VARCHAR(100) NOT NULL,
    Telefone_cliente VARCHAR(20) NOT NULL,
    PRIMARY KEY (Numero_assento, Numero_trecho, Numero_voo, Data),
    FOREIGN KEY (Numero_assento) REFERENCES ASSENTO(Numero_assento),
    FOREIGN KEY (Numero_trecho, Numero_voo, Data) 
        REFERENCES TRECHO_SOBREVOADO(Numero_trecho, Numero_voo, Data)
);

-- Relacionamento: PODE_POUSAR
CREATE TABLE PODE_POUSAR (
    Codigo_aeroporto VARCHAR(10),
    Nome_modelo VARCHAR(50),
    PRIMARY KEY (Codigo_aeroporto, Nome_modelo),
    FOREIGN KEY (Codigo_aeroporto) REFERENCES AEROPORTO(Codigo_aeroporto),
    FOREIGN KEY (Nome_modelo) REFERENCES MODELO_AERONAVE(Nome_modelo)
);
