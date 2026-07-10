# Gera o arquivo scripts/2_popular.sql do Torneio Pokémon.

# COMO FUNCIONA:
#   1) Tenta buscar dados na PokeAPI (https://pokeapi.co/api/v2/)
#      - /pokemon/{id}            -> tipos e estatísticas base
#      - /pokemon-species/{id}    -> cadeia de evolução (evolution_chain)
#      - /evolution-chain/{id}    -> para qual espécie cada Pokémon evolui
#      - /move/{id}               -> golpes (tipo, categoria, poder, etc.)
#
#   2) Se a API não estiver acessível (ex.: sem acesso a internet ou queda da API, 
#      usa automaticamente um dataset de referência local (DADOS_FALLBACK_POKEMON / _GOLPE /
#      _LOCALIDADES_KANTO_FALLBACK), com a MESMA estrutura de campos que a API retornaria,
#      para que o restante da geração (treinadores, times, batalhas) continue funcionando.
#
#      
#   Quando executado em uma máquina com acesso normal à internet, basta
#   rodar `python3 gerar_popular.py` que ele vai preferir os dados
#   reais da API automaticamente.
#
# Requisitos: pip install requests faker
# =====================================================================

import random
import requests
from datetime import date, timedelta
from pathlib import Path

try:
    from faker import Faker
    fake = Faker("pt_BR")
except ImportError:
    fake = None

random.seed(42)  # reprodutibilidade

POKEAPI_BASE = "https://pokeapi.co/api/v2"
TIMEOUT = 4

N_POKEMON = 151       # Geração I completa 
N_TREINADORES = 120
N_GOLPES_DESEJADOS = 110
QTD_GOLPES_POR_POKEMON_PARA_GERACAO = 4

# ---------------------------------------------------------------------
# 1) BUSCA NA POKEAPI (uso real, requer internet liberada para pokeapi.co)
# ---------------------------------------------------------------------

def testar_pokeapi():
    """Retorna True se a PokeAPI está alcançável a partir deste ambiente."""
    try:
        r = requests.get(f"{POKEAPI_BASE}/pokemon/1", timeout=TIMEOUT)
        return r.status_code == 200
    except requests.RequestException:
        return False



def buscar_evolucao_pokeapi(species_id, cache_chain={}):
    """Percorre a evolution chain e retorna o id da espécie para qual
    este Pokémon evolui diretamente, ou None se for forma final."""
    sp = requests.get(f"{POKEAPI_BASE}/pokemon-species/{species_id}", timeout=TIMEOUT).json()
    chain_url = sp["evolution_chain"]["url"]
    if chain_url not in cache_chain:
        cache_chain[chain_url] = requests.get(chain_url, timeout=TIMEOUT).json()
    chain = cache_chain[chain_url]["chain"]

    def extrair_id(node):
        return int(node["species"]["url"].rstrip("/").split("/")[-1])

    def percorrer(node, alvo):
        if extrair_id(node) == alvo:
            return extrair_id(node["evolves_to"][0]) if node["evolves_to"] else None
        for filho in node["evolves_to"]:
            res = percorrer(filho, alvo)
            if res is not None:
                return res
        return None

    return percorrer(chain, species_id)


def buscar_pokemon_pokeapi(species_id):
    p = requests.get(f"{POKEAPI_BASE}/pokemon/{species_id}", timeout=TIMEOUT).json()
    tipos = [t["type"]["name"] for t in p["types"]]
    evolui_para = None
    try:
        evolui_para = buscar_evolucao_pokeapi(species_id)
        # Garante que a evolução existe dentro dos 151 da Gen I
        if evolui_para is not None and evolui_para > N_POKEMON:
            evolui_para = None
    except Exception:
        pass
    golpes_ids = []
    for m in p.get("moves", []):
        try:
            golpes_ids.append(int(m["move"]["url"].rstrip("/").split("/")[-1]))
        except (KeyError, ValueError, IndexError):
            continue
    return {
        "id": species_id,
        "nome": p["name"].capitalize(),
        "tipo_base": tipos[0].capitalize(),
        "tipo_secundario": tipos[1].capitalize() if len(tipos) > 1 else None,
        "evolui_para_id": evolui_para,
        "golpes_ids": golpes_ids,  # learnset real, usado por montar_pokemon_golpe
    }


def buscar_golpe_pokeapi(move_id):
    m = requests.get(f"{POKEAPI_BASE}/move/{move_id}", timeout=TIMEOUT).json()
    return {
        "id": move_id,
        "nome": m["name"].replace("-", " ").title(),
        "tipo": m["type"]["name"].capitalize(),
        "poder": m["power"],
        "precisao": m["accuracy"],
        "pp": m["pp"] or 10,
    }


