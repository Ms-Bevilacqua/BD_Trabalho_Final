# Artefato 5: Explicação da Visão

## Nome
`vw_ranking_treinadores`

## O que ela mostra
Uma classificação consolidada do campeonato, reunindo em uma única consulta:
- pontuação atual de ranking (`pontos_ranking`, mantida pelo trigger do Artefato 4);
- número total de batalhas disputadas por cada treinador;
- número de vitórias;
- taxa de vitória (%).

## Por que essa visão é relevante para o contexto do torneio

Em um sistema de gerenciamento de campeonato, a pergunta mais frequente — tanto da comissão organizadora quanto dos próprios competidores — é "qual a posição atual de cada treinador?". Responder isso exige cruzar informações de **duas tabelas diferentes** (`Treinador` e `Batalha`) e fazer agregações (`COUNT`, `SUM` condicional) que seriam repetidas em várias telas/relatórios do sistema (página de classificação geral, perfil do treinador, súmula da fase atual etc.).

Sem a visão, cada consulta precisaria reescrever esse `JOIN` + agregação manualmente, o que é repetitivo e propenso a erro (por exemplo, esquecer de tratar treinadores que ainda não bateram nenhuma batalha, ou contar uma mesma batalha duas vezes). Com a visão:
- a lógica de cálculo do ranking fica centralizada em um único lugar;
- qualquer relatório do sistema pode simplesmente fazer `SELECT * FROM vw_ranking_treinadores`, sem reimplementar os `JOIN`s;
- fica fácil aplicar filtros e ordenações adicionais (ex.: `WHERE cidade = 'Cuiabá'`) sobre uma visão já pronta.

## Detalhes técnicos
- O `LEFT JOIN` com `Batalha` garante que treinadores que ainda não disputaram nenhuma batalha apareçam na visão (com `total_batalhas = 0`), em vez de serem omitidos como aconteceria com um `INNER JOIN`.
- `t.id_treinador IN (b.id_treinador1, b.id_treinador2)` conta a participação do treinador na batalha independentemente de ele estar registrado como "treinador 1" ou "treinador 2".
- A taxa de vitória é `NULL` quando `total_batalhas = 0` (divisão por zero é evitada implicitamente, pois o `CASE` dentro do `SUM` resulta em `0/0`, e o MySQL/MariaDB retorna `NULL` nesse caso em vez de erro).

A execução da visão (top 20 do ranking) está incluída no final de `4_visao1.sql`.
