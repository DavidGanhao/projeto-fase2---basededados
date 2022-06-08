drop database proj2;
create database proj2;
use proj2;


CREATE TABLE Certificado
(
  cert_certificado VARCHAR(30) NOT NULL,
  PRIMARY KEY (cert_certificado)
);

CREATE TABLE Distrito
(
  dist_distrito VARCHAR(30) NOT NULL,
  dist_codigo INT NOT NULL,
  PRIMARY KEY (dist_codigo)
);

CREATE TABLE Concelho
(
  conc_concelho VARCHAR(30) NOT NULL,
  conc_codigo INT NOT NULL,
  conc_dist_codigo INT NOT NULL,
  PRIMARY KEY (conc_codigo, conc_dist_codigo),
  FOREIGN KEY (conc_dist_codigo) REFERENCES Distrito(dist_codigo)
);

CREATE TABLE Freguesia
(
  freg_freguesia VARCHAR(30) NOT NULL,
  freg_codigo INT NOT NULL,
  freg_conc_codigo INT NOT NULL,
  freg_conc_dist_codigo INT NOT NULL,
  PRIMARY KEY (freg_codigo, freg_conc_codigo, freg_conc_dist_codigo),
  FOREIGN KEY (freg_conc_codigo, freg_conc_dist_codigo) REFERENCES Concelho(conc_codigo, conc_dist_codigo)
);

CREATE TABLE Tipologia
(
  tipol_tipologia VARCHAR(10) NOT NULL,
  PRIMARY KEY (tipol_tipologia)
);

CREATE TABLE Produto
(
  prod_nome VARCHAR(30) NOT NULL,
  PRIMARY KEY (prod_nome)
);

CREATE TABLE Serviço
(
  serv_fornecedor VARCHAR(20) NOT NULL,
  PRIMARY KEY (serv_fornecedor)
);

CREATE TABLE Características
(
  carac_caracteristica VARCHAR(30) NOT NULL,
  carac_code INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (carac_code)
);

CREATE TABLE Equipa
(
  equip_sigla VARCHAR(5) NOT NULL,
  equip_nome VARCHAR(40) NOT NULL,
  PRIMARY KEY (equip_sigla)
);

CREATE TABLE Organizador
(
  org_nome VARCHAR(40) NOT NULL,
  PRIMARY KEY (org_nome)
);

CREATE TABLE Modalidade
(
  mod_nome VARCHAR(40) NOT NULL,
  mod_code INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (mod_code)
);

CREATE TABLE Alojamento
(
  aloj_morada VARCHAR(50) NOT NULL,
  aloj_localizacao VARCHAR(10) NOT NULL,
  aloj_area INT NOT NULL,
  aloj_tipol_tipologia VARCHAR(2) NOT NULL,
  aloj_freg_codigo INT NOT NULL,
  aloj_conc_codigo INT NOT NULL,
  aloj_conc_dist_codigo INT NOT NULL,
  PRIMARY KEY (aloj_morada),
  FOREIGN KEY (aloj_tipol_tipologia) REFERENCES Tipologia(tipol_tipologia),
  FOREIGN KEY (aloj_freg_codigo, aloj_conc_codigo, aloj_conc_dist_codigo) REFERENCES Freguesia(freg_codigo, freg_conc_codigo, freg_conc_dist_codigo),
  UNIQUE (aloj_localizacao)
);

CREATE TABLE Compra
(
  comp_ip VARCHAR(20) NOT NULL,
  comp_preco INT NOT NULL,
  comp_datadecompra DATE NOT NULL,
  comp_prod_nome VARCHAR(30) NOT NULL,
  comp_serv_fornecedor VARCHAR(20) NOT NULL,
  comp_aloj_morada VARCHAR(30) NOT NULL,
  PRIMARY KEY (comp_ip, comp_prod_nome, comp_serv_fornecedor, comp_aloj_morada),
  FOREIGN KEY (comp_prod_nome) REFERENCES Produto(prod_nome),
  FOREIGN KEY (comp_serv_fornecedor) REFERENCES Serviço(serv_fornecedor),
  FOREIGN KEY (comp_aloj_morada) REFERENCES Alojamento(aloj_morada)
);

