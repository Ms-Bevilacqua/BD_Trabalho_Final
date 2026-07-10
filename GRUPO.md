# Trabalho Final - Banco de Dados
## Artefato 1: Descrição do Problema

### Integrantes:
* Gabriel Silva de Oliveira Bevilacqua — RGA: 202121901018
* Mayck Vinicius Aguiar — RGA: 202421901066
* Mylena Ágatha Martins Fernandez — RGA: 202321901035

### Contexto:
O objetivo deste projeto é o gerenciamento completo de um Torneio Pokémon. O sistema é responsável por registrar as inscrições dos competidores, catalogar as espécies de criaturas (incluindo sua respectiva linha evolutiva), gerenciar os golpes de ataque disponíveis e os times inscritos por cada treinador. Além disso, o banco mantém um histórico automatizado e consistente de todos os confrontos ocorridos ao longo do campeonato e a classificação dinâmica dos participantes.

Os dados de espécies de Pokémon e de golpes são originados da [PokeAPI](https://pokeapi.co/docs/v2), incluindo a seção de evolução (`/evolution-chain`), usada para saber para qual espécie cada Pokémon evolui.

As tabelas do sistema e seus respectivos atributos são:

1. **Treinador**: registra todos os competidores inscritos no torneio. De cada treinador são armazenados o **ID, nome, cidade, a data de inscrição no evento e a sua pontuação atual no ranking do campeonato.**

2. **Pokemon**: catálogo geral do torneio, contendo as espécies existentes (alimentado pela PokeAPI). Registra-se o **id da espécie, nome da espécie, tipo base e tipo secundário (quando houver), seus atributos de status base (HP, ataque, defesa e velocidade) e para qual espécie ela evolui** (quando aplicável).

3. **Golpe:** catálogo geral de habilidades que os Pokémon podem utilizar nos confrontos (alimentado pela PokeAPI). Cada golpe possui **id do golpe, nome, tipo elemental, categoria (físico, especial ou status), poder de ataque, precisão e pontos de poder (PP) máximos.**

4. **Time_Treinador:** relação entre Pokémon e Treinadores, indicando a qual competidor cada criatura capturada pertence. Nela, registram-se: **o id da instância, o apelido dado pelo treinador, o nível atual, os pontos de experiência, a data em que foi capturado, o id do treinador e o id da espécie.**

5. **Pokemon_Golpe:** Mapeia quais golpes cada espécie de Pokémon é biologicamente capaz de aprender no ecossistema do torneio. Tem como atributos Pokemon_id_especie (Chave Estrangeira) e Golpe_id_golpe (Chave Estrangeira). A chave primária é composta por ambos os campos.

6. **Batalha:** histórico oficial das partidas. Cada registro armazena um **ID único, a data e o local do confronto, a fase do torneio, os IDs dos dois treinadores envolvidos (Treinador 1 e Treinador 2) e o ID do treinador que saiu vitorioso** (quando já decidida).

> **Observação:** o enunciado pede no mínimo 5 tabelas; o esquema final tem 6, pois `Time_Treinador_Golpe` é uma tabela de associação necessária para representar corretamente, em 3ª Forma Normal, a relação muitos-para-muitos entre Pokémon do time e golpes (evitando duplicar dados de um golpe para cada Pokémon que o utiliza).
