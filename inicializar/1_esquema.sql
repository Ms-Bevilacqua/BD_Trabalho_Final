-- =====================================================================
-- TORNEIO POKÉMON - Artefato 2: Esquema do Banco de Dados
-- Disciplina: Banco de Dados I - UFMT
-- =====================================================================
-- Este script cria o banco de dados e as 6 tabelas do sistema:
-- 5 entidades principais (Treinador, Pokemon, Time_Treinador, Golpe,
-- Batalha) + 1 tabela associativa (Time_Treinador_Golpe), necessária
-- para resolver corretamente o relacionamento N:M entre golpes e os
-- Pokémon de cada time (ver observações de normalização no arquivo
-- 1_esquema.md).
-- =====================================================================

SET @OLD_FOREIGN_KEY_CHECKS = @@FOREIGN_KEY_CHECKS;
SET FOREIGN_KEY_CHECKS = 0;

CREATE DATABASE IF NOT EXISTS pokemon_torneio
  CHARACTER SET = utf8mb4
  COLLATE = utf8mb4_unicode_ci;

USE pokemon_torneio;

-- ---------------------------------------------------------------------
-- Tabela `Treinador`
-- Competidores inscritos no torneio.
-- ---------------------------------------------------------------------
DROP TABLE IF EXISTS `Treinador`;
CREATE TABLE `Treinador` (
  `id_treinador`    INT NOT NULL AUTO_INCREMENT,
  `nome`            VARCHAR(100) NOT NULL,
  `cidade`          VARCHAR(50)  NOT NULL,
  `data_inscricao`  DATE NOT NULL,
  `pontos_ranking`  INT NOT NULL DEFAULT 0,
  PRIMARY KEY (`id_treinador`)
) ENGINE = InnoDB;


-- ---------------------------------------------------------------------
-- Tabela `Pokemon`
-- Catálogo geral de espécies disponíveis no torneio.
-- `evolui_para_id` é uma FK auto-relacionada que indica para qual
-- espécie este Pokémon evolui (alimentada pela seção de evolução da
-- PokeAPI). É NULL quando a espécie não evolui (ou é a forma final).
-- ---------------------------------------------------------------------
DROP TABLE IF EXISTS `Pokemon`;
CREATE TABLE `Pokemon` (
  `id_especie`        INT NOT NULL AUTO_INCREMENT,
  `nome_especie`      VARCHAR(50) NOT NULL,
  `tipo_base`         VARCHAR(30) NOT NULL,
  `tipo_secundario`   VARCHAR(30) NULL,
  `hp_base`           INT NOT NULL,
  `ataque_base`       INT NOT NULL,
  `defesa_base`       INT NOT NULL,
  `velocidade_base`   INT NOT NULL,
  `evolui_para_id`    INT NULL,
  PRIMARY KEY (`id_especie`),
  INDEX `fk_Pokemon_Evolucao_idx` (`evolui_para_id` ASC),
  CONSTRAINT `fk_Pokemon_Evolucao`
    FOREIGN KEY (`evolui_para_id`)
    REFERENCES `Pokemon` (`id_especie`)
    ON DELETE SET NULL
    ON UPDATE CASCADE
) ENGINE = InnoDB;


-- ---------------------------------------------------------------------
-- Tabela `Golpe`
-- Catálogo independente de habilidades de batalha. Antes esta tabela
-- tinha uma FK direta para Time_Treinador, o que obrigaria a repetir
-- nome/tipo/poder/PP de um mesmo golpe (ex: "Tackle") uma vez para
-- cada Pokémon que o usasse — quebra de normalização (redundância).
-- Agora é um catálogo único, e a posse é resolvida na tabela
-- associativa `Time_Treinador_Golpe`.
-- ---------------------------------------------------------------------
DROP TABLE IF EXISTS `Golpe`;
CREATE TABLE `Golpe` (
  `id_golpe`    INT NOT NULL AUTO_INCREMENT,
  `nome`        VARCHAR(50) NOT NULL,
  `tipo`        VARCHAR(30) NOT NULL,
  `categoria`   ENUM('Fisico','Especial','Status') NOT NULL,
  `poder`       INT NULL,
  `precisao`    INT NULL,
  `pp_maximo`   INT NOT NULL,
  PRIMARY KEY (`id_golpe`)
) ENGINE = InnoDB;