def buscar_localizacoes_pokeapi(regiao="kanto"):
    """Usa /region/{regiao} para obter as localidades do universo Pokémon
    e filtra apenas cidades/vilarejos/ilhas/platôs (descarta rotas, cavernas,
    florestas e outras áreas que não fazem sentido como 'cidade natal' de
    um treinador). Retorna None se a lista filtrada vier vazia."""
    r = requests.get(f"{POKEAPI_BASE}/region/{regiao}", timeout=TIMEOUT).json()
    sufixos_assentamento = ("town", "city", "island", "plateau")
    nomes = []
    for loc in r["locations"]:
        slug = loc["name"]
        if slug.endswith(sufixos_assentamento):
            nome_formatado = slug.replace(f"{regiao}-", "").replace("-", " ").title()
            nomes.append(nome_formatado)
    return nomes or None


# ---------------------------------------------------------------------
# 2) DATASET DE REFERÊNCIA (fallback offline) — mesma estrutura da API
#    Tipos e cadeias de evolução fiéis à Geração I; HP/Ataque/Defesa/
#    Velocidade são valores de referência (plausíveis e consistentes
#    com o estágio evolutivo), não os números exatos do jogo oficial.
# ---------------------------------------------------------------------

# (id, nome, tipo1, tipo2, evolui_para)
_BASE_POKEMON_GEN1 = [
    (1,"Bulbasaur","Grass","Poison",2),(2,"Ivysaur","Grass","Poison",3),(3,"Venusaur","Grass","Poison",None),
    (4,"Charmander","Fire",None,5),(5,"Charmeleon","Fire",None,6),(6,"Charizard","Fire","Flying",None),
    (7,"Squirtle","Water",None,8),(8,"Wartortle","Water",None,9),(9,"Blastoise","Water",None,None),
    (10,"Caterpie","Bug",None,11),(11,"Metapod","Bug",None,12),(12,"Butterfree","Bug","Flying",None),
    (13,"Weedle","Bug","Poison",14),(14,"Kakuna","Bug","Poison",15),(15,"Beedrill","Bug","Poison",None),
    (16,"Pidgey","Normal","Flying",17),(17,"Pidgeotto","Normal","Flying",18),(18,"Pidgeot","Normal","Flying",None),
    (19,"Rattata","Normal",None,20),(20,"Raticate","Normal",None,None),
    (21,"Spearow","Normal","Flying",22),(22,"Fearow","Normal","Flying",None),
    (23,"Ekans","Poison",None,24),(24,"Arbok","Poison",None,None),
    (25,"Pikachu","Electric",None,26),(26,"Raichu","Electric",None,None),
    (27,"Sandshrew","Ground",None,28),(28,"Sandslash","Ground",None,None),
    (29,"Nidoran-f","Poison",None,30),(30,"Nidorina","Poison",None,31),(31,"Nidoqueen","Poison","Ground",None),
    (32,"Nidoran-m","Poison",None,33),(33,"Nidorino","Poison",None,34),(34,"Nidoking","Poison","Ground",None),
    (35,"Clefairy","Normal",None,36),(36,"Clefable","Normal",None,None),
    (37,"Vulpix","Fire",None,38),(38,"Ninetales","Fire",None,None),
    (39,"Jigglypuff","Normal",None,40),(40,"Wigglytuff","Normal",None,None),
    (41,"Zubat","Poison","Flying",42),(42,"Golbat","Poison","Flying",None),
    (43,"Oddish","Grass","Poison",44),(44,"Gloom","Grass","Poison",45),(45,"Vileplume","Grass","Poison",None),
    (46,"Paras","Bug","Grass",47),(47,"Parasect","Bug","Grass",None),
    (48,"Venonat","Bug","Poison",49),(49,"Venomoth","Bug","Poison",None),
    (50,"Diglett","Ground",None,51),(51,"Dugtrio","Ground",None,None),
    (52,"Meowth","Normal",None,53),(53,"Persian","Normal",None,None),
    (54,"Psyduck","Water",None,55),(55,"Golduck","Water",None,None),
    (56,"Mankey","Fighting",None,57),(57,"Primeape","Fighting",None,None),
    (58,"Growlithe","Fire",None,59),(59,"Arcanine","Fire",None,None),
    (60,"Poliwag","Water",None,61),(61,"Poliwhirl","Water",None,62),(62,"Poliwrath","Water","Fighting",None),
    (63,"Abra","Psychic",None,64),(64,"Kadabra","Psychic",None,65),(65,"Alakazam","Psychic",None,None),
    (66,"Machop","Fighting",None,67),(67,"Machoke","Fighting",None,68),(68,"Machamp","Fighting",None,None),
    (69,"Bellsprout","Grass","Poison",70),(70,"Weepinbell","Grass","Poison",71),(71,"Victreebel","Grass","Poison",None),
    (72,"Tentacool","Water","Poison",73),(73,"Tentacruel","Water","Poison",None),
    (74,"Geodude","Rock","Ground",75),(75,"Graveler","Rock","Ground",76),(76,"Golem","Rock","Ground",None),
    (77,"Ponyta","Fire",None,78),(78,"Rapidash","Fire",None,None),
    (79,"Slowpoke","Water","Psychic",80),(80,"Slowbro","Water","Psychic",None),
    (81,"Magnemite","Electric","Steel",82),(82,"Magneton","Electric","Steel",None),
    (83,"Farfetchd","Normal","Flying",None),
    (84,"Doduo","Normal","Flying",85),(85,"Dodrio","Normal","Flying",None),
    (86,"Seel","Water",None,87),(87,"Dewgong","Water","Ice",None),
    (88,"Grimer","Poison",None,89),(89,"Muk","Poison",None,None),
    (90,"Shellder","Water",None,91),(91,"Cloyster","Water","Ice",None),
    (92,"Gastly","Ghost","Poison",93),(93,"Haunter","Ghost","Poison",94),(94,"Gengar","Ghost","Poison",None),
    (95,"Onix","Rock","Ground",None),
    (96,"Drowzee","Psychic",None,97),(97,"Hypno","Psychic",None,None),
    (98,"Krabby","Water",None,99),(99,"Kingler","Water",None,None),
    (100,"Voltorb","Electric",None,101),(101,"Electrode","Electric",None,None),
    (102,"Exeggcute","Grass","Psychic",103),(103,"Exeggutor","Grass","Psychic",None),
    (104,"Cubone","Ground",None,105),(105,"Marowak","Ground",None,None),
    (106,"Hitmonlee","Fighting",None,None),(107,"Hitmonchan","Fighting",None,None),
    (108,"Lickitung","Normal",None,None),
    (109,"Koffing","Poison",None,110),(110,"Weezing","Poison",None,None),
    (111,"Rhyhorn","Ground","Rock",112),(112,"Rhydon","Ground","Rock",None),
    (113,"Chansey","Normal",None,None),
    (114,"Tangela","Grass",None,None),
    (115,"Kangaskhan","Normal",None,None),
    (116,"Horsea","Water",None,117),(117,"Seadra","Water",None,None),
    (118,"Goldeen","Water",None,119),(119,"Seaking","Water",None,None),
    (120,"Staryu","Water",None,121),(121,"Starmie","Water","Psychic",None),
    (122,"Mr-mime","Psychic","Fairy",None),
    (123,"Scyther","Bug","Flying",None),
    (124,"Jynx","Ice","Psychic",None),
    (125,"Electabuzz","Electric",None,None),
    (126,"Magmar","Fire",None,None),
    (127,"Pinsir","Bug",None,None),
    (128,"Tauros","Normal",None,None),
    (129,"Magikarp","Water",None,130),(130,"Gyarados","Water","Flying",None),
    (131,"Lapras","Water","Ice",None),
    (132,"Ditto","Normal",None,None),
    (133,"Eevee","Normal",None,134),(134,"Vaporeon","Water",None,None),
    (135,"Jolteon","Electric",None,None),(136,"Flareon","Fire",None,None),
    (137,"Porygon","Normal",None,None),
    (138,"Omanyte","Rock","Water",139),(139,"Omastar","Rock","Water",None),
    (140,"Kabuto","Rock","Water",141),(141,"Kabutops","Rock","Water",None),
    (142,"Aerodactyl","Rock","Flying",None),
    (143,"Snorlax","Normal",None,None),
    (144,"Articuno","Ice","Flying",None),(145,"Zapdos","Electric","Flying",None),(146,"Moltres","Fire","Flying",None),
    (147,"Dratini","Dragon",None,148),(148,"Dragonair","Dragon",None,149),(149,"Dragonite","Dragon","Flying",None),
    (150,"Mewtwo","Psychic",None,None),(151,"Mew","Psychic",None,None),
]


