# Gatilhos (Triggers)

Este arquivo documenta as regras de negócio que fundamentam cada trigger implementada no banco de dados do Torneio Pokémon.

---

## Trigger 1 — `trg_atualiza_ranking_batalha`

### Descrição

A tabela `Batalha` registra cada confronto realizado no torneio, armazenando:

| Campo | Descrição |
|---|---|
| `id_batalha` | Identificador único da batalha |
| `data_batalha` | Data em que o confronto ocorreu |
| `fase_torneio` | Fase do campeonato (ex.: Oitavas de Final) |
| `Treinador_id_treinador` | Treinador participante 1 |
| `Treinador_id_treinador1` | Treinador participante 2 |
| `id_vencedor` | Treinador que venceu o confronto |

A tabela `Treinador` possui o campo `pontos_ranking`, que armazena a pontuação acumulada de cada competidor. Sempre que uma batalha é registrada, esse campo precisa ser atualizado automaticamente para ambos os participantes.

---

### Código SQL

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
    WHERE id_treinador IN (
        NEW.Treinador_id_treinador,
        NEW.Treinador_id_treinador1
    )
    AND id_treinador <> NEW.id_vencedor;
END $$

DELIMITER ;
```

---

### Objetivo

Automatizar a atualização da pontuação dos treinadores sempre que uma nova batalha for cadastrada. Sem esta trigger, o usuário precisaria:

1. Inserir a batalha em `Batalha`;
2. Identificar manualmente o vencedor;
3. Atualizar manualmente os pontos do vencedor;
4. Atualizar manualmente os pontos do perdedor.

Esse processo manual aumenta o risco de inconsistência, fraude ou esquecimento. Com a trigger, o banco executa tudo automaticamente a cada inserção.

---

### Regras de Negócio

**RN01 — Toda batalha registrada deve impactar o ranking**
Sempre que um registro for inserido em `Batalha`, a pontuação de ambos os treinadores envolvidos deve ser atualizada. O ranking do campeonato é uma consequência direta dos resultados das batalhas e não pode ficar desatualizado.

**RN02 — O treinador vencedor recebe 3 pontos**
O treinador identificado em `id_vencedor` recebe `+3` pontos no `pontos_ranking`. Essa regra valoriza a vitória e diferencia os treinadores na classificação.

**RN03 — O treinador derrotado recebe 1 ponto**
O treinador que participou, mas não venceu, recebe `+1` ponto. Isso garante que a participação seja recompensada, mesmo em derrota.

**RN04 — A atualização deve ser automática e imediata**
A pontuação não pode depender de ação manual do usuário. O banco deve garantir a consistência do ranking em toda inserção em `Batalha`, independentemente de como ela foi feita (via aplicação, script ou terminal).

---

## Trigger 2 — `trg_limite_6`

### Descrição

A tabela `Time_Treinador` representa os Pokémon cadastrados no time de cada treinador, armazenando:

| Campo | Descrição |
|---|---|
| `id_instancia` | Identificador único da instância do Pokémon |
| `apelido` | Apelido dado pelo treinador ao Pokémon |
| `nivel` | Nível atual do Pokémon |
| `experiencia` | Pontos de experiência acumulados |
| `data_captura` | Data em que o Pokémon foi capturado |
| `Treinador_id_treinador` | FK para o treinador dono do Pokémon |
| `Pokemon_id_especie` | FK para a espécie do Pokémon |

Seguindo a regra canônica do universo Pokémon, cada treinador pode carregar no máximo **6 Pokémon** no time. Esta trigger garante que essa restrição seja aplicada diretamente pelo banco de dados.

---

### Código SQL

```sql
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
```

---

### Objetivo

Impedir que um treinador tenha mais de 6 Pokémon cadastrados em `Time_Treinador`. A verificação ocorre **antes** da inserção (`BEFORE INSERT`): se o limite já tiver sido atingido, o banco bloqueia a operação e exibe uma mensagem de erro, sem que nenhum dado seja gravado.

---

### Regras de Negócio

**RN01 — Um treinador pode possuir no máximo 6 Pokémon no time**
Cada treinador participante do torneio deve respeitar o limite de 6 Pokémon, regra fundamental do universo Pokémon. Ultrapassar esse limite daria vantagem indevida sobre os demais competidores.

**RN02 — O limite deve ser verificado antes do cadastro de um novo Pokémon**
Antes de qualquer inserção em `Time_Treinador`, o sistema conta quantos Pokémon o treinador já possui. Se o total for igual ou maior que 6, a inserção é cancelada com `SIGNAL SQLSTATE '45000'`.

**RN03 — A regra deve ser aplicada pelo próprio banco de dados**
A validação não pode depender somente da aplicação ou do usuário. Mesmo uma inserção direta via terminal MySQL deve ser bloqueada caso o limite esteja atingido, garantindo a integridade dos dados em qualquer cenário de uso.

---