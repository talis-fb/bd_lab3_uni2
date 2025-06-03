-- -------------------------------------------------------------------
-- 1) Tabela: AEROPORTO
-- -------------------------------------------------------------------
CREATE TABLE Aeroporto (
  codigo_aeroporto      VARCHAR(10)    NOT NULL PRIMARY KEY,
  nome                  VARCHAR(100)   NOT NULL,
  cidade                VARCHAR(100)   NOT NULL,
  estado                VARCHAR(50)    NOT NULL
) ENGINE = InnoDB;


-- -------------------------------------------------------------------
-- 2) Tabela: MODELO_AERONAVE
-- -------------------------------------------------------------------
CREATE TABLE Modelo_Aeronave (
  nome_modelo           VARCHAR(50)    NOT NULL PRIMARY KEY,
  empresa               VARCHAR(100)   NOT NULL,
  maximo_assentos       INT            NOT NULL
) ENGINE = InnoDB;


-- -------------------------------------------------------------------
-- 3) Tabela associativa: PODE_POUSAR
--    (relacionamento M‐N entre Modelo_Aeronave e Aeroporto)
-- -------------------------------------------------------------------
CREATE TABLE Pode_Pousar (
  nome_modelo           VARCHAR(50)    NOT NULL,
  codigo_aeroporto      VARCHAR(10)    NOT NULL,
  PRIMARY KEY (nome_modelo, codigo_aeroporto),
  FOREIGN KEY (nome_modelo)
    REFERENCES Modelo_Aeronave(nome_modelo)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
  FOREIGN KEY (codigo_aeroporto)
    REFERENCES Aeroporto(codigo_aeroporto)
    ON UPDATE CASCADE
    ON DELETE CASCADE
) ENGINE = InnoDB;


-- -------------------------------------------------------------------
-- 4) Tabela: AERONAVE
--    (cada Aeronave pertence a exatamente um Modelo_Aeronave)
-- -------------------------------------------------------------------
CREATE TABLE Aeronave (
  cod_aeronave          VARCHAR(20)    NOT NULL PRIMARY KEY,
  numero_total_assentos INT            NOT NULL,
  nome_modelo           VARCHAR(50)    NOT NULL,
  FOREIGN KEY (nome_modelo)
    REFERENCES Modelo_Aeronave(nome_modelo)
    ON UPDATE CASCADE
    ON DELETE RESTRICT
) ENGINE = InnoDB;


-- -------------------------------------------------------------------
-- 5) Tabela: TRECHO
--    (segmento genérico, com origem, destino e horários “template”)
--   - “INICIA”: aeroporto de origem (1 → N TRECHO) com atributo Horario_inicio
--   - “FINALIZA”: aeroporto de destino (1 → N TRECHO) com atributo Horario_termino
-- -------------------------------------------------------------------
CREATE TABLE Trecho (
  numero_trecho            INT            NOT NULL AUTO_INCREMENT,
  codigo_aeroporto_origem  VARCHAR(10)    NOT NULL,
  codigo_aeroporto_destino VARCHAR(10)    NOT NULL,
  horario_inicio           TIME           NOT NULL,
  horario_termino          TIME           NOT NULL,
  PRIMARY KEY (numero_trecho),
  CONSTRAINT FK_Trecho_Origem
    FOREIGN KEY (codigo_aeroporto_origem)
    REFERENCES Aeroporto(codigo_aeroporto)
    ON UPDATE CASCADE
    ON DELETE RESTRICT,
  CONSTRAINT FK_Trecho_Destino
    FOREIGN KEY (codigo_aeroporto_destino)
    REFERENCES Aeroporto(codigo_aeroporto)
    ON UPDATE CASCADE
    ON DELETE RESTRICT
) ENGINE = InnoDB;


-- -------------------------------------------------------------------
-- 6) Tabela: VOO
-- -------------------------------------------------------------------
CREATE TABLE Voo (
  voo_id                   INT            NOT NULL AUTO_INCREMENT PRIMARY KEY,
  companhia_aerea          VARCHAR(100)   NOT NULL
) ENGINE = InnoDB;


