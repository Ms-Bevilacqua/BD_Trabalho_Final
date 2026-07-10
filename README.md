# Torneio Pokémon — Banco de Dados
## Requisitos: 
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

Todos os scripts foram testados de ponta a ponta em uma instância MariaDB 10.11, sem erros, nesta ordem.

## Sobre a integração com a PokeAPI

`scripts/gerar_popular.py` foi escrito para buscar os dados de `Pokemon` (incluindo tipos e a cadeia de evolução, via `/pokemon`, `/pokemon-species` e `/evolution-chain`) e de `Golpe` (via `/move`) **diretamente na PokeAPI real** (`https://pokeapi.co/api/v2/`). Os dados de `Treinador`, `Time_Treinador`, `Pokemon_Golpe` e `Batalha` são sempre gerados localmente (com `Faker`), já que não existem na PokeAPI.

**Importante:** o ambiente usado para gerar a primeira versão de `2_popular.sql` não tinha saída de rede liberada para `pokeapi.co` (bloqueio de rede do sandbox, não da PokeAPI em si). Por isso, o script detecta automaticamente essa indisponibilidade e usa, como *fallback*, um dataset de referência local com a mesma estrutura de campos que a API retornaria (tipos e cadeia de evolução fiéis à Geração I; HP/Ataque/Defesa/Velocidade são valores plausíveis, não necessariamente idênticos aos do jogo oficial).

Se vocês rodarem `python3 gerar_popular.py` em uma máquina com internet normal, ele vai preferir automaticamente os dados reais da PokeAPI (basta ter `requests` e `faker` instalados: `pip install requests faker`). O `2_popular.sql` entregue já está validado e funcional independentemente disso.