import graphviz

g = graphviz.Digraph("ER_Pokemon", format="png")
g.attr(rankdir="LR", bgcolor="white", fontname="Helvetica", splines="spline")
g.attr("node", shape="plaintext", fontname="Helvetica")

def tabela_html(nome, colunas):
    linhas = ""
    for col, tipo, marca in colunas:
        cor_fonte = "#000000"
        if marca == "PK":
            prefixo = "🔑 "
            estilo = ' BGCOLOR="#FFF3CD"'
        elif marca == "PK/FK":
            prefixo = "🔑&#9670; "
            estilo = ' BGCOLOR="#FFF3CD"'
        elif marca == "FK":
            prefixo = "&#9670; "
            estilo = ""
        else:
            prefixo = ""
            estilo = ""
        linhas += f'<TR><TD ALIGN="LEFT"{estilo}><FONT POINT-SIZE="11">{prefixo}{col}</FONT></TD><TD ALIGN="LEFT"><FONT POINT-SIZE="10" COLOR="#555555">{tipo}</FONT></TD></TR>'
    return f'''<
<TABLE BORDER="1" CELLBORDER="0" CELLSPACING="0" CELLPADDING="6">
<TR><TD COLSPAN="2" BGCOLOR="#2C3E50"><FONT COLOR="white" POINT-SIZE="13"><B>{nome}</B></FONT></TD></TR>
{linhas}
</TABLE>>'''

g.node("Treinador", tabela_html("Treinador", [
    ("id_treinador", "INT", "PK"),
    ("nome", "VARCHAR(100)", ""),
    ("cidade", "VARCHAR(50)", ""),
    ("data_inscricao", "DATE", ""),
    ("pontos_ranking", "INT", ""),
]))

g.node("Pokemon", tabela_html("Pokemon", [
    ("id_especie", "INT", "PK"),
    ("nome_especie", "VARCHAR(50)", ""),
    ("tipo_base", "VARCHAR(30)", ""),
    ("tipo_secundario", "VARCHAR(30)", ""),
    ("hp_base", "INT", ""),
    ("ataque_base", "INT", ""),
    ("defesa_base", "INT", ""),
    ("velocidade_base", "INT", ""),
    ("evolui_para_id", "INT", "FK"),
]))

g.node("Time_Treinador", tabela_html("Time_Treinador", [
    ("id_instancia", "INT", "PK"),
    ("apelido", "VARCHAR(50)", ""),
    ("nivel", "INT", ""),
    ("experiencia", "INT", ""),
    ("data_captura", "DATE", ""),
    ("id_treinador", "INT", "FK"),
    ("id_especie", "INT", "FK"),
]))

g.node("Golpe", tabela_html("Golpe", [
    ("id_golpe", "INT", "PK"),
    ("nome", "VARCHAR(50)", ""),
    ("tipo", "VARCHAR(30)", ""),
    ("categoria", "ENUM", ""),
    ("poder", "INT", ""),
    ("precisao", "INT", ""),
    ("pp_maximo", "INT", ""),
]))

g.node("Time_Treinador_Golpe", tabela_html("Time_Treinador_Golpe", [
    ("id_instancia", "INT", "PK/FK"),
    ("id_golpe", "INT", "PK/FK"),
]))

g.node("Batalha", tabela_html("Batalha", [
    ("id_batalha", "INT", "PK"),
    ("data_batalha", "DATE", ""),
    ("local_batalha", "VARCHAR(100)", ""),
    ("fase_torneio", "VARCHAR(50)", ""),
    ("id_treinador1", "INT", "FK"),
    ("id_treinador2", "INT", "FK"),
    ("id_vencedor", "INT", "FK"),
]))

g.attr("edge", fontname="Helvetica", fontsize="10", color="#34495E", arrowsize="0.7")

g.edge("Treinador", "Time_Treinador", label="  1:N", dir="back", arrowhead="none", arrowtail="crow")
g.edge("Pokemon", "Time_Treinador", label="  1:N", dir="back", arrowhead="none", arrowtail="crow")
g.edge("Pokemon", "Pokemon", label="  evolui para (0:1)", constraint="false")
g.edge("Time_Treinador", "Time_Treinador_Golpe", label="  1:N", dir="back", arrowhead="none", arrowtail="crow")
g.edge("Golpe", "Time_Treinador_Golpe", label="  1:N", dir="back", arrowhead="none", arrowtail="crow")
g.edge("Treinador", "Batalha", label="  1:N (treinador1)", dir="back", arrowhead="none", arrowtail="crow")
g.edge("Treinador", "Batalha", label="  1:N (treinador2)", dir="back", arrowhead="none", arrowtail="crow")
g.edge("Treinador", "Batalha", label="  1:N (vencedor, opc.)", dir="back", arrowhead="none", arrowtail="crow", style="dashed")

g.render("/home/claude/bd_final/inicializar/diagrama", cleanup=True)
print("Diagrama gerado.")