CREATE TABLE Evento
(
  even_descricao VARCHAR(100) NOT NULL,
  even_perinicio date NOT NULL,
  even_perfim date NOT NULL,
  even_nome VARCHAR(40) NOT NULL,
  even_morada VARCHAR(50) NOT NULL,
  even_code INT NOT NULL AUTO_INCREMENT,
  even_org_nome VARCHAR(50) NOT NULL,
  PRIMARY KEY (even_code),
  FOREIGN KEY (even_org_nome) REFERENCES Organizador(org_nome),
  UNIQUE (even_morada)
);

CREATE TABLE Prova
(
  prov_localizacao VARCHAR(10) NOT NULL,
  prov_id INT NOT NULL AUTO_INCREMENT,
  prov_data DATE NOT NULL,
  prov_duracao VARCHAR(30) NOT NULL,
  prov_even_code INT NOT NULL,
  prov_mod_code INT NOT NULL,
  prov_freg_codigo INT NOT NULL,
  prov_conc_codigo INT NOT NULL,
  prov_conc_dist_codigo INT NOT NULL,
  PRIMARY KEY (prov_id),
  FOREIGN KEY (prov_even_code) REFERENCES Evento(even_code),
  FOREIGN KEY (prov_mod_code) REFERENCES Modalidade(mod_code),
  FOREIGN KEY (prov_freg_codigo, prov_conc_codigo, prov_conc_dist_codigo) REFERENCES Freguesia(freg_codigo, freg_conc_codigo, freg_conc_dist_codigo)
);

CREATE TABLE CaracteristicasAloj
(
  caracaloj_aloj_morada VARCHAR(50) NOT NULL,
  caracaloj_carac_code INT NOT NULL,
  PRIMARY KEY (caracaloj_aloj_morada,caracaloj_carac_code),
  FOREIGN KEY (caracaloj_aloj_morada) REFERENCES Alojamento(aloj_morada),
  FOREIGN KEY (caracaloj_carac_code) REFERENCES Características(carac_code)
);

CREATE TABLE EquipaEvento
(
  eqev_equip_sigla VARCHAR(5) NOT NULL,
  eqev_even_code INT NOT NULL,
  PRIMARY KEY (eqev_equip_sigla, eqev_even_code),
  FOREIGN KEY (eqev_equip_sigla) REFERENCES Equipa(equip_sigla),
  FOREIGN KEY (eqev_even_code) REFERENCES Evento(even_code)
);

CREATE TABLE Participante
(
  par_sexo CHAR(1) NOT NULL,
  par_nome VARCHAR(30) NOT NULL,
  par_id INT NOT NULL AUTO_INCREMENT,
  par_dnsc DATE NOT NULL,
  par_aloj_morada VARCHAR(30),
  PRIMARY KEY (par_id),
  FOREIGN KEY (par_aloj_morada) REFERENCES Alojamento(aloj_morada)
);

CREATE TABLE Treinador
(
  trein_par_id INT NOT NULL,
  trein_cert_certificado VARCHAR(30) NOT NULL,
  PRIMARY KEY (trein_par_id),
  FOREIGN KEY (trein_par_id) REFERENCES Participante(par_id),
  FOREIGN KEY (trein_cert_certificado) REFERENCES Certificado(cert_certificado)
);

CREATE TABLE Atleta
(
  atlet_peso INT NOT NULL,
  atlet_altura FLOAT NOT NULL,
  atlet_par_id INT NOT NULL,
  PRIMARY KEY (atlet_par_id),
  FOREIGN KEY (atlet_par_id) REFERENCES Participante(par_id)
);

CREATE TABLE Resultados
(
  res_classificacao INT NOT NULL,
  res_atlet_par_id INT NOT NULL,
  res_prov_id INT NOT NULL,
  PRIMARY KEY (res_atlet_par_id, res_prov_id),
  FOREIGN KEY (res_atlet_par_id) REFERENCES Atleta(atlet_par_id),
  FOREIGN KEY (res_prov_id) REFERENCES Prova(prov_id)
);

CREATE TABLE ParticipanteEquipa
(
  parequip_equip_sigla VARCHAR(5) NOT NULL,
  parequip_par_id INT NOT NULL,
  PRIMARY KEY (parequip_equip_sigla, parequip_par_id),
  FOREIGN KEY (parequip_equip_sigla) REFERENCES Equipa(equip_sigla),
  FOREIGN KEY (parequip_par_id) REFERENCES Participante(par_id)
);