-- =====================================================================
-- TORNEIO POKÉMON - Artefato 4: Ativação do Trigger (antes/depois)
-- =====================================================================
USE pokemon_torneio;

-- ---------------------------------------------------------------------
-- ANTES: estado do treinador #1 e do treinador #2 antes da batalha
-- ---------------------------------------------------------------------
SELECT id_treinador, nome, pontos_ranking AS pontos_ANTES
FROM Treinador
WHERE id_treinador IN (1, 2);

-- Nível médio atual do time do treinador #1 (referência para o cálculo
-- que o trigger fará internamente)
SELECT id_treinador, ROUND(AVG(nivel), 2) AS nivel_medio_time
FROM Time_Treinador
WHERE id_treinador = 1;

-- ---------------------------------------------------------------------
-- ATIVAÇÃO: insere uma nova batalha em que o treinador #1 vence o
-- treinador #2. Esta operação dispara o trigger
-- trg_atualiza_ranking_pos_batalha.
-- ---------------------------------------------------------------------
INSERT INTO Batalha (data_batalha, local_batalha, fase_torneio, id_treinador1, id_treinador2, id_vencedor)
VALUES (CURDATE(), 'Arena de Cuiabá', 'Final', 1, 2, 1);

-- ---------------------------------------------------------------------
-- DEPOIS: pontos_ranking do treinador #1 já reflete o bônus calculado
-- pelo trigger (3 pontos fixos + bônus pelo nível médio do time). O
-- treinador #2 (que perdeu) permanece inalterado.
-- ---------------------------------------------------------------------
SELECT id_treinador, nome, pontos_ranking AS pontos_DEPOIS
FROM Treinador
WHERE id_treinador IN (1, 2);