def montar_fallback_pokemon():
    dados = []
    for (pid, nome, t1, t2, evo) in _BASE_POKEMON_GEN1:
        dados.append({
            "id": pid,
            "nome": nome.capitalize(),
            "tipo_base": t1,
            "tipo_secundario": t2,
            "evolui_para_id": evo,
            "golpes_ids": [],  # sem learnset real offline; montar_pokemon_golpe sorteia
        })
    return dados


# Golpes de referência (id, nome, tipo, poder, precisao, pp)
_GOLPES_REFERENCIA = [
    (1,"Tackle","Normal",40,100,35),(2,"Pound","Normal",40,100,35),
    (3,"Scratch","Normal",40,100,35),(4,"Quick Attack","Normal",40,100,30),
    (5,"Double Kick","Fighting",30,100,30),(6,"Mega Punch","Normal",80,85,20),
    (7,"Mega Kick","Normal",120,75,5),(8,"Karate Chop","Fighting",50,100,25),
    (9,"Body Slam","Normal",85,100,15),(10,"Hyper Fang","Normal",80,90,15),
    (11,"Bite","Dark",60,100,25),(12,"Strength","Normal",80,100,15),
    (13,"Rock Throw","Rock",50,90,15),(14,"Rock Slide","Rock",75,90,10),
    (15,"Dig","Ground",80,100,10),(16,"Earthquake","Ground",100,100,10),
    (17,"Wing Attack","Flying",60,100,35),(18,"Peck","Flying",35,100,35),
    (19,"Drill Peck","Flying",80,100,20),(20,"Fly","Flying",90,95,15),
    (21,"Poison Sting","Poison",15,100,35),(22,"Vine Whip","Grass",45,100,25),
    (23,"Razor Leaf","Grass",55,95,25),(24,"Crunch","Dark",80,100,15),
    (25,"Ember","Fire",40,100,25),(26,"Flamethrower","Fire",90,100,15),
    (27,"Fire Blast","Fire",110,85,5),(28,"Water Gun","Water",40,100,25),
    (29,"Bubble","Water",40,100,30),(30,"Hydro Pump","Water",110,80,5),
    (31,"Surf","Water",90,100,15),(32,"Thunder Shock","Electric",40,100,30),
    (33,"Thunderbolt","Electric",90,100,15),(34,"Thunder","Electric",110,70,10),
    (35,"Psybeam","Psychic",65,100,20),(36,"Psychic","Psychic",90,100,10),
    (37,"Confusion","Psychic",50,100,25),(38,"Ice Beam","Ice",90,100,10),
    (39,"Blizzard","Ice",110,70,5),(40,"Aurora Beam","Ice",65,100,20),
    (41,"Solar Beam","Grass",120,100,10),(42,"Petal Dance","Grass",70,100,20),
    (43,"Absorb","Grass",20,100,25),(44,"Mega Drain","Grass",40,100,15),
    (45,"Sludge","Poison",65,100,20),(46,"Acid","Poison",40,100,30),
    (47,"Shadow Ball","Ghost",80,100,15),(48,"Dazzling Gleam","Fairy",80,100,10),
    (49,"Hyper Beam","Normal",150,90,5),(50,"Dream Eater","Psychic",100,100,15),
    (51,"Gust","Flying",40,100,35),(52,"Hypnosis","Psychic",None,60,20),
    (53,"Thunder Wave","Electric",None,90,20),(54,"Toxic","Poison",None,90,10),
    (55,"Sleep Powder","Grass",None,75,15),(56,"Stun Spore","Grass",None,75,30),
    (57,"Leech Seed","Grass",None,90,10),(58,"Growl","Normal",None,100,40),
    (59,"Tail Whip","Normal",None,100,30),(60,"Defense Curl","Normal",None,None,40),
    (61,"Withdraw","Water",None,100,40),(62,"Harden","Normal",None,None,30),
    (63,"Swords Dance","Normal",None,None,30),(64,"Agility","Psychic",None,None,30),
    (65,"Double Team","Normal",None,None,15),(66,"Recover","Normal",None,None,20),
    (67,"Rest","Psychic",None,None,10),(68,"Substitute","Normal",None,None,10),
    (69,"Counter","Fighting",100,100,20),(70,"Whirlwind","Normal",None,100,20),
    (71,"Roar","Normal",None,100,20),(72,"Curse","Ghost",None,None,10),
    (73,"Glare","Normal",None,90,30),(74,"Spore","Grass",None,100,15),
    (75,"Amnesia","Psychic",None,None,20),(76,"Barrier","Psychic",None,None,30),
    (77,"Light Screen","Psychic",None,None,30),(78,"Reflect","Psychic",None,None,20),
    (79,"Mimic","Normal",None,100,10),(80,"Metronome","Normal",None,None,10),
    (81,"Self Destruct","Normal",200,100,5),(82,"Explosion","Normal",250,100,5),
    (83,"Skull Bash","Normal",130,100,10),(84,"Take Down","Normal",90,85,20),
    (85,"Double Edge","Normal",120,100,15),(86,"Slam","Normal",80,75,20),
    (87,"Stomp","Normal",65,100,20),(88,"Headbutt","Normal",70,100,15),
    (89,"Horn Attack","Normal",65,100,25),(90,"Fury Attack","Normal",15,85,20),
    (91,"Sand Attack","Ground",None,100,15),(92,"Bone Club","Ground",65,85,20),
    (93,"Bonemerang","Ground",50,90,10),(94,"Clamp","Water",35,85,15),
    (95,"Crabhammer","Water",100,90,10),(96,"Waterfall","Water",80,100,15),
    (97,"Leer","Normal",None,100,30),(98,"Smog","Poison",30,70,20),
    (99,"Smokescreen","Normal",None,100,20),(100,"Flash","Normal",None,100,20),
    (101,"Egg Bomb","Normal",100,75,10),(102,"Lick","Ghost",30,100,30),
    (103,"Night Shade","Ghost",None,100,15),(104,"Confuse Ray","Ghost",None,100,10),
    (105,"Spike Cannon","Normal",20,100,15),(106,"Constrict","Normal",10,100,35),
    (107,"Barrage","Normal",15,85,20),(108,"Supersonic","Normal",None,55,20),
    (109,"Disable","Normal",None,100,20),(110,"Acid Armor","Poison",None,None,20),
    (111,"Iron Tail","Steel",100,75,15),(112,"Aerial Ace","Flying",60,None,20),
]