-- -------------------------------------------------------------------
-- 7) Tabela: TRECHO_SOBREVOADO
--    (ocorrência específica de um TRECHO em uma data, 
--     relaciona‐se a um VOO e a uma AERONAVE,
--     registra hora de partida e hora de chegada)
--   - Chave composta: (numero_trecho, data)
--   - Relacionamento “OCORRE”: cada Trecho_Sobrevoado pertence a exatamente um Voo
--         → vamos colocar voo_id como FK aqui e também o atributo “num_ocorrencia”
--   - Relacionamento “ATRIBUIDO”: cada Trecho_Sobrevoado recebe 1 Aeronave → 
--         FK cod_aeronave e atributo hora_partida
--   - Relacionamento “CHEGADA”: cada Trecho_Sobrevoado chega a 1 Aeroporto →
--         FK codigo_aeroporto_chegada e atributo hora_chegada
-- -------------------------------------------------------------------
CREATE TABLE Trecho_Sobrevoado (
  numero_trecho           INT            NOT NULL,
  data                    DATE           NOT NULL,
  voo_id                  INT            NOT NULL,
  cod_aeronave            VARCHAR(20)    NOT NULL,
  hora_partida            TIME           NOT NULL,
  codigo_aeroporto_chegada VARCHAR(10)   NOT NULL,
  hora_chegada            TIME           NOT NULL,
  num_ordem_ocorrencia    INT            NOT NULL,  -- “Numero” do relacionamento OCORRE (ordem do segmento no voo)
  PRIMARY KEY (numero_trecho, data),
  INDEX IX_TS_VOO (voo_id),
  INDEX IX_TS_AERONAVE (cod_aeronave),
  INDEX IX_TS_AEROPORTOCHEGADA (codigo_aeroporto_chegada),
  CONSTRAINT FK_TS_Trecho
    FOREIGN KEY (numero_trecho)
    REFERENCES Trecho(numero_trecho)
    ON UPDATE CASCADE
    ON DELETE RESTRICT,
  CONSTRAINT FK_TS_Voo
    FOREIGN KEY (voo_id)
    REFERENCES Voo(voo_id)
    ON UPDATE CASCADE
    ON DELETE RESTRICT,
  CONSTRAINT FK_TS_Aeronave
    FOREIGN KEY (cod_aeronave)
    REFERENCES Aeronave(cod_aeronave)
    ON UPDATE CASCADE
    ON DELETE RESTRICT,
  CONSTRAINT FK_TS_AeroportoChegada
    FOREIGN KEY (codigo_aeroporto_chegada)
    REFERENCES Aeroporto(codigo_aeroporto)
    ON UPDATE CASCADE
    ON DELETE RESTRICT
) ENGINE = InnoDB;


-- -------------------------------------------------------------------
-- 8) Tabela: TARIFA
--    (tarifas associadas a cada voo)
--    - Atributos da relação TARIFADO: dias_da_semana, restricoes, quantidade
--    - Chave primária própria: codigo
--    - Chave estrangeira para Voo (1 → N)
-- -------------------------------------------------------------------
CREATE TABLE Tarifa (
  codigo                    INT            NOT NULL AUTO_INCREMENT PRIMARY KEY,
  voo_id                    INT            NOT NULL,
  numero_assentos_disponiveis INT           NOT NULL,
  dias_da_semana            VARCHAR(50)    NULL,   -- ex: “Seg,Ter,Qua”
  restricoes                VARCHAR(255)   NULL,   -- ex: “Sem bagagem”, “Classe executiva”
  quantidade                INT            NOT NULL,
  CONSTRAINT FK_Tarifa_Voo
    FOREIGN KEY (voo_id)
    REFERENCES Voo(voo_id)
    ON UPDATE CASCADE
    ON DELETE CASCADE
) ENGINE = InnoDB;


-- -------------------------------------------------------------------
-- 9) Tabela: ASSENTO
-- -------------------------------------------------------------------
CREATE TABLE Assento (
  numero_assento            VARCHAR(10)    NOT NULL PRIMARY KEY
) ENGINE = InnoDB;


