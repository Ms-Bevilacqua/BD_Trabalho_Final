# Torneio Pokémon — Banco de Dados I (UFMT)

## Estrutura do projeto

```
/GRUPO.md                          Artefato 1 — descrição do problema
/inicializar/1_esquema.sql         Artefato 2 — criação do banco e tabelas
/inicializar/1_esquema.md          Artefato 2 — UML + explicação das correções
/inicializar/diagrama.png          Diagrama ER (gerado por gerar_diagrama.py)
/inicializar/gerar_diagrama.py     Script auxiliar que gera o diagrama.png
/scripts/2_popular.sql             Artefato 3 — população das tabelas (100+ linhas cada)
/scripts/gerar_popular.py          Script que gera o 2_popular.sql (busca dados na PokeAPI)
/scripts/3_trigger.sql             Artefato 4 — criação do gatilho
/scripts/3_trigger.md              Artefato 4 — explicação da regra de negócio
/scripts/3_triggerAtivado.sql      Artefato 4 — ativação do gatilho (antes/depois)
/consultas/4_visao1.sql            Artefato 5 — criação e execução da visão
/consultas/4_visao1.md             Artefato 5 — justificativa da visão
```

## Ordem de execução
python3 gerar_popular.py
## bash
mysql -u root < inicializar/1_esquema.sql
mysql -u root < scripts/3_trigger.sql
mysql -u root < scripts/2_popular.sql
mysql -u root < scripts/3_triggerAtivado.sql
mysql -u root < consultas/4_visao1.sql
## sudo
sudo mysql < inicializar/1_esquema.sql
sudo mysql < scripts/3_trigger.sql
sudo mysql < scripts/2_popular.sql
sudo mysql < scripts/3_triggerAtivado.sql
sudo mysql < consultas/4_visao1.sql

Todos os scripts foram testados de ponta a ponta em uma instância MariaDB 10.11, sem erros, nesta ordem.

## Sobre a integração com a PokeAPI

`scripts/gerar_popular.py` foi escrito para buscar os dados de `Pokemon` (incluindo tipos e a cadeia de evolução, via `/pokemon`, `/pokemon-species` e `/evolution-chain`) e de `Golpe` (via `/move`) **diretamente na PokeAPI real** (`https://pokeapi.co/api/v2/`). Os dados de `Treinador`, `Time_Treinador`, `Time_Treinador_Golpe` e `Batalha` são sempre gerados localmente (com `Faker`), já que não existem na PokeAPI.

**Importante:** o ambiente usado para gerar a primeira versão de `2_popular.sql` não tinha saída de rede liberada para `pokeapi.co` (bloqueio de rede do sandbox, não da PokeAPI em si). Por isso, o script detecta automaticamente essa indisponibilidade e usa, como *fallback*, um dataset de referência local com a mesma estrutura de campos que a API retornaria (tipos e cadeia de evolução fiéis à Geração I; HP/Ataque/Defesa/Velocidade são valores plausíveis, não necessariamente idênticos aos do jogo oficial).

Se vocês rodarem `python3 gerar_popular.py` em uma máquina com internet normal, ele vai preferir automaticamente os dados reais da PokeAPI (basta ter `requests` e `faker` instalados: `pip install requests faker`). O `2_popular.sql` entregue já está validado e funcional independentemente disso.