# ---------------------------------------------------------------------
# 3) MONTAGEM DOS DADOS (escolhe API real ou fallback)
# ---------------------------------------------------------------------

def montar_pokemons():
    if testar_pokeapi():
        print("[INFO] PokeAPI acessível — buscando dados reais (1-151)...")
        return [buscar_pokemon_pokeapi(i) for i in range(1, N_POKEMON + 1)]
    print("[AVISO] PokeAPI inacessível neste ambiente (host_not_allowed / sem rede). "
          "Usando dataset de referência local com a mesma estrutura.")
    return montar_fallback_pokemon()


def montar_golpes():
    if testar_pokeapi():
        print("[INFO] PokeAPI acessível — buscando golpes reais...")
        golpes, i = [], 1
        while len(golpes) < N_GOLPES_DESEJADOS:
            try:
                golpes.append(buscar_golpe_pokeapi(i))
            except Exception:
                pass
            i += 1
        return golpes
    return [
        {"id": g[0], "nome": g[1], "tipo": g[2],
         "poder": g[3], "precisao": g[4], "pp": g[5]}
        for g in _GOLPES_REFERENCIA
    ]


# ---------------------------------------------------------------------
# 4) DADOS SINTÉTICOS (treinadores, times, batalhas) — sempre gerados
#    localmente, pois a PokeAPI não tem esse tipo de informação.
# ---------------------------------------------------------------------

