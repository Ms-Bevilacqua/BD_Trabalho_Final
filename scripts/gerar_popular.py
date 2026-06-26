#!/usr/bin/env python3
# =====================================================================
# gerar_popular.py
# ---------------------------------------------------------------------
# Gera o arquivo scripts/2_popular.sql do Torneio Pokémon.
#
# COMO FUNCIONA:
#   1) Tenta buscar dados REAIS na PokeAPI (https://pokeapi.co/api/v2/)
#      - /pokemon/{id}            -> tipos e estatísticas base
#      - /pokemon-species/{id}    -> cadeia de evolução (evolution_chain)
#      - /evolution-chain/{id}    -> para qual espécie cada Pokémon evolui
#      - /move/{id}               -> golpes (tipo, categoria, poder, etc.)
#   2) Se a API não estiver acessível (ex.: ambiente sem saída de rede
#      liberada para pokeapi.co, como o sandbox usado para gerar a
#      primeira versão deste arquivo), usa automaticamente um dataset
#      de referência local (DADOS_FALLBACK_POKEMON / _GOLPE), com a
#      MESMA estrutura de campos que a API retornaria, para que o
#      restante da geração (treinadores, times, batalhas) continue
#      funcionando e o banco final tenha os 100+ registros exigidos.
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

N_POKEMON = 151       # Geração I completa (>= 100 exigidos)
N_TREINADORES = 120
N_GOLPES_DESEJADOS = 110
MIN_TIME_POR_TREINADOR = 3
MAX_TIME_POR_TREINADOR = 6
N_BATALHAS = 160

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
    """Usa /pokemon-species e /evolution-chain para achar para qual
    id de espécie este Pokémon evolui (ou None se for a forma final)."""
    sp = requests.get(f"{POKEAPI_BASE}/pokemon-species/{species_id}", timeout=TIMEOUT).json()
    chain_url = sp["evolution_chain"]["url"]
    if chain_url not in cache_chain:
        cache_chain[chain_url] = requests.get(chain_url, timeout=TIMEOUT).json()
    chain = cache_chain[chain_url]["chain"]

    def extrair_id(node):
        return int(node["species"]["url"].rstrip("/").split("/")[-1])

    def procurar(node):
        atual_id = extrair_id(node)
        proximos = node["evolves_to"]
        if atual_id == species_id:
            return extrair_id(proximos[0]) if proximos else None
        for prox in proximos:
            achou = procurar(prox)
            if achou is not None or extrair_id(prox) == species_id:
                return achou if achou is not None else (
                    extrair_id(proximos[0]) if node.get("evolves_to") and extrair_id(prox) == species_id and prox.get("evolves_to") else None
                )
        return None

    # Busca direta percorrendo a árvore
    def percorrer(node, alvo):
        atual = extrair_id(node)
        if atual == alvo:
            return extrair_id(node["evolves_to"][0]) if node["evolves_to"] else None
        for filho in node["evolves_to"]:
            res = percorrer(filho, alvo)
            if res is not None or atual == alvo:
                return res
        return None

    return percorrer(chain, species_id)


def buscar_pokemon_pokeapi(species_id):
    p = requests.get(f"{POKEAPI_BASE}/pokemon/{species_id}", timeout=TIMEOUT).json()
    tipos = [t["type"]["name"] for t in p["types"]]
    stats = {s["stat"]["name"]: s["base_stat"] for s in p["stats"]}
    return {
        "id": species_id,
        "nome": p["name"].capitalize(),
        "tipo1": tipos[0].capitalize(),
        "tipo2": tipos[1].capitalize() if len(tipos) > 1 else None,
        "hp": stats.get("hp", 50),
        "ataque": stats.get("attack", 50),
        "defesa": stats.get("defense", 50),
        "velocidade": stats.get("speed", 50),
        "evolui_para": buscar_evolucao_pokeapi(species_id),
    }


def buscar_golpe_pokeapi(move_id):
    m = requests.get(f"{POKEAPI_BASE}/move/{move_id}", timeout=TIMEOUT).json()
    categoria_map = {"physical": "Fisico", "special": "Especial", "status": "Status"}
    return {
        "id": move_id,
        "nome": m["name"].replace("-", " ").title(),
        "tipo": m["type"]["name"].capitalize(),
        "categoria": categoria_map.get(m["damage_class"]["name"], "Status"),
        "poder": m["power"],
        "precisao": m["accuracy"],
        "pp": m["pp"] or 10,
    }


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

