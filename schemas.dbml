Table "Aeroporto" {
  "codigo_aeroporto" VARCHAR(10) [pk, not null]
  "nome" VARCHAR(100) [not null]
  "cidade" VARCHAR(100) [not null]
  "estado" VARCHAR(2) [not null]
}

Table "Modelo_Aeronave" {
  "nome_modelo" VARCHAR(50) [pk, not null]
  "empresa" VARCHAR(100) [not null]
  "maximo_assentos" INT [not null]
}

Table "Pode_Pousar" {
  "nome_modelo" VARCHAR(50) [not null]
  "codigo_aeroporto" VARCHAR(10) [not null]

  Indexes {
    (nome_modelo, codigo_aeroporto) [pk]
  }
}

Table "Aeronave" {
  "cod_aeronave" VARCHAR(20) [pk, not null]
  "numero_total_assentos" INT [not null]
  "nome_modelo" VARCHAR(50) [not null]
}

Table "Trecho" {
  "numero_trecho" INT [not null, increment]
  "horario_inicio" TIME [not null]
  "horario_termino" TIME [not null]
  "codigo_aeroporto_origem" VARCHAR(10) [not null]
  "codigo_aeroporto_destino" VARCHAR(10) [not null]
  "numero_voo" INT [not null]
}

Table "Voo" {
  "numero_voo" INT [pk, not null, increment]
  "companhia_aerea" VARCHAR(100) [not null]
  "Dia_da_semana" VARCHAR(100) [not null]
}

Table "Trecho_Sobrevoado" {
  "numero_trecho" INT [not null]
  "data" DATE [not null, pk]
  "cod_aeronave" VARCHAR(20) [not null]
  "hora_partida" TIME [not null]
  "codigo_aeroporto_chegada" VARCHAR(10) [not null]
  "hora_chegada" TIME [not null]
  "num_ordem_ocorrencia" INT [not null]
  "numero_assentos_disponiveis" INT [not null]

  Indexes {
    (numero_trecho, data) [pk]
    // numero_voo [name: "IX_TS_VOO"]
    cod_aeronave [name: "IX_TS_AERONAVE"]
    codigo_aeroporto_chegada [name: "IX_TS_AEROPORTOCHEGADA"]
  }
}

Table "Tarifa" {
  "codigo" INT [pk, not null, increment]
  "numero_voo" INT [not null]
  "restricoes" VARCHAR(255)
  "quantidade" INT [not null]
}


Table "Assento" {
  "numero_assento" VARCHAR(10) [pk, not null]
  "numero_trecho" INT [not null]
  "data" DATE [not null]
  "nome_cliente" VARCHAR(100) [not null]
  "telefone_cliente" VARCHAR(20) [not null]

  Indexes {
    (numero_trecho, data, numero_assento) [pk]
    (numero_trecho, data) [name: "IX_Res_TS"]
    numero_assento [name: "IX_Res_Assento"]
  }
}

Ref:"Modelo_Aeronave"."nome_modelo" < "Pode_Pousar"."nome_modelo" [update: cascade, delete: cascade]

Ref:"Aeroporto"."codigo_aeroporto" < "Pode_Pousar"."codigo_aeroporto" [update: cascade, delete: cascade]

Ref:"Modelo_Aeronave"."nome_modelo" < "Aeronave"."nome_modelo" [update: cascade, delete: restrict]

Ref "FK_Trecho_Origem":"Aeroporto"."codigo_aeroporto" < "Trecho"."codigo_aeroporto_origem" [update: cascade, delete: restrict]

Ref "FK_Trecho_Destino":"Aeroporto"."codigo_aeroporto" < "Trecho"."codigo_aeroporto_destino" [update: cascade, delete: restrict]

Ref "FK_TS_Trecho":"Trecho"."numero_trecho" < "Trecho_Sobrevoado"."numero_trecho" [update: cascade, delete: restrict]

Ref "FK_TS_Voo":"Voo"."numero_voo" < "Trecho"."numero_voo" [update: cascade, delete: restrict]

Ref "FK_TS_Aeronave":"Aeronave"."cod_aeronave" < "Trecho_Sobrevoado"."cod_aeronave" [update: cascade, delete: restrict]

Ref "FK_TS_AeroportoChegada":"Aeroporto"."codigo_aeroporto" < "Trecho_Sobrevoado"."codigo_aeroporto_chegada" [update: cascade, delete: restrict]

Ref "FK_Tarifa_Voo":"Voo"."numero_voo" < "Tarifa"."numero_voo" [update: cascade, delete: cascade]

Ref "FK_Res_TS":"Trecho_Sobrevoado".("numero_trecho", "data") < "Assento".("numero_trecho", "data") [update: cascade, delete: cascade]
