# Artefato 2: Esquema Relacional do Banco de Dados

## Diagrama de Entidade-Relacionamento (DER)

![Diagrama do Banco de Dados](diagrama.png)

`🔑` chave primária · `◆` chave estrangeira

---

## Visão geral das tabelas

| Tabela | Papel no sistema |
|---|---|
| **Treinador** | Competidores inscritos no torneio. |
| **Pokemon** | Catálogo geral de espécies (alimentado pela PokeAPI). |
| **Golpe** | Catálogo geral de habilidades de batalha (alimentado pela PokeAPI). |
| **Time_Treinador** | Instância real de um Pokémon capturado por um treinador (nível, apelido, XP). Liga `Treinador` ↔ `Pokemon`. |
| **Time_Treinador_Golpe** | Tabela associativa N:M — quais golpes cada instância do time conhece. Liga `Time_Treinador` ↔ `Golpe`. |
| **Batalha** | Histórico (log) oficial das partidas do campeonato. |

São 6 tabelas no total: as 5 entidades principais descritas no Artefato 1, mais uma tabela associativa necessária para resolver corretamente o relacionamento N:M entre golpes e Pokémon (explicado abaixo). Isso ainda atende — e supera — o mínimo de 5 tabelas exigido.

---

## O que foi corrigido em relação à primeira versão

Revisando o esquema que vocês já tinham montado no MySQL Workbench, encontramos três problemas que precisavam ser resolvidos antes de avançar para a população dos dados:

### 1. `Golpe` estava amarrado a uma única instância de `Time_Treinador`
Na versão anterior, `Golpe` tinha uma FK direta para `Time_Treinador_id_instancia`. Isso significa que cada *linha* de golpe pertencia a exatamente um Pokémon do time — então, se 50 Pokémon diferentes usassem "Tackle", seria preciso repetir nome, tipo, poder, precisão e PP do "Tackle" 50 vezes. Isso é redundância clássica e quebra a normalização (o golpe deveria ser uma entidade independente, não um atributo de uma instância específica).

**Correção:** `Golpe` voltou a ser um catálogo independente (como `Pokemon`), e criamos a tabela associativa `Time_Treinador_Golpe` para representar a relação muitos-para-muitos: um golpe pode ser usado por várias instâncias, e uma instância pode conhecer vários golpes (até 4, como nos jogos originais).

### 2. Campos prometidos no Artefato 1 que não existiam no SQL
O `GRUPO.md` já descrevia campos que a primeira versão do `.sql` não criava:
- `Pokemon`: o texto falava em "ataque, defesa e velocidade" separados, mas o SQL tinha um único campo genérico `status_base`. Agora são quatro colunas: `hp_base`, `ataque_base`, `defesa_base`, `velocidade_base`.
- `Batalha`: o texto falava em "data **e local** do confronto" e "o ID do treinador que saiu vitorioso", mas o SQL não tinha nem `local_batalha` nem `id_vencedor`. Sem o vencedor, inclusive, não seria possível implementar o gatilho do Artefato 4 (que depende de saber quem venceu). Ambos os campos foram adicionados.
- `Golpe`: faltava a coluna `categoria` (físico/especial/status), também já prevista no texto do Artefato 1.

### 3. Pequenos ajustes de modelagem
- Todas as chaves primárias agora são `AUTO_INCREMENT`.
- Adicionamos `evolui_para_id` em `Pokemon`: uma FK auto-relacionada (Pokémon → Pokémon) que indica para qual espécie aquele Pokémon evolui, alimentada pela seção de evolução da PokeAPI (`/evolution-chain`). É `NULL` quando a espécie não evolui.
- Adicionamos uma `CHECK` constraint em `Batalha` garantindo que `id_treinador1 <> id_treinador2` (um treinador não pode batalhar contra si mesmo).
- Padronizamos os nomes das colunas de chave estrangeira (`id_treinador`, `id_especie` etc.) em vez de `Treinador_id_treinador`, que era o padrão automático gerado pelo MySQL Workbench.

Todo o esquema foi testado executando de fato em uma instância MariaDB (criação das 6 tabelas, sem erros).
