# Regras de Negócio do Trigger 1 : Atualizar Ranking Após Batalha

## 1. Descrição 
A tabela `Batalha` registra cada confronto realizado no torneio, armazenando informações como:

- ID da batalha;
- data da batalha;
- fase do torneio;
- treinador 1;
- treinador 2;
- treinador vencedor.

Já a tabela `Treinador` possui o campo `pontos_ranking`, responsável por armazenar a pontuação atual de cada competidor no campeonato.

Por isso, sempre que uma nova batalha for registrada, o ranking dos treinadores envolvidos precisa ser atualizado automaticamente.

---

## 2. Trigger Relacionada

A trigger responsável por essa regra é:

```sql
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
  WHERE id_treinador IN 
  (
    NEW.Treinador_id_treinador,
    NEW.Treinador_id_treinador1
  )
  AND id_treinador <> NEW.id_vencedor;
END $$

DELIMITER ;
```

---

## 3. Objetivo da Trigger

O objetivo da trigger é **automatizar a atualização da pontuação dos treinadores no ranking** após o cadastro de uma nova batalha.

Sem essa trigger, o usuário teria que:

1. Inserir a batalha na tabela `Batalha`;
2. Identificar manualmente quem venceu;
3. Atualizar manualmente os pontos do vencedor;
4. Atualizar manualmente os pontos do perdedor.

Esse processo manual aumenta o risco de fraude, erro ou inconsistência nos dados.

Com a trigger, o banco executa esse processo automaticamente sempre que uma batalha é registrada.

---

## 4. Regras de Negócio 
### RN01 Toda batalha registrada deve impactar o ranking

Sempre que uma batalha for cadastrada no sistema, ela deve gerar alteração na pontuação dos treinadores envolvidos.

Isso é necessário porque o ranking do campeonato depende diretamente dos resultados das batalhas.

---

### RN02 O treinador vencedor deve receber 3 pontos

Quando uma batalha é finalizada, o treinador identificado no campo `id_vencedor` deve receber **3 pontos** no ranking.

Essa regra valoriza a vitória e permite que os treinadores vencedores subam na classificação do campeonato.

---

### RN03 O treinador derrotado deve receber 1 ponto

O treinador que participou da batalha, mas não venceu, deve receber **1 ponto** no ranking.

Essa regra permite que a participação também seja contabilizada, mesmo quando o treinador perde a batalha.

---

### RN04 A atualização do ranking deve ser automática

A pontuação dos treinadores não deve depender de atualização manual feita pelo usuário.

O sistema deve garantir que, ao inserir uma batalha, o ranking seja atualizado imediatamente.

Essa regra evita situações como:

- batalha registrada sem alteração no ranking;
- vencedor sem receber pontos;
- perdedor sem receber pontuação de participação;
- pontuação digitada incorretamente pelo usuário.

---