# Localidades de referência (fallback offline) — assentamentos canônicos
# de Kanto, mesma região da Geração I usada no restante do dataset.
_LOCALIDADES_KANTO_FALLBACK = [
    "Pallet Town", "Viridian City", "Pewter City", "Cerulean City",
    "Vermilion City", "Lavender Town", "Celadon City", "Fuchsia City",
    "Saffron City", "Cinnabar Island", "Indigo Plateau", "Seafoam Islands",
]


def montar_localidades():
    if testar_pokeapi():
        print("[INFO] PokeAPI acessível — buscando localidades de Kanto...")
        try:
            localidades = buscar_localizacoes_pokeapi("kanto")
            if localidades:
                return localidades
        except Exception:
            pass
    return _LOCALIDADES_KANTO_FALLBACK


LOCALIDADES_POKEMON = montar_localidades()

# Fases do chaveamento eliminatório (após fase de grupos)
# Com 120 treinadores: 16 grupos de ~7-8 → 32 classificados → Oitavas até Final
FASES_ELIMINATORIAS = [
    ("Oitavas de Final", 16),  # 16 batalhas, 32 → 16
    ("Quartas de Final",  8),  #  8 batalhas, 16 →  8
    ("Semifinal",         4),  #  4 batalhas,  8 →  4
    ("Terceiro Lugar",    1),  #  1 batalha,   disputa 3º/4º
    ("Final",             1),  #  1 batalha,   só 1 vencedor
]


def nome_aleatorio(rng):
    if fake:
        return fake.name()
    primeiros = ["Ana","Bruno","Carla","Diego","Elena","Felipe","Gabriela","Hugo",
                 "Iris","João","Karina","Lucas","Mariana","Nicolas","Otávio","Paula",
                 "Quésia","Rafael","Sofia","Tiago","Ursula","Vitor","Wesley","Yasmin"]
    sobrenomes = ["Silva","Souza","Oliveira","Pereira","Costa","Rodrigues","Almeida",
                  "Nascimento","Lima","Araújo","Fernandes","Carvalho","Gomes","Martins"]
    return f"{rng.choice(primeiros)} {rng.choice(sobrenomes)}"