-- ---------------------------------------------------------------------
-- Tabela `Time_Treinador`
-- Instância real de um Pokémon capturado por um treinador (nível,
-- apelido, experiência). É o elo entre Treinador e Pokemon.
-- ---------------------------------------------------------------------
DROP TABLE IF EXISTS `Time_Treinador`;
CREATE TABLE `Time_Treinador` (
  `id_instancia`   INT NOT NULL AUTO_INCREMENT,
  `apelido`        VARCHAR(50) NULL,
  `nivel`          INT NOT NULL,
  `experiencia`    INT NOT NULL DEFAULT 0,
  `data_captura`   DATE NOT NULL,
  `id_treinador`   INT NOT NULL,
  `id_especie`     INT NOT NULL,
  PRIMARY KEY (`id_instancia`),
  INDEX `fk_TimeTreinador_Treinador_idx` (`id_treinador` ASC),
  INDEX `fk_TimeTreinador_Pokemon_idx` (`id_especie` ASC),
  CONSTRAINT `fk_TimeTreinador_Treinador`
    FOREIGN KEY (`id_treinador`)
    REFERENCES `Treinador` (`id_treinador`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_TimeTreinador_Pokemon`
    FOREIGN KEY (`id_especie`)
    REFERENCES `Pokemon` (`id_especie`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
) ENGINE = InnoDB;


-- ---------------------------------------------------------------------
-- Tabela `Time_Treinador_Golpe` (associativa N:M)
-- Quais golpes cada instância de Pokémon do time conhece. Resolve o
-- relacionamento muitos-para-muitos entre Time_Treinador e Golpe.
-- ---------------------------------------------------------------------
DROP TABLE IF EXISTS `Time_Treinador_Golpe`;
CREATE TABLE `Time_Treinador_Golpe` (
  `id_instancia`  INT NOT NULL,
  `id_golpe`      INT NOT NULL,
  PRIMARY KEY (`id_instancia`, `id_golpe`),
  INDEX `fk_TTG_Golpe_idx` (`id_golpe` ASC),
  CONSTRAINT `fk_TTG_Instancia`
    FOREIGN KEY (`id_instancia`)
    REFERENCES `Time_Treinador` (`id_instancia`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_TTG_Golpe`
    FOREIGN KEY (`id_golpe`)
    REFERENCES `Golpe` (`id_golpe`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE
) ENGINE = InnoDB;


-- ---------------------------------------------------------------------
-- Tabela `Batalha`
-- Histórico oficial das partidas do torneio. Antes faltavam as
-- colunas `local_batalha` e `id_vencedor`, que o próprio GRUPO.md já
-- previa como parte do escopo da tabela.
-- ---------------------------------------------------------------------
DROP TABLE IF EXISTS `Batalha`;
CREATE TABLE `Batalha` (
  `id_batalha`      INT NOT NULL AUTO_INCREMENT,
  `data_batalha`    DATE NOT NULL,
  `local_batalha`   VARCHAR(100) NOT NULL,
  `fase_torneio`    VARCHAR(50) NOT NULL,
  `id_treinador1`   INT NOT NULL,
  `id_treinador2`   INT NOT NULL,
  `id_vencedor`     INT NULL,
  PRIMARY KEY (`id_batalha`),
  INDEX `fk_Batalha_Treinador1_idx` (`id_treinador1` ASC),
  INDEX `fk_Batalha_Treinador2_idx` (`id_treinador2` ASC),
  INDEX `fk_Batalha_Vencedor_idx` (`id_vencedor` ASC),
  CONSTRAINT `fk_Batalha_Treinador1`
    FOREIGN KEY (`id_treinador1`)
    REFERENCES `Treinador` (`id_treinador`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_Batalha_Treinador2`
    FOREIGN KEY (`id_treinador2`)
    REFERENCES `Treinador` (`id_treinador`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `fk_Batalha_Vencedor`
    FOREIGN KEY (`id_vencedor`)
    REFERENCES `Treinador` (`id_treinador`)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT `chk_Batalha_Treinadores_Diferentes`
    CHECK (`id_treinador1` <> `id_treinador2`)
) ENGINE = InnoDB;

SET FOREIGN_KEY_CHECKS = @OLD_FOREIGN_KEY_CHECKS;
