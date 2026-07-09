

# Neste arquivo contem explicação da regra de negocio dos seguintes gatilho ;
# Trigger 1 : Atualizar Ranking Após Batalha
# Trigger 2 : Limite maximo participantes

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

# Regras de Negócio do Trigger 2 : Limite Maximo Pokemon 

## 1. Contexto do Sistema

O banco de dados representa o gerenciamento de um torneio Pokémon. Nesse sistema, cada treinador inscrito no campeonato pode possuir Pokémons cadastrados em seu time por meio da tabela `Time_Treinador`.

A tabela `Time_Treinador` representa a relação entre um treinador e os Pokémons que ele possui. Ela armazena informações como:

- ID da instância do Pokémon;
- apelido do Pokémon;
- nível;
- experiência;
- data de captura;
- ID do treinador;
- ID da espécie do Pokémon.

Como o torneio segue uma regra comum do universo Pokémon, cada treinador deve possuir no máximo 6 Pokémons em seu time.

---

## 2. Trigger Relacionada

A trigger responsável por essa regra é:

```sql
DELIMITER $$

CREATE TRIGGER trg_limite_6_pokemons
BEFORE INSERT ON Time_Treinador
FOR EACH ROW
BEGIN
  DECLARE qtd_pokemons INT;

  SELECT COUNT(*)
  INTO qtd_pokemons
  FROM Time_Treinador
  WHERE Treinador_id_treinador = NEW.Treinador_id_treinador;

  IF qtd_pokemons >= 6 THEN
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT = 'Um treinador não pode ter mais de 6 Pokémons no time.';
  END IF;
END $$

DELIMITER ;
```

---

## 3. Objetivo 

O objetivo da trigger é impedir que um treinador tenha mais de 6 Pokémons cadastrados em seu time.

Essa validação é feita automaticamente antes da inserção de um novo registro na tabela `Time_Treinador`.

Caso o treinador já possua 6 Pokémons cadastrados, o banco de dados bloqueia a operação e exibe uma mensagem de erro.

---

## 4. Regras de Negócio que Demandam 

### RN01 Um treinador pode possuir no máximo 6 Pokémons no time

Cada treinador participante do torneio deve respeitar o limite máximo de 6 Pokémons cadastrados.

Essa regra evita que um treinador tenha vantagem indevida sobre os demais competidores.

---

### RN02 O limite deve ser verificado antes do cadastro de um novo Pokémon

Antes de inserir um novo Pokémon na tabela `Time_Treinador`, o sistema deve verificar quantos Pokémons o treinador já possui.

Se o treinador já tiver 6 Pokémons, a nova inserção não deve ser permitida.

---

### RN03 A regra deve ser aplicada automaticamente pelo banco de dados

A validação não deve depender apenas da aplicação ou do usuário.

Mesmo que alguém tente cadastrar um Pokémon diretamente pelo MySQL, o banco deve impedir a inserção caso o limite seja ultrapassado.

---

## 5. Funcionamento 

A trigger é executada antes de cada inserção na tabela `Time_Treinador`.

Primeiro, ela conta quantos Pokémons já estão cadastrados para o treinador informado:

```sql
SELECT COUNT(*)
INTO qtd_pokemons
FROM Time_Treinador
WHERE Treinador_id_treinador = NEW.Treinador_id_treinador;
```

Depois, verifica se essa quantidade é maior ou igual a 6:

```sql
IF qtd_pokemons >= 6 THEN
```

Se o limite já tiver sido atingido, a operação é bloqueada com o comando:

```sql
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'Um treinador não pode ter mais de 6 Pokémons no time.';
```

---