def montar_treinadores(rng):
    treinadores = []
    inicio = date(2024, 1, 1)
    for i in range(1, N_TREINADORES + 1):
        dias = rng.randint(0, 500)
        treinadores.append({
            "id": i,
            "nome": nome_aleatorio(rng),
            "cidade": rng.choice(LOCALIDADES_POKEMON),
            "data_inscricao": inicio + timedelta(days=dias),
            "pontos_ranking": 0,  # sempre zero: o trigger trg_atualiza_ranking_batalha acumula +3 ao vencedor e +1 ao perdedor a cada batalha inserida
        })
    return treinadores


def montar_times(rng, treinadores, pokemons):
    """Inscrição dos Pokémon no torneio: cada treinador recebe uma
    quantidade de espécies para o seu time.

    Este script só POPULA — não reimplementa a regra de negócio do
    limite de time (isso é feito pelo trg_limite_6, em Time_Treinador).
    Mas como esse trigger existe e está ATIVO no banco, gerar mais de
    6 linhas para o mesmo treinador faz o próprio INSERT deste arquivo
    falhar com SIGNAL — não é uma escolha do Python, é uma restrição
    do banco que qualquer dado inserido precisa respeitar para o
    script rodar até o fim. Por isso o sorteio abaixo não passa de 6.
    A chave primária é (Treinador_id_treinador, Pokemon_id_especie)."""
    times = []
    for t in treinadores:
        qtd = rng.randint(1, min(6, len(pokemons)))
        especies_escolhidas = rng.sample(pokemons, k=qtd)
        for especie in especies_escolhidas:
            times.append({
                "Treinador_id_treinador": t["id"],
                "Pokemon_id_especie": especie["id"],
            })
    return times


def montar_golpes_por_instancia(rng, times, golpes):
    """Golpes são um catálogo independente — sem FK para Time_Treinador."""
    return golpes


def montar_pokemon_golpe(rng, pokemons, golpes):
    """Relação N:N entre Pokemon e Golpe: quais golpes cada espécie
    é capaz de aprender.

    Quando os dados vieram da PokeAPI, cada Pokémon já carrega seu
    learnset real em 'golpes_ids' (ver buscar_pokemon_pokeapi); aqui
    isso é restrito aos golpes que existem no nosso catálogo (golpes)
    e, se necessário, completado aleatoriamente até o mínimo desejado.
    No fallback offline 'golpes_ids' vem vazio, então a relação é
    sorteada por completo — mesma lógica usada em montar_times."""
    catalogo_ids = [g["id"] for g in golpes]
    relacoes = []

    for p in pokemons:
        qtd_alvo = QTD_GOLPES_POR_POKEMON_PARA_GERACAO

        reais = [gid for gid in p.get("golpes_ids", []) if gid in catalogo_ids]
        reais = list(dict.fromkeys(reais))  # remove duplicados, preserva ordem
        rng.shuffle(reais)
        escolhidos = reais[:qtd_alvo]

        if len(escolhidos) < qtd_alvo:
            restantes = [gid for gid in catalogo_ids if gid not in escolhidos]
            faltam = min(qtd_alvo - len(escolhidos), len(restantes))
            escolhidos += rng.sample(restantes, k=faltam)

        for gid in escolhidos:
            relacoes.append({
                "Pokemon_id_especie": p["id"],
                "Golpe_id_golpe": gid,
            })

    return relacoes


