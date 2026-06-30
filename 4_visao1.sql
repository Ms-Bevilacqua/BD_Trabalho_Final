
-- A visão exibe o ranking dos treinadores do torneio Pokémon,
-- ordenando os competidores pela pontuação em ordem decrescente.

USE `Pokemon_Torneio`;

-- Remove a visão caso ela já exista
DROP VIEW IF EXISTS `vw_ranking_treinadores`;

-- Criação
CREATE VIEW `vw_ranking_treinadores` AS
SELECT
  `id_treinador`,
  `nome`,
  `pontos_ranking`
FROM `Treinador`
ORDER BY `pontos_ranking` DESC;

-- Execução 
SELECT
  `id_treinador`,
  `nome`,
  `pontos_ranking`
FROM `vw_ranking_treinadores`
ORDER BY `pontos_ranking` DESC;