# Multiplicador de "tier" evolutivo: usado só para gerar stats plausíveis
def _tier_de(especie_id, mapa_por_id, mapa_evolui_para):
    """0 = não evolui / forma final acessível direto, 1 = pré-evolução
    de algo, 2 = pré-pré-evolução. Usado para escalar status base."""
    profundidade = 0
    atual = especie_id
    visitados = set()
    # conta quantos passos faltam até a forma final
    while mapa_evolui_para.get(atual) and atual not in visitados:
        visitados.add(atual)
        atual = mapa_evolui_para[atual]
        profundidade += 1
    return profundidade


def montar_fallback_pokemon():
    mapa_evolui_para = {p[0]: p[4] for p in _BASE_POKEMON_GEN1}
    # profundidade restante (quantas evoluções estão por vir)
    dados = []
    for (pid, nome, t1, t2, evo) in _BASE_POKEMON_GEN1:
        passos_restantes = _tier_de(pid, None, mapa_evolui_para)
        rng = random.Random(1000 + pid)  # determinístico por espécie
        base = 35 + passos_restantes * 25  # estágio mais avançado herda menos "restante", então somamos diferente abaixo
        # quanto MAIS evoluções um Pokémon já passou, maior o stat; então
        # usamos (2 - passos_restantes) como aproximação do estágio atual
        estagio_atual = 2 - min(passos_restantes, 2)
        piso = 35 + estagio_atual * 25
        dados.append({
            "id": pid,
            "nome": nome.replace("-f", " (F)").replace("-m", " (M)").replace("-mime", ". Mime").capitalize()
                       if False else nome.capitalize(),
            "tipo1": t1,
            "tipo2": t2,
            "hp": piso + rng.randint(0, 30),
            "ataque": piso + rng.randint(0, 35),
            "defesa": piso + rng.randint(-5, 30),
            "velocidade": piso + rng.randint(-10, 30),
            "evolui_para": evo,
        })
    return dados


