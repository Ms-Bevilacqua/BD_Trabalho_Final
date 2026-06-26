-- =====================================================================
-- TORNEIO POKÉMON - Artefato 4: Trigger (gatilho)
-- =====================================================================
-- Regra de negócio (ver 3_trigger.md para a explicação completa):
-- Sempre que uma nova Batalha é registrada com um vencedor definido,
-- o ranking desse treinador deve ser atualizado automaticamente,
-- recompensando tanto a vitória em si quanto o nível médio do time
-- utilizado (incentivando o treinador a desenvolver seus Pokémon, e
-- não apenas acumular vitórias).
--
-- Tabelas envolvidas no gatilho:
--   - SELECT em `Time_Treinador` (avalia a força do time vencedor)
--   - UPDATE em `Treinador`      (aplica a pontuação)
-- =====================================================================

USE pokemon_torneio;

DROP TRIGGER IF EXISTS trg_atualiza_ranking_pos_batalha;

DELIMITER $$

CREATE TRIGGER trg_atualiza_ranking_pos_batalha
AFTER INSERT ON Batalha
FOR EACH ROW
BEGIN
    DECLARE nivel_medio_time DECIMAL(6,2);
    DECLARE pontos_bonus INT;

    IF NEW.id_vencedor IS NOT NULL THEN

        -- (1) Operação de SELEÇÃO sobre Time_Treinador: calcula o
        --     nível médio dos Pokémon do treinador vencedor.
        SELECT AVG(nivel) INTO nivel_medio_time
        FROM Time_Treinador
        WHERE id_treinador = NEW.id_vencedor;

        SET pontos_bonus = 3 + ROUND(IFNULL(nivel_medio_time, 0) / 10);

        -- (2) Atualização em Treinador: soma os pontos de ranking
        --     (3 pontos fixos pela vitória + bônus pelo nível médio
        --     do time, arredondado a cada 10 níveis).
        UPDATE Treinador
        SET pontos_ranking = pontos_ranking + pontos_bonus
        WHERE id_treinador = NEW.id_vencedor;

    END IF;
END$$

DELIMITER ;
