USE Pokemon_Torneio;

DELIMITER $$

CREATE TRIGGER trg_limite_6
BEFORE INSERT ON Time_Treinador
FOR EACH ROW
BEGIN
    DECLARE total_pokemon INT;

    SELECT COUNT(*)
    INTO total_pokemon
    FROM Time_Treinador
    WHERE Treinador_id_treinador = NEW.Treinador_id_treinador;

    IF total_pokemon >= 6 THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Limite máximo de participantes atingido para este treinador.';
    END IF;
END $$

DELIMITER ;

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
    WHERE id_treinador IN (
        NEW.Treinador_id_treinador,
        NEW.Treinador_id_treinador1
    )
    AND id_treinador <> NEW.id_vencedor;
END $$

DELIMITER ;