-- -------------------------------------------------------------------
-- 10) Tabela: RESERVA
--     (relacionamento entre Assento e Trecho_Sobrevoado, com atributos
--      nome_cliente e telefone_cliente)
--   - Cada Reserva ocupa um Assento em UMA instância de Trecho_Sobrevoado
--   - Cardinalidade: Trecho_Sobrevoado 1 → N Reservas (um segmento ocorrido pode ter várias reservas)
--                    Assento 1 → N Reservas (um mesmo assento pode ser reservado em instâncias diferentes)
--   - Atributos: nome_cliente, telefone_cliente
--   - PK composta: (numero_trecho, data, numero_assento)
-- -------------------------------------------------------------------
CREATE TABLE Reserva (
  numero_trecho            INT            NOT NULL,
  data                     DATE           NOT NULL,
  numero_assento           VARCHAR(10)    NOT NULL,
  nome_cliente             VARCHAR(100)   NOT NULL,
  telefone_cliente         VARCHAR(20)    NOT NULL,
  PRIMARY KEY (numero_trecho, data, numero_assento),
  INDEX IX_Res_TS (numero_trecho, data),
  INDEX IX_Res_Assento (numero_assento),
  CONSTRAINT FK_Res_TS
    FOREIGN KEY (numero_trecho, data)
    REFERENCES Trecho_Sobrevoado(numero_trecho, data)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
  CONSTRAINT FK_Res_Assento
    FOREIGN KEY (numero_assento)
    REFERENCES Assento(numero_assento)
    ON UPDATE CASCADE
    ON DELETE RESTRICT
) ENGINE = InnoDB;


-- -------------------------------------------------------------------
-- Observações gerais:
-- -------------------------------------------------------------------
-- 1) AEROPORTO
--    → Código único (PK), atributos básicos: nome, cidade, estado.
-- 2) MODELO_AERONAVE e PODE_POUSAR
--    → Um MODEL_AERONAVE “pode pousar” em vários Aeroportos e vice‐versa.
--    → Tabela associativa “Pode_Pousar” armazena essa relação M‐N sem atributos adicionais.
-- 3) AERONAVE
--    → Cada Aeronave tem um modelo (nome_modelo → FK em Modelo_Aeronave).
--    → Número total de assentos.
-- 4) TRECHO
--    → Cada TRECHO (segmento genérico) conhece seu aeroporto de origem e destino
--      (relacionamentos “INICIA” e “FINALIZA”), com horários “template” de início/fim.
--    → Para simplificar, unimos INICIA e FINALIZA diretamente como atributos dentro de Trecho:
--      ● codigo_aeroporto_origem  → FK → Aeroporto (Horario_inicio)
--      ● codigo_aeroporto_destino → FK → Aeroporto (Horario_termino)
-- 5) VOO
--    → Cada Voo tem um identificador (voo_id) e companhia aérea.
-- 6) TRECHO_SOBREVOADO
--    → Representa uma ocorrência real de um TRECHO (tema “instância” no dia X).
--    → Chave composta: (numero_trecho, data).
--    → Relacionamentos:
--       • OCORRE: cada Trecho_Sobrevoado pertence a exatamente um Voo → voo_id (FK).
--         Atributo “num_ordem_ocorrencia” armazena a ordem desse segmento dentro do voo.
--       • ATRIBUIDO: qual Aeronave vai operar esse Trecho_Sobrevoado → cod_aeronave (FK) e hora_partida.
--       • CHEGADA: o aeroporto onde o Trecho_Sobrevoado termina → codigo_aeroporto_chegada (FK) e hora_chegada.
-- 7) TARIFA
--    → Cada Voo pode ter várias Tarifas associadas.
--    → Atributos do relacionamento TARIFADO (“dias_da_semana”, “restricoes”, “quantidade”)
--      foram “respiralados” para dentro da própria tabela Tarifa.
--    → Número de assentos disponíveis (“numero_assentos_disponiveis”) também está aqui.
--    → FK voo_id para Voo (1 → N).
-- 8) ASSENTO e RESERVA
--    → ASSENTO: lista todos os assentos possíveis (cada um com um número único).
--    → RESERVA: relaciona um Assento a um Trecho_Sobrevoado, ou seja, reserva o assento
--      “numero_assento” para uma instância específica de Trecho (numero_trecho, data).
--    → Atributos adicionais de RESERVA: nome_cliente, telefone_cliente.
--    → PK composta: (numero_trecho, data, numero_assento).  

-- -------------------------------------------------------------------
-- Exemplo de ordem de criação (já apresentada acima). 
-- Lembre‐se de criar as tabelas na ordem que respeite as FKs:
--   Aeroporto → Modelo_Aeronave → Pode_Pousar → Aeronave → Trecho → Voo → Trecho_Sobrevoado → Tarifa → Assento → Reserva
-- -------------------------------------------------------------------

