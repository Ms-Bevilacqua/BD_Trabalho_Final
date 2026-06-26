-- =====================================================================
-- TORNEIO POKÉMON - Artefato 5: Visão (view)
-- =====================================================================
-- vw_ranking_treinadores: classificação consolidada do campeonato,
-- juntando pontos de ranking, total de batalhas disputadas, vitórias
-- e taxa de vitória de cada treinador. Ver 4_visao1.md para a
-- justificativa de uso.
-- =====================================================================

USE pokemon_torneio;

DROP VIEW IF EXISTS vw_ranking_treinadores;

CREATE VIEW vw_ranking_treinadores AS
SELECT
    t.id_treinador,
    t.nome,
    t.cidade,
    t.pontos_ranking,
    COUNT(b.id_batalha)                                              AS total_batalhas,
    SUM(CASE WHEN b.id_vencedor = t.id_treinador THEN 1 ELSE 0 END)  AS vitorias,
    ROUND(
        SUM(CASE WHEN b.id_vencedor = t.id_treinador THEN 1 ELSE 0 END)
        / COUNT(b.id_batalha) * 100
    , 1)                                                              AS taxa_vitoria_pct
FROM Treinador t
LEFT JOIN Batalha b
    ON t.id_treinador IN (b.id_treinador1, b.id_treinador2)
GROUP BY t.id_treinador, t.nome, t.cidade, t.pontos_ranking
ORDER BY t.pontos_ranking DESC, vitorias DESC;

-- Execução da visão: top 20 do ranking do torneio
SELECT * FROM vw_ranking_treinadores LIMIT 20;
