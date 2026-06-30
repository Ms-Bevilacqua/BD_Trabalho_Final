-- =============================================================
-- Torneio Pokémon — Esquema do banco de dados
-- =============================================================

CREATE DATABASE IF NOT EXISTS `mydb`
  DEFAULT CHARACTER SET utf8mb4
  DEFAULT COLLATE utf8mb4_unicode_ci;

USE `mydb`;

SET FOREIGN_KEY_CHECKS = 0;

-- -----------------------------------------------------
-- Table `mydb`.`Treinador`
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
-- Table `mydb`.`Pokemon`
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
-- Table `mydb`.`Time_Treinador`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Time_Treinador` (
  `id_instancia`           INT         NOT NULL,
  `apelido`                VARCHAR(50) NULL,
  `nivel`                  INT         NOT NULL,
  `experiencia`            INT         NOT NULL,
  `data_captura`           DATE        NOT NULL,
  `Treinador_id_treinador` INT         NOT NULL,
  `Pokemon_id_especie`     INT         NOT NULL,
  PRIMARY KEY (`id_instancia`),
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
-- Table `mydb`.`Golpe`
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
-- Table `mydb`.`Batalha`
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


-- -----------------------------------------------------
-- Trigger: atualiza pontos_ranking após cada batalha
--   +3 pontos para o vencedor
--   +1 ponto para o perdedor
-- -----------------------------------------------------
DELIMITER $$

CREATE TRIGGER trg_atualiza_ranking_batalha
AFTER INSERT ON Batalha
FOR EACH ROW
BEGIN
    UPDATE Treinador
    SET pontos_ranking = pontos_ranking + 3
    WHERE id_treinador = NEW.id_vencedor;

    UPDATE Treinador
    SET pontos_ranking = pontos_ranking + 1
    WHERE id_treinador IN (NEW.Treinador_id_treinador, NEW.Treinador_id_treinador1)
      AND id_treinador <> NEW.id_vencedor;
END $$

DELIMITER ;


-- -----------------------------------------------------
-- View: ranking de treinadores por pontos
-- -----------------------------------------------------
CREATE OR REPLACE VIEW vw_ranking_treinadores AS
SELECT
    id_treinador,
    nome,
    cidade,
    pontos_ranking
FROM Treinador
ORDER BY pontos_ranking DESC;