def montar_batalhas(rng, treinadores):
    """Gera batalhas respeitando a estrutura real de um torneio único:

    1) Fase de Grupos: treinadores divididos em grupos, cada um joga
       exatamente 2 partidas dentro do seu grupo. O vencedor de cada
       grupo (melhor campanha) avança para o chaveamento eliminatório.

    2) Chaveamento eliminatório: Oitavas → Quartas → Semifinal →
       Terceiro Lugar → Final. Cada fase tem exatamente o número certo
       de batalhas; "Final" ocorre UMA única vez.
    """
    batalhas = []
    bid = 1  # id sequencial das batalhas

    # ── 1) FASE DE GRUPOS ─────────────────────────────────────────────
    # Dividir os 120 treinadores em 16 grupos (8 com 8 e 8 com 7)
    shuffled = treinadores[:]
    rng.shuffle(shuffled)
    n_grupos = 16
    grupos = [[] for _ in range(n_grupos)]
    for idx, t in enumerate(shuffled):
        grupos[idx % n_grupos].append(t)

    # Data base da fase de grupos: começa em fevereiro
    data_grupos = date(2025, 2, 1)
    classificados = []  # um vencedor por grupo avança

    for grupo in grupos:
        # Cada treinador do grupo joga contra 2 adversários diferentes
        adversarios = grupo[:]
        rng.shuffle(adversarios)
        jogados = set()   # pares já jogados (frozenset de ids)
        pontos = {t["id"]: 0 for t in grupo}

        for t in grupo:
            oponentes_possiveis = [
                x for x in grupo
                if x["id"] != t["id"]
                and frozenset((t["id"], x["id"])) not in jogados
            ]
            # Cada treinador joga no máximo 2 partidas no grupo
            ja_jogou = sum(1 for (a, b) in jogados if t["id"] in (a, b))
            for oponente in oponentes_possiveis:
                if ja_jogou >= 2:
                    break
                ja_jogou_oponente = sum(1 for (a, b) in jogados if oponente["id"] in (a, b))
                if ja_jogou_oponente >= 2:
                    continue
                par = frozenset((t["id"], oponente["id"]))
                jogados.add(par)
                ja_jogou += 1
                vencedor_id = rng.choice([t["id"], oponente["id"]])
                pontos[vencedor_id] += 3
                dias = rng.randint(0, 28)
                batalhas.append({
                    "id": bid,
                    "data": data_grupos + timedelta(days=dias),
                    "fase": "Fase de Grupos",
                    "Treinador_id_treinador": t["id"],
                    "Treinador_id_treinador1": oponente["id"],
                    "id_vencedor": vencedor_id,
                })
                bid += 1

        # Classifica o treinador com mais pontos do grupo
        lider = max(grupo, key=lambda t: pontos[t["id"]])
        classificados.append(lider)

    # ── 2) CHAVEAMENTO ELIMINATÓRIO ────────────────────────────────────
    # classificados tem exatamente 16 → entra em Oitavas de Final
    atual_rodada = classificados[:]
    rng.shuffle(atual_rodada)

    # Datas progressivas por fase (3 semanas de intervalo)
    data_fase = date(2025, 3, 15)

    for (nome_fase, n_batalhas_fase) in FASES_ELIMINATORIAS:
        if nome_fase == "Terceiro Lugar":
            # Os dois perdedores da Semifinal disputam o 3º lugar
            # (guardados em semifinalistas_eliminados)
            t1, t2 = semifinalistas_eliminados
            vencedor_id = rng.choice([t1["id"], t2["id"]])
            batalhas.append({
                "id": bid,
                "data": data_fase,
                "fase": nome_fase,
                "Treinador_id_treinador": t1["id"],
                "Treinador_id_treinador1": t2["id"],
                "id_vencedor": vencedor_id,
            })
            bid += 1
            data_fase += timedelta(weeks=1)
            continue

        proxima_rodada = []
        semifinalistas_eliminados = []  # só usado após a Semifinal

        for i in range(0, len(atual_rodada) - 1, 2):
            t1 = atual_rodada[i]
            t2 = atual_rodada[i + 1]
            vencedor_id = rng.choice([t1["id"], t2["id"]])
            perdedor = t2 if vencedor_id == t1["id"] else t1
            dias = rng.randint(0, 6)
            batalhas.append({
                "id": bid,
                "data": data_fase + timedelta(days=dias),
                "fase": nome_fase,
                "Treinador_id_treinador": t1["id"],
                "Treinador_id_treinador1": t2["id"],
                "id_vencedor": vencedor_id,
            })
            bid += 1
            vencedor_obj = t1 if vencedor_id == t1["id"] else t2
            proxima_rodada.append(vencedor_obj)
            if nome_fase == "Semifinal":
                semifinalistas_eliminados.append(perdedor)

        atual_rodada = proxima_rodada
        data_fase += timedelta(weeks=3)

    return batalhas


# ---------------------------------------------------------------------
# 5) GERAÇÃO DO SQL
# ---------------------------------------------------------------------

def esc(valor):
    if valor is None:
        return "NULL"
    if isinstance(valor, str):
        return "'" + valor.replace("'", "''") + "'"
    if isinstance(valor, date):
        return f"'{valor.isoformat()}'"
    return str(valor)


def gerar_inserts(tabela, colunas, linhas, lote=200):
    partes = []
    for inicio in range(0, len(linhas), lote):
        bloco = linhas[inicio:inicio + lote]
        valores = ",\n".join(
            "  (" + ", ".join(esc(l[c]) for c in colunas) + ")" for l in bloco
        )
        partes.append(
            f"INSERT INTO `{tabela}` (`{'`, `'.join(colunas)}`) VALUES\n{valores};"
        )
    return "\n\n".join(partes)


