use `Pokemon_Torneio`;
-- Demonstrar a execução do Trigger : Atualizar ranking após batalha.
-- 1. Visualização Anterior ao trigger
SET @id_batalha_teste = 9999;
SET @treinador_1 = 101;
SET @treinador_2 = 102;

SELECT 
  'ANTES DA BATALHA' AS `momento`,
  `id_treinador`,
  `nome`,
  `pontos_ranking`
FROM `Treinador`
WHERE `id_treinador` IN (@treinador_1, @treinador_2)
ORDER BY `id_treinador`;

-- 2. Operação que ativa o trigger

-- Ao inserir esta batalha, o trigger deve atualizar automaticamente a pontuação:

-- Vencedor: +3 pontos
-- Perdedor: +1 ponto
DELETE FROM `Batalha` WHERE `id_batalha` = @id_batalha_teste;

INSERT INTO `Batalha`
(
  `id_batalha`,
  `data_batalha`,
  `fase_torneio`,
  `Treinador_id_treinador`,
  `Treinador_id_treinador1`,
  `id_vencedor`
)
VALUES
(
  @id_batalha_teste,
  CURDATE(),
  'Batalha de Teste do Trigger',
  101,
  102,
  101
);

-- 3 Visualização DEPOIS da execução do trigger

SELECT 
  'DEPOIS DA BATALHA' AS `momento`,
  `id_treinador`,
  `nome`,
  `pontos_ranking`
FROM `Treinador`
WHERE `id_treinador` IN (@treinador_1, @treinador_2)
ORDER BY `id_treinador`;