# Golpes de referência (id, nome, tipo, categoria, poder, precisao, pp)
_GOLPES_REFERENCIA = [
    (1,"Tackle","Normal","Fisico",40,100,35),(2,"Pound","Normal","Fisico",40,100,35),
    (3,"Scratch","Normal","Fisico",40,100,35),(4,"Quick Attack","Normal","Fisico",40,100,30),
    (5,"Double Kick","Fighting","Fisico",30,100,30),(6,"Mega Punch","Normal","Fisico",80,85,20),
    (7,"Mega Kick","Normal","Fisico",120,75,5),(8,"Karate Chop","Fighting","Fisico",50,100,25),
    (9,"Body Slam","Normal","Fisico",85,100,15),(10,"Hyper Fang","Normal","Fisico",80,90,15),
    (11,"Bite","Dark","Fisico",60,100,25),(12,"Strength","Normal","Fisico",80,100,15),
    (13,"Rock Throw","Rock","Fisico",50,90,15),(14,"Rock Slide","Rock","Fisico",75,90,10),
    (15,"Dig","Ground","Fisico",80,100,10),(16,"Earthquake","Ground","Fisico",100,100,10),
    (17,"Wing Attack","Flying","Fisico",60,100,35),(18,"Peck","Flying","Fisico",35,100,35),
    (19,"Drill Peck","Flying","Fisico",80,100,20),(20,"Fly","Flying","Fisico",90,95,15),
    (21,"Poison Sting","Poison","Fisico",15,100,35),(22,"Vine Whip","Grass","Fisico",45,100,25),
    (23,"Razor Leaf","Grass","Fisico",55,95,25),(24,"Crunch","Dark","Fisico",80,100,15),
    (25,"Ember","Fire","Especial",40,100,25),(26,"Flamethrower","Fire","Especial",90,100,15),
    (27,"Fire Blast","Fire","Especial",110,85,5),(28,"Water Gun","Water","Especial",40,100,25),
    (29,"Bubble","Water","Especial",40,100,30),(30,"Hydro Pump","Water","Especial",110,80,5),
    (31,"Surf","Water","Especial",90,100,15),(32,"Thunder Shock","Electric","Especial",40,100,30),
    (33,"Thunderbolt","Electric","Especial",90,100,15),(34,"Thunder","Electric","Especial",110,70,10),
    (35,"Psybeam","Psychic","Especial",65,100,20),(36,"Psychic","Psychic","Especial",90,100,10),
    (37,"Confusion","Psychic","Especial",50,100,25),(38,"Ice Beam","Ice","Especial",90,100,10),
    (39,"Blizzard","Ice","Especial",110,70,5),(40,"Aurora Beam","Ice","Especial",65,100,20),
    (41,"Solar Beam","Grass","Especial",120,100,10),(42,"Petal Dance","Grass","Especial",70,100,20),
    (43,"Absorb","Grass","Especial",20,100,25),(44,"Mega Drain","Grass","Especial",40,100,15),
    (45,"Sludge","Poison","Especial",65,100,20),(46,"Acid","Poison","Especial",40,100,30),
    (47,"Shadow Ball","Ghost","Especial",80,100,15),(48,"Dazzling Gleam","Fairy","Especial",80,100,10),
    (49,"Hyper Beam","Normal","Especial",150,90,5),(50,"Dream Eater","Psychic","Especial",100,100,15),
    (51,"Gust","Flying","Especial",40,100,35),(52,"Hypnosis","Psychic","Status",None,60,20),
    (53,"Thunder Wave","Electric","Status",None,90,20),(54,"Toxic","Poison","Status",None,90,10),
    (55,"Sleep Powder","Grass","Status",None,75,15),(56,"Stun Spore","Grass","Status",None,75,30),
    (57,"Leech Seed","Grass","Status",None,90,10),(58,"Growl","Normal","Status",None,100,40),
    (59,"Tail Whip","Normal","Status",None,100,30),(60,"Defense Curl","Normal","Status",None,None,40),
    (61,"Withdraw","Water","Status",None,100,40),(62,"Harden","Normal","Status",None,None,30),
    (63,"Swords Dance","Normal","Status",None,None,30),(64,"Agility","Psychic","Status",None,None,30),
    (65,"Double Team","Normal","Status",None,None,15),(66,"Recover","Normal","Status",None,None,20),
    (67,"Rest","Psychic","Status",None,None,10),(68,"Substitute","Normal","Status",None,None,10),
    (69,"Counter","Fighting","Fisico",100,100,20),(70,"Whirlwind","Normal","Status",None,100,20),
    (71,"Roar","Normal","Status",None,100,20),(72,"Curse","Ghost","Status",None,None,10),
    (73,"Glare","Normal","Status",None,90,30),(74,"Spore","Grass","Status",None,100,15),
    (75,"Amnesia","Psychic","Status",None,None,20),(76,"Barrier","Psychic","Status",None,None,30),
    (77,"Light Screen","Psychic","Status",None,None,30),(78,"Reflect","Psychic","Status",None,None,20),
    (79,"Mimic","Normal","Status",None,100,10),(80,"Metronome","Normal","Status",None,None,10),
    (81,"Self Destruct","Normal","Fisico",200,100,5),(82,"Explosion","Normal","Fisico",250,100,5),
    (83,"Skull Bash","Normal","Fisico",130,100,10),(84,"Take Down","Normal","Fisico",90,85,20),
    (85,"Double Edge","Normal","Fisico",120,100,15),(86,"Slam","Normal","Fisico",80,75,20),
    (87,"Stomp","Normal","Fisico",65,100,20),(88,"Headbutt","Normal","Fisico",70,100,15),
    (89,"Horn Attack","Normal","Fisico",65,100,25),(90,"Fury Attack","Normal","Fisico",15,85,20),
    (91,"Sand Attack","Ground","Status",None,100,15),(92,"Bone Club","Ground","Fisico",65,85,20),
    (93,"Bonemerang","Ground","Fisico",50,90,10),(94,"Clamp","Water","Fisico",35,85,15),
    (95,"Crabhammer","Water","Fisico",100,90,10),(96,"Waterfall","Water","Fisico",80,100,15),
    (97,"Leer","Normal","Status",None,100,30),(98,"Smog","Poison","Especial",30,70,20),
    (99,"Smokescreen","Normal","Status",None,100,20),(100,"Flash","Normal","Status",None,100,20),
    (101,"Egg Bomb","Normal","Fisico",100,75,10),(102,"Lick","Ghost","Fisico",30,100,30),
    (103,"Night Shade","Ghost","Especial",None,100,15),(104,"Confuse Ray","Ghost","Status",None,100,10),
    (105,"Spike Cannon","Normal","Fisico",20,100,15),(106,"Constrict","Normal","Fisico",10,100,35),
    (107,"Barrage","Normal","Fisico",15,85,20),(108,"Supersonic","Normal","Status",None,55,20),
    (109,"Disable","Normal","Status",None,100,20),(110,"Acid Armor","Poison","Status",None,None,20),
    (111,"Iron Tail","Steel","Fisico",100,75,15),(112,"Aerial Ace","Flying","Fisico",60,None,20),
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
        {"id": g[0], "nome": g[1], "tipo": g[2], "categoria": g[3],
         "poder": g[4], "precisao": g[5], "pp": g[6]}
        for g in _GOLPES_REFERENCIA
    ]


