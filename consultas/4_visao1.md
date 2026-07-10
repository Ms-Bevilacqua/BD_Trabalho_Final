# Sobre a View

Como parte das regras de negócio do Torneio Pokémon, criamos a View `vw_ranking_treinadores`.

Uma **View** (ou Visão) funciona como uma tabela virtual baseada no resultado de uma consulta SQL pré-definida: ela não armazena dados fisicamente, apenas a definição da consulta. A cada referência à View, o SGBD reexecuta essa consulta sobre as tabelas reais — por isso o resultado está sempre sincronizado com o estado atual do banco, inclusive com as atualizações de pontuação feitas pela trigger `trg_atualiza_ranking_batalha` a cada nova batalha registrada (ver [`3_trigger.md`](../scripts/3_trigger.md)).

---

## 1. Código da View

Arquivo: [`4_visao1.sql`](4_visao1.sql)

```sql
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
```

---

## 2. Objetivo da View

Criamos esta View para:

1. **Padronizar e simplificar o acesso** — evita que os desenvolvedores tenham que reescrever a ordenação (`ORDER BY pontos_ranking DESC`) toda vez que precisarem exibir a classificação; quem for consumir o ranking só precisa de `SELECT * FROM vw_ranking_treinadores`.
2. **Encapsulamento** — a View expõe apenas os três campos relevantes para um ranking (`id_treinador`, `nome`, `pontos_ranking`), sem exigir que quem a consulta conheça a estrutura completa da tabela `Treinador`.
3. **Interface de leitura estável** — fornece um ponto único e de fácil acesso para relatórios e para a camada de aplicação exibirem a classificação, isolando-os de mudanças futuras na tabela física (se novas colunas administrativas forem adicionadas a `Treinador`, a View continua devolvendo só o que interessa ao ranking).

---

## 3. Estrutura: colunas expostas x colunas ocultas

A tabela `Treinador` tem 5 colunas; a View projeta apenas 3 delas:

| Coluna | Exposta na View? | Motivo |
|---|:---:|---|
| `id_treinador` | Sim | identifica de forma única cada treinador no ranking |
| `nome` | Sim | necessário para saber quem ocupa cada posição |
| `pontos_ranking` | Sim | métrica central da classificação; campo usado na ordenação |
| `cidade` | Não | não influencia a pontuação; irrelevante para quem consulta o ranking |
| `data_inscricao` | Não | dado administrativo do cadastro, sem relação com o desempenho no torneio |

---

## 4. Regras de negócio atendidas

### RN01 — O ranking deve refletir sempre a pontuação mais atual dos treinadores
Por ser uma tabela virtual, e não uma cópia dos dados, a View nunca fica desatualizada: qualquer alteração em `pontos_ranking` — como as feitas pela trigger `trg_atualiza_ranking_batalha` após cada batalha — aparece imediatamente na próxima consulta à View, sem necessidade de recriá-la.

### RN02 — A classificação deve ser exibida em ordem decrescente de pontuação
Essa regra é garantida na própria definição da View, através da cláusula `ORDER BY pontos_ranking DESC`, e não depende de quem a consulta lembrar de ordenar o resultado.

### RN03 — Dados administrativos do treinador não devem aparecer junto da classificação
Campos como `cidade` e `data_inscricao`, que fazem sentido no cadastro do treinador mas não agregam valor à leitura do ranking, são deliberadamente omitidos da projeção da View.

---

## 5. Exemplo de uso e saída esperada

```sql
SELECT * FROM vw_ranking_treinadores;
```

Rodando a View sobre a base já populada — as 120 batalhas da fase de grupos inseridas por `2_popular.sql`, mais a batalha de demonstração de `3_triggerAtivado.sql` — o topo do ranking fica assim:

| id_treinador | nome | pontos_ranking |
|---:|---|---:|
| 76 | Ágatha Freitas | 18 |
| 43 | Théo Fonseca | 16 |
| 108 | Sra. Giovanna Almeida | 16 |
| 9 | Eduarda Oliveira | 14 |
| 11 | Dra. Hellena Novais | 10 |
| 39 | Carolina Araújo | 10 |
| 97 | Arthur Miguel Gomes | 10 |
| 95 | Dra. Yasmin Araújo | 8 |

Cada linha reflete o histórico de batalhas do treinador, creditado automaticamente pela trigger `trg_atualiza_ranking_batalha`: **+3 pontos por vitória** e **+1 ponto por participação em batalha perdida**. Treinadores que não participaram de nenhuma batalha permanecem com `pontos_ranking = 0`, o valor padrão definido no schema (`DEFAULT 0`).

---