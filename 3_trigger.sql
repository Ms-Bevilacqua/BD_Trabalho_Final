USE `mydb`;

DELIMITER $$

CREATE TRIGGER trg_atualiza_ranking_batalha
AFTER INSERT ON Batalha
FOR EACH ROW 
BEGIN 
    UPDATE Treinador 
    Set pontos_ranking = pontos_ranking +3
    WHERE id_treinador = NEW.id_vencedor;

    UPDATE Treinador 
    SET pontos_ranking = pontos_ranking +1
    WHERE id_treinador IN
    (
      NEW.Treinador_id_treinador,
      NEW.Treinador_id_treinador1

    )
    AND id_treinador <> NEW.id_vencedor;
END $$ 

DELIMITER;