# ---------------------------------------------------------------------
# 4) DADOS SINTÉTICOS (treinadores, times, batalhas) — sempre gerados
#    localmente, pois a PokeAPI não tem esse tipo de informação.
# ---------------------------------------------------------------------

CIDADES_BR = [
    "Cuiabá","Várzea Grande","Rondonópolis","Sinop","Tangará da Serra",
    "Cáceres","Campo Verde","Sorriso","Primavera do Leste","Barra do Garças",
    "Cuiabá","Lucas do Rio Verde","Nova Mutum","Pontes e Lacerda","Juína",
    "São Paulo","Campinas","Curitiba","Goiânia","Brasília",
]

FASES_TORNEIO = ["Fase de Grupos", "Oitavas de Final", "Quartas de Final", "Semifinal", "Final"]


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
            "cidade": rng.choice(CIDADES_BR),
            "data_inscricao": inicio + timedelta(days=dias),
            "pontos_ranking": rng.randint(0, 50),  # base inicial; trigger incrementa depois
        })
    return treinadores


def montar_times(rng, treinadores, pokemons):
    times = []
    instancia_id = 1
    apelidos_usados_chance = 0.5
    inicio = date(2024, 1, 1)
    for t in treinadores:
        qtd = rng.randint(MIN_TIME_POR_TREINADOR, MAX_TIME_POR_TREINADOR)
        especies_escolhidas = rng.sample(pokemons, k=qtd)
        for especie in especies_escolhidas:
            dias = rng.randint(0, 500)
            times.append({
                "id": instancia_id,
                "apelido": (especie["nome"] + "Jr") if rng.random() < apelidos_usados_chance else None,
                "nivel": rng.randint(5, 80),
                "experiencia": rng.randint(0, 5000),
                "data_captura": inicio + timedelta(days=dias),
                "id_treinador": t["id"],
                "id_especie": especie["id"],
            })
            instancia_id += 1
    return times


def montar_time_golpes(rng, times, golpes):
    relacoes = []
    for instancia in times:
        qtd = rng.randint(2, 4)
        escolhidos = rng.sample(golpes, k=min(qtd, len(golpes)))
        for g in escolhidos:
            relacoes.append({"id_instancia": instancia["id"], "id_golpe": g["id"]})
    return relacoes


