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

## Requisitos para Executar o gerar_popular.py: 
```
python3

pip install requests faker

```
## Ordem de execução

Gerar o arquivo de população (opcional — o repositório já entrega `scripts/2_popular.sql` pronto e validado):
```bash
python3 scripts/gerar_popular.py
```
 Carregar o banco, nesta ordem — o gatilho precisa existir **antes** da população, já que ele valida as inserções em `Time_Treinador`:

```bash
sudo mysql < inicializar/1_esquema.sql
sudo mysql < scripts/3_trigger.sql
sudo mysql < scripts/2_popular.sql
sudo mysql < scripts/3_triggerAtivado.sql
sudo mysql < consultas/4_visao1.sql
```

## Sobre a integração com a PokeAPI

`scripts/gerar_popular.py` foi escrito para buscar os dados de `Pokemon` (incluindo tipos e a cadeia de evolução, via `/pokemon`, `/pokemon-species` e `/evolution-chain`) e de `Golpe` (via `/move`) **diretamente na PokeAPI real** (`https://pokeapi.co/api/v2/`). Os dados de `Treinador`, `Time_Treinador`, `Pokemon_Golpe` e `Batalha` são sempre gerados localmente (com `Faker`), já que não existem na PokeAPI.

**Importante:** o ambiente usado para gerar a primeira versão de `2_popular.sql` não tinha saída de rede liberada para `pokeapi.co` (bloqueio de rede do sandbox, não da PokeAPI em si). Por isso, o script detecta automaticamente essa indisponibilidade e usa, como *fallback*, um dataset de referência local com a mesma estrutura de campos que a API retornaria (tipos e cadeia de evolução fiéis à Geração I; HP/Ataque/Defesa/Velocidade são valores plausíveis, não necessariamente idênticos aos do jogo oficial).

Se vocês rodarem `python3 gerar_popular.py` em uma máquina com internet normal, ele vai preferir automaticamente os dados reais da PokeAPI (basta ter `requests` e `faker` instalados: `pip install requests faker`). O `2_popular.sql` entregue já está validado e funcional independentemente disso.