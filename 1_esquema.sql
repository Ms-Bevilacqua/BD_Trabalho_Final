-- =============================================================
-- Torneio Pokémon — Esquema do banco de dados
-- =============================================================

CREATE DATABASE IF NOT EXISTS `Pokemon_Torneio`
  DEFAULT CHARACTER SET utf8mb4
  DEFAULT COLLATE utf8mb4_unicode_ci;

USE `Pokemon_Torneio`;

SET FOREIGN_KEY_CHECKS = 0;

-- -----------------------------------------------------
-- Table `Pokemon_Torneio`.`Treinador`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Treinador` (
  `id_treinador`   INT          NOT NULL,
  `nome`           VARCHAR(100) NOT NULL,
  `cidade`         VARCHAR(50)  NOT NULL,
  `pontos_ranking` INT          NULL DEFAULT 0,
  `data_inscricao` DATE         NULL,
  PRIMARY KEY (`id_treinador`)
) ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pokemon_Torneio`.`Pokemon`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pokemon` (
  `id_especie`      INT         NOT NULL,
  `nome_especie`    VARCHAR(50) NOT NULL,
  `tipo_base`       VARCHAR(30) NOT NULL,
  `tipo_secundario` VARCHAR(30) NULL,
  `evolui_para_id`  INT         NULL,
  PRIMARY KEY (`id_especie`),
  INDEX `fk_Pokemon_evolui_para_idx` (`evolui_para_id` ASC),
  CONSTRAINT `fk_Pokemon_evolui_para`
    FOREIGN KEY (`evolui_para_id`)
    REFERENCES `Pokemon` (`id_especie`)
    ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pokemon_Torneio`.`Time_Treinador`
-- Tabela associativa entre Treinador e Pokemon:
-- registra quais espécies cada treinador inscreveu
-- no torneio e em qual posição do time (1 a 6).
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Time_Treinador` (
  `Treinador_id_treinador` INT NOT NULL,
  `Pokemon_id_especie`     INT NOT NULL,
  `posicao_no_time`        INT NOT NULL COMMENT 'Posição no time: 1 (líder) a 6',
  PRIMARY KEY (`Treinador_id_treinador`, `Pokemon_id_especie`),
  UNIQUE KEY `uq_time_posicao` (`Treinador_id_treinador`, `posicao_no_time`),
  INDEX `fk_Time_Treinador_Treinador_idx` (`Treinador_id_treinador` ASC),
  INDEX `fk_Time_Treinador_Pokemon1_idx`  (`Pokemon_id_especie`     ASC),
  CONSTRAINT `fk_Time_Treinador_Treinador`
    FOREIGN KEY (`Treinador_id_treinador`)
    REFERENCES `Treinador` (`id_treinador`)
    ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Time_Treinador_Pokemon1`
    FOREIGN KEY (`Pokemon_id_especie`)
    REFERENCES `Pokemon` (`id_especie`)
    ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pokemon_Torneio`.`Golpe`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Golpe` (
  `id_golpe`  INT         NOT NULL,
  `nome`      VARCHAR(50) NOT NULL,
  `tipo`      VARCHAR(30) NOT NULL,
  `poder`     INT         NULL,
  `precisao`  INT         NULL,
  `pp_maximo` INT         NULL,
  PRIMARY KEY (`id_golpe`)
) ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Pokemon_Torneio`.`Batalha`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Batalha` (
  `id_batalha`             INT         NOT NULL,
  `data_batalha`           DATE        NOT NULL,
  `fase_torneio`           VARCHAR(50) NOT NULL,
  `Treinador_id_treinador`  INT        NOT NULL,
  `Treinador_id_treinador1` INT        NOT NULL,
  `id_vencedor`            INT         NOT NULL,
  PRIMARY KEY (`id_batalha`),
  INDEX `fk_Batalha_Treinador1_idx`  (`Treinador_id_treinador`  ASC),
  INDEX `fk_Batalha_Treinador2_idx`  (`Treinador_id_treinador1` ASC),
  INDEX `fk_Batalha_vencedor_idx`    (`id_vencedor`             ASC),
  CONSTRAINT `fk_Batalha_Treinador1`
    FOREIGN KEY (`Treinador_id_treinador`)
    REFERENCES `Treinador` (`id_treinador`)
    ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Batalha_Treinador2`
    FOREIGN KEY (`Treinador_id_treinador1`)
    REFERENCES `Treinador` (`id_treinador`)
    ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Batalha_vencedor`
    FOREIGN KEY (`id_vencedor`)
    REFERENCES `Treinador` (`id_treinador`)
    ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB;

SET FOREIGN_KEY_CHECKS = 1;