def main():
    rng = random.Random(7)

    pokemons = montar_pokemons()
    golpes_base = montar_golpes()
    treinadores = montar_treinadores(rng)
    times = montar_times(rng, treinadores, pokemons)
    golpes = montar_golpes_por_instancia(rng, times, golpes_base)
    pokemon_golpe = montar_pokemon_golpe(rng, pokemons, golpes)
    batalhas = montar_batalhas(rng, treinadores)

    linhas_pokemon = [
        {"id_especie": p["id"], "nome_especie": p["nome"],
         "tipo_base": p["tipo_base"], "tipo_secundario": p["tipo_secundario"],
         "evolui_para_id": p["evolui_para_id"]}
        for p in pokemons
    ]
    linhas_golpe = [
        {"id_golpe": g["id"], "nome": g["nome"], "tipo": g["tipo"],
         "poder": g["poder"], "precisao": g["precisao"], "pp_maximo": g["pp"]}
        for g in golpes
    ]
    linhas_treinador = [
        {"id_treinador": t["id"], "nome": t["nome"], "cidade": t["cidade"],
         "data_inscricao": t["data_inscricao"], "pontos_ranking": t["pontos_ranking"]}
        for t in treinadores
    ]
    linhas_time = [
        {"Treinador_id_treinador": x["Treinador_id_treinador"],
         "Pokemon_id_especie": x["Pokemon_id_especie"]}
        for x in times
    ]
    linhas_pokemon_golpe = [
        {"Pokemon_id_especie": r["Pokemon_id_especie"],
         "Golpe_id_golpe": r["Golpe_id_golpe"]}
        for r in pokemon_golpe
    ]
    linhas_batalha = [
        {"id_batalha": b["id"], "data_batalha": b["data"],
         "fase_torneio": b["fase"],
         "Treinador_id_treinador": b["Treinador_id_treinador"],
         "Treinador_id_treinador1": b["Treinador_id_treinador1"],
         "id_vencedor": b["id_vencedor"]}
        for b in batalhas
    ]

    sql = []
    sql.append("USE `Pokemon_Torneio`;")
    sql.append("SET FOREIGN_KEY_CHECKS = 0;\n")

    sql.append("-- Tabela: Pokemon (catálogo de espécies)")
    sql.append(gerar_inserts("Pokemon",
        ["id_especie", "nome_especie", "tipo_base", "tipo_secundario", "evolui_para_id"],
        linhas_pokemon))
    sql.append("")

    sql.append("-- Tabela: Treinador")
    sql.append(gerar_inserts("Treinador",
        ["id_treinador", "nome", "cidade", "data_inscricao", "pontos_ranking"], linhas_treinador))
    sql.append("")

    sql.append("-- Tabela: Time_Treinador (Pokémon inscritos por treinador no torneio)")
    # lote=1: trg_limite_6 é BEFORE INSERT ativo nesta tabela. Se o
    # SIGNAL disparar, um INSERT em lote aborta o bloco inteiro; com
    # lote=1 cada linha é seu próprio INSERT, então uma eventual
    # violação afeta só aquela linha, não o restante do arquivo.
    sql.append(gerar_inserts("Time_Treinador",
        ["Treinador_id_treinador", "Pokemon_id_especie"], linhas_time, lote=1))
    sql.append("")

    sql.append("-- Tabela: Golpe (catálogo de golpes)")
    sql.append(gerar_inserts("Golpe",
        ["id_golpe", "nome", "tipo", "poder", "precisao", "pp_maximo"], linhas_golpe))
    sql.append("")

    sql.append("-- Tabela: Pokemon_Golpe (golpes que cada espécie pode aprender)")
    sql.append(gerar_inserts("Pokemon_Golpe",
        ["Pokemon_id_especie", "Golpe_id_golpe"], linhas_pokemon_golpe))
    sql.append("")

    sql.append("-- Tabela: Batalha (histórico do torneio)")
    sql.append(gerar_inserts("Batalha",
        ["id_batalha", "data_batalha", "fase_torneio",
         "Treinador_id_treinador", "Treinador_id_treinador1", "id_vencedor"], linhas_batalha))
    sql.append("")
    sql.append("SET FOREIGN_KEY_CHECKS = 1;")

    output_path = Path(__file__).with_name("2_popular.sql")
    with output_path.open("w", encoding="utf-8") as f:
        f.write("\n".join(sql) + "\n")

    print("\nResumo de linhas geradas por tabela:")
    print(f"  Pokemon:        {len(linhas_pokemon)}")
    print(f"  Treinador:      {len(linhas_treinador)}")
    print(f"  Time_Treinador: {len(linhas_time)}")
    print(f"  Golpe:          {len(linhas_golpe)}")
    print(f"  Pokemon_Golpe:  {len(linhas_pokemon_golpe)}")
    print(f"  Batalha:        {len(linhas_batalha)}")
    print("\nArquivo gerado: 2_popular.sql")


if __name__ == "__main__":
    main()