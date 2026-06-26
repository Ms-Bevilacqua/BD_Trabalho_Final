# Artefato 4: Explicação do Trigger

## Nome
`trg_atualiza_ranking_pos_batalha`

## Evento
`AFTER INSERT ON Batalha`

## Regra de negócio

No contexto do torneio, o ranking de um treinador não deveria refletir *apenas* o número de vitórias: dois treinadores com a mesma quantidade de vitórias podem ter times em estágios de desenvolvimento muito diferentes (níveis muito baixos vs. times de alto nível). Para incentivar o treino contínuo dos Pokémon — e não somente o acúmulo de vitórias — definimos a seguinte regra:

> Sempre que uma batalha é registrada com um vencedor definido, o treinador vencedor recebe **3 pontos fixos** pela vitória **mais um bônus** proporcional ao **nível médio do seu time** no momento da batalha (1 ponto extra a cada 10 níveis médios, arredondado).

Isso significa que vencer com um time de nível médio alto rende mais pontos do que vencer com um time de nível baixo, recompensando o desenvolvimento dos Pokémon.

## Por que um trigger (e não só uma instrução manual)?
Se essa atualização dependesse de o aplicativo/usuário sempre lembrar de rodar um `UPDATE` depois de cada `INSERT` em `Batalha`, o ranking ficaria inconsistente caso alguém esquecesse o passo. Colocando a regra em um gatilho, a consistência do ranking é garantida pelo próprio banco de dados, independentemente de como a batalha foi inserida.

## Tabelas envolvidas
O corpo do trigger realiza:
1. **Uma operação de SELEÇÃO sobre `Time_Treinador`** — calcula `AVG(nivel)` dos Pokémon do treinador vencedor, para saber a força média do time no momento da batalha.
2. **Uma atualização (`UPDATE`) sobre `Treinador`** — soma `pontos_ranking` com o bônus calculado.

Ou seja, o gatilho envolve exatamente duas tabelas do banco: `Time_Treinador` (origem da seleção) e `Treinador` (destino da atualização), além da própria `Batalha` que dispara o evento.

## Tratamento de casos especiais
- Se `id_vencedor` for `NULL` (batalha empatada/sem resultado), o trigger não faz nada — nenhum ponto é distribuído.
- Se o treinador vencedor ainda não tiver nenhum Pokémon em `Time_Treinador`, `AVG(nivel)` retorna `NULL`; usamos `IFNULL(..., 0)` para que o trigger não falhe e o treinador receba apenas os 3 pontos fixos da vitória.

## Demonstração
A ativação do gatilho, com a visualização do estado do treinador **antes** e **depois** da inserção da batalha, está em `3_triggerAtivado.sql`.