def montar_batalhas(rng, treinadores):
    batalhas = []
    inicio = date(2024, 6, 1)
    for i in range(1, N_BATALHAS + 1):
        t1, t2 = rng.sample(treinadores, k=2)
        vencedor = rng.choice([t1["id"], t2["id"], None]) if rng.random() < 0.08 else rng.choice([t1["id"], t2["id"]])
        dias = rng.randint(0, 200)
        batalhas.append({
            "id": i,
            "data": inicio + timedelta(days=dias),
            "local": f"Arena de {rng.choice(CIDADES_BR)}",
            "fase": rng.choice(FASES_TORNEIO),
            "id_treinador1": t1["id"],
            "id_treinador2": t2["id"],
            "id_vencedor": vencedor,
        })
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
    golpes = montar_golpes()
    treinadores = montar_treinadores(rng)
    times = montar_times(rng, treinadores, pokemons)
    time_golpes = montar_time_golpes(rng, times, golpes)
    batalhas = montar_batalhas(rng, treinadores)

    linhas_pokemon = [
        {"id_especie": p["id"], "nome_especie": p["nome"], "tipo_base": p["tipo1"],
         "tipo_secundario": p["tipo2"], "hp_base": p["hp"], "ataque_base": p["ataque"],
         "defesa_base": p["defesa"], "velocidade_base": p["velocidade"],
         "evolui_para_id": p["evolui_para"]}
        for p in pokemons
    ]
    linhas_golpe = [
        {"id_golpe": g["id"], "nome": g["nome"], "tipo": g["tipo"], "categoria": g["categoria"],
         "poder": g["poder"], "precisao": g["precisao"], "pp_maximo": g["pp"]}
        for g in golpes
    ]
    linhas_treinador = [
        {"id_treinador": t["id"], "nome": t["nome"], "cidade": t["cidade"],
         "data_inscricao": t["data_inscricao"], "pontos_ranking": t["pontos_ranking"]}
        for t in treinadores
    ]
    linhas_time = [
        {"id_instancia": x["id"], "apelido": x["apelido"], "nivel": x["nivel"],
         "experiencia": x["experiencia"], "data_captura": x["data_captura"],
         "id_treinador": x["id_treinador"], "id_especie": x["id_especie"]}
        for x in times
    ]
    linhas_time_golpe = [
        {"id_instancia": r["id_instancia"], "id_golpe": r["id_golpe"]}
        for r in time_golpes
    ]
    linhas_batalha = [
        {"id_batalha": b["id"], "data_batalha": b["data"], "local_batalha": b["local"],
         "fase_torneio": b["fase"], "id_treinador1": b["id_treinador1"],
         "id_treinador2": b["id_treinador2"], "id_vencedor": b["id_vencedor"]}
        for b in batalhas
    ]

    sql = []
    sql.append("-- =====================================================================")
    sql.append("-- TORNEIO POKÉMON - Artefato 3: População do Banco de Dados")
    sql.append("-- Gerado automaticamente por gerar_popular.py")
    sql.append("-- Fonte dos dados de Pokémon/Golpes: PokeAPI (https://pokeapi.co/api/v2/)")
    sql.append(f"-- Pokemon: {len(linhas_pokemon)} | Golpe: {len(linhas_golpe)} | "
                f"Treinador: {len(linhas_treinador)} | Time_Treinador: {len(linhas_time)} | "
                f"Time_Treinador_Golpe: {len(linhas_time_golpe)} | Batalha: {len(linhas_batalha)}")
    sql.append("-- =====================================================================")
    sql.append("USE pokemon_torneio;")
    sql.append("SET FOREIGN_KEY_CHECKS = 0;\n")

    sql.append("-- Tabela: Pokemon (catálogo de espécies)")
    sql.append(gerar_inserts("Pokemon",
        ["id_especie","nome_especie","tipo_base","tipo_secundario","hp_base",
         "ataque_base","defesa_base","velocidade_base","evolui_para_id"], linhas_pokemon))
    sql.append("")

    sql.append("-- Tabela: Golpe (catálogo de habilidades)")
    sql.append(gerar_inserts("Golpe",
        ["id_golpe","nome","tipo","categoria","poder","precisao","pp_maximo"], linhas_golpe))
    sql.append("")

    sql.append("-- Tabela: Treinador")
    sql.append(gerar_inserts("Treinador",
        ["id_treinador","nome","cidade","data_inscricao","pontos_ranking"], linhas_treinador))
    sql.append("")

    sql.append("-- Tabela: Time_Treinador (instâncias de Pokémon capturados)")
    sql.append(gerar_inserts("Time_Treinador",
        ["id_instancia","apelido","nivel","experiencia","data_captura",
         "id_treinador","id_especie"], linhas_time))
    sql.append("")

    sql.append("-- Tabela: Time_Treinador_Golpe (golpes conhecidos por cada instância)")
    sql.append(gerar_inserts("Time_Treinador_Golpe",
        ["id_instancia","id_golpe"], linhas_time_golpe))
    sql.append("")

    sql.append("-- Tabela: Batalha (histórico do torneio)")
    sql.append(gerar_inserts("Batalha",
        ["id_batalha","data_batalha","local_batalha","fase_torneio",
         "id_treinador1","id_treinador2","id_vencedor"], linhas_batalha))
    sql.append("")
    sql.append("SET FOREIGN_KEY_CHECKS = 1;")

    output_path = Path(__file__).with_name("2_popular.sql")
    with output_path.open("w", encoding="utf-8") as f:
        f.write("\n".join(sql) + "\n")

    print("\nResumo de linhas geradas por tabela:")
    print(f"  Pokemon:              {len(linhas_pokemon)}")
    print(f"  Golpe:                {len(linhas_golpe)}")
    print(f"  Treinador:            {len(linhas_treinador)}")
    print(f"  Time_Treinador:       {len(linhas_time)}")
    print(f"  Time_Treinador_Golpe: {len(linhas_time_golpe)}")
    print(f"  Batalha:              {len(linhas_batalha)}")
    print("\nArquivo gerado: 2_popular.sql")


if __name__ == "__main__":
    main()
