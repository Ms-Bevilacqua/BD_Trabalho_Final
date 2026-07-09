USE `Pokemon_Torneio`;
SET FOREIGN_KEY_CHECKS = 0;

-- Tabela: Pokemon (catálogo de espécies)
INSERT INTO `Pokemon` (`id_especie`, `nome_especie`, `tipo_base`, `tipo_secundario`, `evolui_para_id`) VALUES
  (1, 'Bulbasaur', 'Grass', 'Poison', 2),
  (2, 'Ivysaur', 'Grass', 'Poison', 3),
  (3, 'Venusaur', 'Grass', 'Poison', NULL),
  (4, 'Charmander', 'Fire', NULL, 5),
  (5, 'Charmeleon', 'Fire', NULL, 6),
  (6, 'Charizard', 'Fire', 'Flying', NULL),
  (7, 'Squirtle', 'Water', NULL, 8),
  (8, 'Wartortle', 'Water', NULL, 9),
  (9, 'Blastoise', 'Water', NULL, NULL),
  (10, 'Caterpie', 'Bug', NULL, 11),
  (11, 'Metapod', 'Bug', NULL, 12),
  (12, 'Butterfree', 'Bug', 'Flying', NULL),
  (13, 'Weedle', 'Bug', 'Poison', 14),
  (14, 'Kakuna', 'Bug', 'Poison', 15),
  (15, 'Beedrill', 'Bug', 'Poison', NULL),
  (16, 'Pidgey', 'Normal', 'Flying', 17),
  (17, 'Pidgeotto', 'Normal', 'Flying', 18),
  (18, 'Pidgeot', 'Normal', 'Flying', NULL),
  (19, 'Rattata', 'Normal', NULL, 20),
  (20, 'Raticate', 'Normal', NULL, NULL),
  (21, 'Spearow', 'Normal', 'Flying', 22),
  (22, 'Fearow', 'Normal', 'Flying', NULL),
  (23, 'Ekans', 'Poison', NULL, 24),
  (24, 'Arbok', 'Poison', NULL, NULL),
  (25, 'Pikachu', 'Electric', NULL, 26),
  (26, 'Raichu', 'Electric', NULL, NULL),
  (27, 'Sandshrew', 'Ground', NULL, 28),
  (28, 'Sandslash', 'Ground', NULL, NULL),
  (29, 'Nidoran-f', 'Poison', NULL, 30),
  (30, 'Nidorina', 'Poison', NULL, 31),
  (31, 'Nidoqueen', 'Poison', 'Ground', NULL),
  (32, 'Nidoran-m', 'Poison', NULL, 33),
  (33, 'Nidorino', 'Poison', NULL, 34),
  (34, 'Nidoking', 'Poison', 'Ground', NULL),
  (35, 'Clefairy', 'Fairy', NULL, 36),
  (36, 'Clefable', 'Fairy', NULL, NULL),
  (37, 'Vulpix', 'Fire', NULL, 38),
  (38, 'Ninetales', 'Fire', NULL, NULL),
  (39, 'Jigglypuff', 'Normal', 'Fairy', 40),
  (40, 'Wigglytuff', 'Normal', 'Fairy', NULL),
  (41, 'Zubat', 'Poison', 'Flying', 42),
  (42, 'Golbat', 'Poison', 'Flying', NULL),
  (43, 'Oddish', 'Grass', 'Poison', 44),
  (44, 'Gloom', 'Grass', 'Poison', 45),
  (45, 'Vileplume', 'Grass', 'Poison', NULL),
  (46, 'Paras', 'Bug', 'Grass', 47),
  (47, 'Parasect', 'Bug', 'Grass', NULL),
  (48, 'Venonat', 'Bug', 'Poison', 49),
  (49, 'Venomoth', 'Bug', 'Poison', NULL),
  (50, 'Diglett', 'Ground', NULL, 51),
  (51, 'Dugtrio', 'Ground', NULL, NULL),
  (52, 'Meowth', 'Normal', NULL, 53),
  (53, 'Persian', 'Normal', NULL, NULL),
  (54, 'Psyduck', 'Water', NULL, 55),
  (55, 'Golduck', 'Water', NULL, NULL),
  (56, 'Mankey', 'Fighting', NULL, 57),
  (57, 'Primeape', 'Fighting', NULL, NULL),
  (58, 'Growlithe', 'Fire', NULL, 59),
  (59, 'Arcanine', 'Fire', NULL, NULL),
  (60, 'Poliwag', 'Water', NULL, 61),
  (61, 'Poliwhirl', 'Water', NULL, 62),
  (62, 'Poliwrath', 'Water', 'Fighting', NULL),
  (63, 'Abra', 'Psychic', NULL, 64),
  (64, 'Kadabra', 'Psychic', NULL, 65),
  (65, 'Alakazam', 'Psychic', NULL, NULL),
  (66, 'Machop', 'Fighting', NULL, 67),
  (67, 'Machoke', 'Fighting', NULL, 68),
  (68, 'Machamp', 'Fighting', NULL, NULL),
  (69, 'Bellsprout', 'Grass', 'Poison', 70),
  (70, 'Weepinbell', 'Grass', 'Poison', 71),
  (71, 'Victreebel', 'Grass', 'Poison', NULL),
  (72, 'Tentacool', 'Water', 'Poison', 73),
  (73, 'Tentacruel', 'Water', 'Poison', NULL),
  (74, 'Geodude', 'Rock', 'Ground', 75),
  (75, 'Graveler', 'Rock', 'Ground', 76),
  (76, 'Golem', 'Rock', 'Ground', NULL),
  (77, 'Ponyta', 'Fire', NULL, 78),
  (78, 'Rapidash', 'Fire', NULL, NULL),
  (79, 'Slowpoke', 'Water', 'Psychic', 80),
  (80, 'Slowbro', 'Water', 'Psychic', NULL),
  (81, 'Magnemite', 'Electric', 'Steel', 82),
  (82, 'Magneton', 'Electric', 'Steel', NULL),
  (83, 'Farfetchd', 'Normal', 'Flying', NULL),
  (84, 'Doduo', 'Normal', 'Flying', 85),
  (85, 'Dodrio', 'Normal', 'Flying', NULL),
  (86, 'Seel', 'Water', NULL, 87),
  (87, 'Dewgong', 'Water', 'Ice', NULL),
  (88, 'Grimer', 'Poison', NULL, 89),
  (89, 'Muk', 'Poison', NULL, NULL),
  (90, 'Shellder', 'Water', NULL, 91),
  (91, 'Cloyster', 'Water', 'Ice', NULL),
  (92, 'Gastly', 'Ghost', 'Poison', 93),
  (93, 'Haunter', 'Ghost', 'Poison', 94),
  (94, 'Gengar', 'Ghost', 'Poison', NULL),
  (95, 'Onix', 'Rock', 'Ground', NULL),
  (96, 'Drowzee', 'Psychic', NULL, 97),
  (97, 'Hypno', 'Psychic', NULL, NULL),
  (98, 'Krabby', 'Water', NULL, 99),
  (99, 'Kingler', 'Water', NULL, NULL),
  (100, 'Voltorb', 'Electric', NULL, 101),
  (101, 'Electrode', 'Electric', NULL, NULL),
  (102, 'Exeggcute', 'Grass', 'Psychic', 103),
  (103, 'Exeggutor', 'Grass', 'Psychic', NULL),
  (104, 'Cubone', 'Ground', NULL, 105),
  (105, 'Marowak', 'Ground', NULL, NULL),
  (106, 'Hitmonlee', 'Fighting', NULL, NULL),
  (107, 'Hitmonchan', 'Fighting', NULL, NULL),
  (108, 'Lickitung', 'Normal', NULL, NULL),
  (109, 'Koffing', 'Poison', NULL, 110),
  (110, 'Weezing', 'Poison', NULL, NULL),
  (111, 'Rhyhorn', 'Ground', 'Rock', 112),
  (112, 'Rhydon', 'Ground', 'Rock', NULL),
  (113, 'Chansey', 'Normal', NULL, NULL),
  (114, 'Tangela', 'Grass', NULL, NULL),
  (115, 'Kangaskhan', 'Normal', NULL, NULL),
  (116, 'Horsea', 'Water', NULL, 117),
  (117, 'Seadra', 'Water', NULL, NULL),
  (118, 'Goldeen', 'Water', NULL, 119),
  (119, 'Seaking', 'Water', NULL, NULL),
  (120, 'Staryu', 'Water', NULL, 121),
  (121, 'Starmie', 'Water', 'Psychic', NULL),
  (122, 'Mr-mime', 'Psychic', 'Fairy', NULL),
  (123, 'Scyther', 'Bug', 'Flying', NULL),
  (124, 'Jynx', 'Ice', 'Psychic', NULL),
  (125, 'Electabuzz', 'Electric', NULL, NULL),
  (126, 'Magmar', 'Fire', NULL, NULL),
  (127, 'Pinsir', 'Bug', NULL, NULL),
  (128, 'Tauros', 'Normal', NULL, NULL),
  (129, 'Magikarp', 'Water', NULL, 130),
  (130, 'Gyarados', 'Water', 'Flying', NULL),
  (131, 'Lapras', 'Water', 'Ice', NULL),
  (132, 'Ditto', 'Normal', NULL, NULL),
  (133, 'Eevee', 'Normal', NULL, 134),
  (134, 'Vaporeon', 'Water', NULL, NULL),
  (135, 'Jolteon', 'Electric', NULL, NULL),
  (136, 'Flareon', 'Fire', NULL, NULL),
  (137, 'Porygon', 'Normal', NULL, NULL),
  (138, 'Omanyte', 'Rock', 'Water', 139),
  (139, 'Omastar', 'Rock', 'Water', NULL),
  (140, 'Kabuto', 'Rock', 'Water', 141),
  (141, 'Kabutops', 'Rock', 'Water', NULL),
  (142, 'Aerodactyl', 'Rock', 'Flying', NULL),
  (143, 'Snorlax', 'Normal', NULL, NULL),
  (144, 'Articuno', 'Ice', 'Flying', NULL),
  (145, 'Zapdos', 'Electric', 'Flying', NULL),
  (146, 'Moltres', 'Fire', 'Flying', NULL),
  (147, 'Dratini', 'Dragon', NULL, 148),
  (148, 'Dragonair', 'Dragon', NULL, 149),
  (149, 'Dragonite', 'Dragon', 'Flying', NULL),
  (150, 'Mewtwo', 'Psychic', NULL, NULL),
  (151, 'Mew', 'Psychic', NULL, NULL);

-- Tabela: Treinador
INSERT INTO `Treinador` (`id_treinador`, `nome`, `cidade`, `data_inscricao`, `pontos_ranking`) VALUES
  (1, 'Milena Nogueira', 'Pallet Town', '2024-06-14', 0),
  (2, 'Vinicius Costa', 'Cerulean City', '2024-07-21', 0),
  (3, 'Henrique Moraes', 'Six Island', '2024-02-07', 0),
  (4, 'Nicole Castro', 'Outcast Island', '2024-02-18', 0),
  (5, 'Letícia da Paz', 'Cerulean City', '2024-10-25', 0),
  (6, 'Ayla Fernandes', 'Three Island', '2025-04-10', 0),
  (7, 'Eloá Cavalcanti', 'Cerulean City', '2024-04-19', 0),
  (8, 'Clara Dias', 'Four Island', '2024-02-14', 0),
  (9, 'Davi Pimenta', 'Cinnabar Island', '2024-08-02', 0),
  (10, 'Dra. Gabriela Moraes', 'Cinnabar Island', '2024-05-03', 0),
  (11, 'Camila Fernandes', 'Four Island', '2024-10-09', 0),
  (12, 'Sra. Sarah Teixeira', 'Seven Island', '2024-01-31', 0),
  (13, 'Jade Gomes', 'Pewter City', '2024-03-04', 0),
  (14, 'Catarina Cunha', 'Seven Island', '2024-11-18', 0),
  (15, 'Manuella Santos', 'Cerulean City', '2025-04-30', 0),
  (16, 'Sra. Alexia Caldeira', 'Seven Island', '2024-10-22', 0),
  (17, 'Jade Barbosa', 'Cerulean City', '2024-07-22', 0),
  (18, 'Hadassa Vieira', 'Pewter City', '2025-05-14', 0),
  (19, 'Alana Almeida', 'Six Island', '2024-01-24', 0),
  (20, 'Maya Pereira', 'Pallet Town', '2025-03-15', 0),
  (21, 'Luiz Miguel Peixoto', 'Four Island', '2024-05-28', 0),
  (22, 'Anthony Gabriel da Cruz', 'Six Island', '2024-03-14', 0),
  (23, 'Maria Mendonça', 'Seven Island', '2024-03-01', 0),
  (24, 'Lucas Gabriel Peixoto', 'Six Island', '2024-06-06', 0),
  (25, 'Sra. Mariah Aragão', 'Vermilion City', '2025-02-21', 0),
  (26, 'Ana Liz Oliveira', 'Seven Island', '2024-02-22', 0),
  (27, 'Joaquim da Cruz', 'Viridian City', '2024-10-19', 0),
  (28, 'Otávio da Luz', 'Fuchsia City', '2024-07-09', 0),
  (29, 'Maysa Vargas', 'Cinnabar Island', '2024-10-07', 0),
  (30, 'Nicolas Sá', 'Cerulean City', '2024-10-15', 0),
  (31, 'Srta. Sophia Casa Grande', 'Viridian City', '2024-11-12', 0),
  (32, 'Maria Julia Mendonça', 'Six Island', '2024-09-11', 0),
  (33, 'Juliana da Mota', 'Saffron City', '2024-08-06', 0),
  (34, 'Cecília Correia', 'Seven Island', '2024-08-26', 0),
  (35, 'Benjamim Câmara', 'Five Island', '2025-04-17', 0),
  (36, 'Mateus Sá', 'Indigo Plateau', '2024-07-04', 0),
  (37, 'Henry Gabriel Camargo', 'Vermilion City', '2024-05-07', 0),
  (38, 'Danilo Peixoto', 'Pewter City', '2024-12-23', 0),
  (39, 'Danilo da Conceição', 'Seven Island', '2024-02-11', 0),
  (40, 'Ana Clara Novais', 'Three Island', '2024-06-02', 0),
  (41, 'Antony Fogaça', 'Saffron City', '2024-09-10', 0),
  (42, 'Sra. Isis Rodrigues', 'Five Island', '2025-01-08', 0),
  (43, 'Léo da Paz', 'Birth Island', '2024-05-27', 0),
  (44, 'Oliver Ribeiro', 'Fuchsia City', '2024-02-07', 0),
  (45, 'Dra. Eloá Peixoto', 'Four Island', '2024-09-19', 0),
  (46, 'Liam Ramos', 'Saffron City', '2024-03-25', 0),
  (47, 'Ágatha Nogueira', 'Two Island', '2024-03-18', 0),
  (48, 'Mariah Almeida', 'Cerulean City', '2024-08-03', 0),
  (49, 'Pietro Cavalcanti', 'Cinnabar Island', '2025-05-07', 0),
  (50, 'Isabelly Farias', 'Six Island', '2025-01-26', 0),
  (51, 'Valentim Ferreira', 'Saffron City', '2024-10-20', 0),
  (52, 'João Lucas Jesus', 'Outcast Island', '2024-06-23', 0),
  (53, 'Srta. Alícia Castro', 'Two Island', '2024-10-31', 0),
  (54, 'Davi Lucca da Rocha', 'Five Island', '2024-10-23', 0),
  (55, 'Marcela Andrade', 'Cinnabar Island', '2024-02-05', 0),
  (56, 'Nicolas Marques', 'Lavender Town', '2025-04-28', 0),
  (57, 'Arthur Araújo', 'Cinnabar Island', '2024-08-30', 0),
  (58, 'Maria Julia Moreira', 'Indigo Plateau', '2024-02-01', 0),
  (59, 'Sr. Davi Miguel Silva', 'Seven Island', '2024-11-27', 0),
  (60, 'Sra. Rebeca Melo', 'Five Island', '2024-12-14', 0),
  (61, 'Maria Júlia da Paz', 'One Island', '2024-05-25', 0),
  (62, 'Sr. Luiz Gustavo Martins', 'Outcast Island', '2025-03-30', 0),
  (63, 'Ester Lima', 'Five Island', '2024-01-12', 0),
  (64, 'Felipe Almeida', 'Vermilion City', '2024-06-30', 0),
  (65, 'Vinícius das Neves', 'Fuchsia City', '2024-11-08', 0),
  (66, 'Srta. Maria Luiza Brito', 'Cerulean City', '2024-09-09', 0),
  (67, 'Cauê Araújo', 'Indigo Plateau', '2024-04-21', 0),
  (68, 'Sr. Isaque Ferreira', 'Pewter City', '2024-03-07', 0),
  (69, 'Ian Montenegro', 'One Island', '2024-07-22', 0),
  (70, 'Allana Nunes', 'Two Island', '2025-04-14', 0),
  (71, 'Luna Teixeira', 'Vermilion City', '2024-02-11', 0),
  (72, 'Marina Oliveira', 'One Island', '2024-08-17', 0),
  (73, 'Luísa Casa Grande', 'Lavender Town', '2024-10-08', 0),
  (74, 'Bryan Correia', 'Pallet Town', '2025-03-28', 0),
  (75, 'Sophia Leão', 'Four Island', '2025-02-23', 0),
  (76, 'Theodoro Peixoto', 'Six Island', '2025-03-18', 0),
  (77, 'Srta. Marcela Borges', 'Four Island', '2024-05-22', 0),
  (78, 'Marina Fogaça', 'One Island', '2024-07-02', 0),
  (79, 'Jade Novaes', 'Pewter City', '2025-05-05', 0),
  (80, 'Srta. Yasmin Silva', 'Cinnabar Island', '2024-03-18', 0),
  (81, 'Sr. Asafe Mendes', 'Pallet Town', '2024-03-31', 0),
  (82, 'Thiago da Conceição', 'Pewter City', '2024-04-28', 0),
  (83, 'Thiago Ribeiro', 'Two Island', '2024-01-07', 0),
  (84, 'Sr. João Miguel da Conceição', 'Seven Island', '2025-03-01', 0),
  (85, 'Eduarda Aragão', 'Lavender Town', '2024-04-03', 0),
  (86, 'Maria Liz Caldeira', 'Celadon City', '2024-05-24', 0),
  (87, 'Dr. Antony Pires', 'Four Island', '2024-03-15', 0),
  (88, 'Arthur Sá', 'Outcast Island', '2024-09-30', 0),
  (89, 'Maria Alice Garcia', 'Seven Island', '2024-11-08', 0),
  (90, 'Arthur Pacheco', 'Pallet Town', '2024-06-12', 0),
  (91, 'Ana Vitória Montenegro', 'Three Island', '2024-12-19', 0),
  (92, 'Sarah Moura', 'Birth Island', '2025-05-01', 0),
  (93, 'Dr. Igor Castro', 'Cerulean City', '2024-12-01', 0),
  (94, 'Lorena da Luz', 'Six Island', '2024-08-21', 0),
  (95, 'Enrico da Mota', 'One Island', '2024-07-19', 0),
  (96, 'Levi Ferreira', 'One Island', '2024-07-23', 0),
  (97, 'Cecília Gonçalves', 'Two Island', '2024-02-23', 0),
  (98, 'Srta. Jade Cavalcanti', 'One Island', '2024-11-20', 0),
  (99, 'Sra. Rebeca Freitas', 'Viridian City', '2024-02-01', 0),
  (100, 'Eduardo Moraes', 'Viridian City', '2024-02-04', 0),
  (101, 'Matheus Mendes', 'Vermilion City', '2024-08-13', 0),
  (102, 'Kamilly Vargas', 'Saffron City', '2024-02-26', 0),
  (103, 'Ana Sophia Andrade', 'Cerulean City', '2024-11-03', 0),
  (104, 'Luigi Mendonça', 'Celadon City', '2024-02-22', 0),
  (105, 'Dr. Gustavo Henrique das Neves', 'Pallet Town', '2024-10-17', 0),
  (106, 'Ravy Araújo', 'Fuchsia City', '2024-10-01', 0),
  (107, 'Maitê Campos', 'Outcast Island', '2025-04-30', 0),
  (108, 'Gustavo Henrique Sales', 'Celadon City', '2024-11-10', 0),
  (109, 'Noah Duarte', 'Viridian City', '2024-02-06', 0),
  (110, 'Davi Lucca da Mata', 'One Island', '2024-11-10', 0),
  (111, 'Juliana da Costa', 'Lavender Town', '2024-03-17', 0),
  (112, 'Ravy Rios', 'Outcast Island', '2025-05-04', 0),
  (113, 'Liz Gonçalves', 'Outcast Island', '2024-11-04', 0),
  (114, 'Raul da Cunha', 'Fuchsia City', '2024-08-30', 0),
  (115, 'Luana Monteiro', 'Two Island', '2024-02-29', 0),
  (116, 'Maria Flor Machado', 'Five Island', '2025-05-15', 0),
  (117, 'Mirella Moura', 'Two Island', '2024-09-02', 0),
  (118, 'Igor Costela', 'Cinnabar Island', '2024-06-08', 0),
  (119, 'Joana Peixoto', 'Fuchsia City', '2024-03-14', 0),
  (120, 'Mathias Novais', 'Saffron City', '2025-01-18', 0);

-- Tabela: Time_Treinador (Pokémon inscritos por treinador no torneio)
INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (1, 68);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (1, 123);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (1, 42);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (1, 133);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (1, 6);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (1, 53);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (2, 93);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (2, 38);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (2, 140);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (2, 7);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (2, 136);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (3, 24);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (3, 67);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (3, 133);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (4, 43);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (4, 92);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (4, 58);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (5, 139);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (5, 129);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (5, 85);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (5, 58);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (5, 50);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (6, 103);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (6, 59);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (7, 133);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (7, 127);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (8, 8);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (8, 72);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (8, 121);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (9, 50);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (9, 89);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (9, 115);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (10, 90);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (10, 94);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (10, 21);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (10, 57);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (10, 27);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (10, 59);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (11, 51);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (11, 87);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (11, 53);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (11, 124);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (12, 1);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (12, 123);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (12, 89);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (12, 22);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (12, 31);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (13, 52);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (13, 123);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (13, 46);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (13, 112);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (14, 86);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (14, 23);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (14, 102);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (14, 119);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (14, 103);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (14, 22);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (15, 41);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (15, 44);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (15, 33);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (15, 8);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (15, 39);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (15, 120);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (16, 38);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (16, 122);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (16, 90);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (16, 40);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (16, 141);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (16, 34);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (17, 4);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (18, 27);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (18, 135);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (18, 36);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (18, 112);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (18, 50);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (18, 55);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (19, 65);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (20, 75);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (20, 129);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (21, 151);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (21, 84);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (22, 140);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (22, 108);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (22, 34);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (23, 91);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (24, 150);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (24, 133);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (24, 108);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (24, 129);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (25, 137);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (25, 39);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (26, 131);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (26, 5);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (26, 113);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (26, 47);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (26, 2);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (27, 45);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (27, 37);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (28, 31);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (28, 143);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (28, 16);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (28, 84);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (29, 133);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (29, 136);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (29, 143);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (29, 124);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (29, 28);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (29, 144);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (30, 64);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (31, 71);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (31, 11);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (32, 130);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (33, 144);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (33, 8);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (33, 17);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (33, 114);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (34, 130);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (34, 132);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (34, 52);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (35, 71);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (35, 116);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (35, 131);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (35, 137);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (35, 123);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (35, 130);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (36, 134);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (36, 67);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (37, 52);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (37, 115);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (37, 36);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (37, 107);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (37, 32);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (38, 114);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (38, 81);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (38, 19);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (38, 62);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (39, 19);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (39, 55);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (39, 78);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (39, 32);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (40, 94);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (40, 37);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (41, 36);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (41, 120);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (41, 57);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (42, 25);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (42, 102);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (42, 125);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (42, 42);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (42, 58);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (42, 111);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (43, 104);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (43, 87);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (43, 108);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (43, 51);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (43, 92);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (44, 24);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (44, 94);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (44, 5);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (45, 142);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (45, 118);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (45, 113);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (46, 5);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (46, 99);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (46, 85);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (46, 133);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (46, 76);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (46, 132);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (47, 29);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (48, 27);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (48, 22);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (49, 70);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (49, 11);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (49, 47);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (50, 34);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (50, 109);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (50, 67);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (51, 39);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (51, 138);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (51, 132);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (51, 147);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (52, 84);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (52, 23);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (52, 72);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (52, 15);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (53, 47);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (53, 109);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (53, 19);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (53, 69);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (53, 5);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (53, 23);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (54, 22);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (54, 57);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (54, 18);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (55, 32);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (55, 117);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (55, 3);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (56, 142);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (56, 107);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (56, 69);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (57, 34);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (57, 12);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (57, 135);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (57, 62);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (57, 29);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (58, 68);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (58, 13);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (59, 52);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (59, 80);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (60, 79);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (60, 136);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (60, 53);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (60, 75);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (60, 115);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (60, 129);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (61, 46);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (61, 70);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (61, 89);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (61, 5);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (61, 65);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (61, 10);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (62, 5);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (63, 130);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (63, 142);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (63, 49);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (63, 132);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (63, 122);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (63, 63);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (64, 28);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (64, 111);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (64, 127);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (64, 140);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (65, 130);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (65, 79);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (65, 56);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (65, 59);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (66, 51);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (66, 36);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (66, 104);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (67, 14);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (67, 34);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (67, 4);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (68, 66);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (69, 42);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (69, 15);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (69, 22);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (69, 98);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (70, 73);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (70, 63);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (70, 76);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (70, 12);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (70, 118);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (71, 41);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (71, 69);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (72, 1);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (72, 68);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (72, 94);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (72, 85);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (73, 83);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (73, 63);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (73, 9);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (73, 80);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (73, 56);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (74, 47);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (74, 1);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (74, 86);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (75, 22);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (75, 122);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (75, 72);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (75, 129);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (76, 52);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (76, 64);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (76, 130);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (76, 2);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (76, 24);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (76, 68);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (77, 37);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (78, 151);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (78, 11);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (78, 101);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (78, 6);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (79, 78);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (79, 60);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (79, 22);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (80, 136);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (80, 40);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (80, 100);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (80, 84);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (80, 127);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (81, 73);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (81, 38);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (82, 132);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (83, 110);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (83, 130);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (83, 36);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (83, 135);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (83, 146);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (83, 5);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (84, 150);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (84, 59);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (84, 22);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (84, 8);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (84, 11);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (84, 35);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (85, 93);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (85, 27);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (85, 97);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (85, 116);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (85, 143);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (85, 13);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (86, 5);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (86, 137);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (86, 63);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (86, 126);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (86, 68);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (86, 1);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (87, 18);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (87, 129);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (87, 138);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (87, 24);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (88, 135);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (88, 17);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (88, 122);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (88, 65);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (88, 20);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (88, 68);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (89, 53);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (89, 60);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (90, 118);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (90, 127);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (90, 98);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (90, 20);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (90, 123);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (90, 74);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (91, 51);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (92, 38);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (93, 66);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (93, 78);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (93, 146);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (94, 4);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (94, 124);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (95, 125);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (96, 26);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (96, 56);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (96, 126);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (97, 133);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (97, 74);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (97, 119);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (98, 120);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (98, 31);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (98, 141);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (98, 52);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (99, 22);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (99, 122);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (99, 5);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (100, 118);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (100, 20);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (100, 130);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (101, 69);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (101, 100);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (101, 54);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (101, 20);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (102, 24);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (102, 37);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (102, 135);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (102, 68);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (102, 93);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (103, 131);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (103, 72);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (104, 94);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (105, 128);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (105, 125);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (106, 7);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (106, 41);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (106, 1);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (106, 126);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (107, 116);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (107, 104);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (107, 78);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (107, 37);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (107, 107);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (107, 89);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (108, 81);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (108, 31);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (108, 85);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (108, 1);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (109, 87);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (109, 102);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (109, 31);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (110, 4);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (110, 75);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (111, 96);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (111, 17);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (111, 101);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (112, 151);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (112, 20);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (112, 93);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (112, 110);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (113, 13);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (113, 72);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (113, 27);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (114, 74);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (115, 39);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (115, 64);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (115, 69);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (115, 112);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (115, 131);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (115, 81);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (116, 96);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (116, 110);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (117, 103);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (118, 141);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (118, 53);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (118, 21);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (118, 13);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (118, 106);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (119, 36);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (119, 74);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (119, 125);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (119, 13);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (120, 33);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (120, 44);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (120, 121);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (120, 107);

INSERT INTO `Time_Treinador` (`Treinador_id_treinador`, `Pokemon_id_especie`) VALUES
  (120, 88);

-- Tabela: Golpe (catálogo de golpes)
INSERT INTO `Golpe` (`id_golpe`, `nome`, `tipo`, `poder`, `precisao`, `pp_maximo`) VALUES
  (1, 'Pound', 'Normal', 40, 100, 35),
  (2, 'Karate Chop', 'Fighting', 50, 100, 25),
  (3, 'Double Slap', 'Normal', 15, 85, 10),
  (4, 'Comet Punch', 'Normal', 18, 85, 15),
  (5, 'Mega Punch', 'Normal', 80, 85, 20),
  (6, 'Pay Day', 'Normal', 40, 100, 20),
  (7, 'Fire Punch', 'Fire', 75, 100, 15),
  (8, 'Ice Punch', 'Ice', 75, 100, 15),
  (9, 'Thunder Punch', 'Electric', 75, 100, 15),
  (10, 'Scratch', 'Normal', 40, 100, 35),
  (11, 'Vice Grip', 'Normal', 55, 100, 30),
  (12, 'Guillotine', 'Normal', NULL, 30, 5),
  (13, 'Razor Wind', 'Normal', 80, 100, 10),
  (14, 'Swords Dance', 'Normal', NULL, NULL, 20),
  (15, 'Cut', 'Normal', 50, 95, 30),
  (16, 'Gust', 'Flying', 40, 100, 35),
  (17, 'Wing Attack', 'Flying', 60, 100, 35),
  (18, 'Whirlwind', 'Normal', NULL, NULL, 20),
  (19, 'Fly', 'Flying', 90, 95, 15),
  (20, 'Bind', 'Normal', 15, 85, 20),
  (21, 'Slam', 'Normal', 80, 75, 20),
  (22, 'Vine Whip', 'Grass', 45, 100, 25),
  (23, 'Stomp', 'Normal', 65, 100, 20),
  (24, 'Double Kick', 'Fighting', 30, 100, 30),
  (25, 'Mega Kick', 'Normal', 120, 75, 5),
  (26, 'Jump Kick', 'Fighting', 100, 95, 10),
  (27, 'Rolling Kick', 'Fighting', 60, 85, 15),
  (28, 'Sand Attack', 'Ground', NULL, 100, 15),
  (29, 'Headbutt', 'Normal', 70, 100, 15),
  (30, 'Horn Attack', 'Normal', 65, 100, 25),
  (31, 'Fury Attack', 'Normal', 15, 85, 20),
  (32, 'Horn Drill', 'Normal', NULL, 30, 5),
  (33, 'Tackle', 'Normal', 40, 100, 35),
  (34, 'Body Slam', 'Normal', 85, 100, 15),
  (35, 'Wrap', 'Normal', 15, 90, 20),
  (36, 'Take Down', 'Normal', 90, 85, 20),
  (37, 'Thrash', 'Normal', 120, 100, 10),
  (38, 'Double Edge', 'Normal', 120, 100, 15),
  (39, 'Tail Whip', 'Normal', NULL, 100, 30),
  (40, 'Poison Sting', 'Poison', 15, 100, 35),
  (41, 'Twineedle', 'Bug', 25, 100, 20),
  (42, 'Pin Missile', 'Bug', 25, 95, 20),
  (43, 'Leer', 'Normal', NULL, 100, 30),
  (44, 'Bite', 'Dark', 60, 100, 25),
  (45, 'Growl', 'Normal', NULL, 100, 40),
  (46, 'Roar', 'Normal', NULL, NULL, 20),
  (47, 'Sing', 'Normal', NULL, 55, 15),
  (48, 'Supersonic', 'Normal', NULL, 55, 20),
  (49, 'Sonic Boom', 'Normal', NULL, 90, 20),
  (50, 'Disable', 'Normal', NULL, 100, 20),
  (51, 'Acid', 'Poison', 40, 100, 30),
  (52, 'Ember', 'Fire', 40, 100, 25),
  (53, 'Flamethrower', 'Fire', 90, 100, 15),
  (54, 'Mist', 'Ice', NULL, NULL, 30),
  (55, 'Water Gun', 'Water', 40, 100, 25),
  (56, 'Hydro Pump', 'Water', 110, 80, 5),
  (57, 'Surf', 'Water', 90, 100, 15),
  (58, 'Ice Beam', 'Ice', 90, 100, 10),
  (59, 'Blizzard', 'Ice', 110, 70, 5),
  (60, 'Psybeam', 'Psychic', 65, 100, 20),
  (61, 'Bubble Beam', 'Water', 65, 100, 20),
  (62, 'Aurora Beam', 'Ice', 65, 100, 20),
  (63, 'Hyper Beam', 'Normal', 150, 90, 5),
  (64, 'Peck', 'Flying', 35, 100, 35),
  (65, 'Drill Peck', 'Flying', 80, 100, 20),
  (66, 'Submission', 'Fighting', 80, 80, 20),
  (67, 'Low Kick', 'Fighting', NULL, 100, 20),
  (68, 'Counter', 'Fighting', NULL, 100, 20),
  (69, 'Seismic Toss', 'Fighting', NULL, 100, 20),
  (70, 'Strength', 'Normal', 80, 100, 15),
  (71, 'Absorb', 'Grass', 20, 100, 25),
  (72, 'Mega Drain', 'Grass', 40, 100, 15),
  (73, 'Leech Seed', 'Grass', NULL, 90, 10),
  (74, 'Growth', 'Normal', NULL, NULL, 20),
  (75, 'Razor Leaf', 'Grass', 55, 95, 25),
  (76, 'Solar Beam', 'Grass', 120, 100, 10),
  (77, 'Poison Powder', 'Poison', NULL, 75, 35),
  (78, 'Stun Spore', 'Grass', NULL, 75, 30),
  (79, 'Sleep Powder', 'Grass', NULL, 75, 15),
  (80, 'Petal Dance', 'Grass', 120, 100, 10),
  (81, 'String Shot', 'Bug', NULL, 95, 40),
  (82, 'Dragon Rage', 'Dragon', NULL, 100, 10),
  (83, 'Fire Spin', 'Fire', 35, 85, 15),
  (84, 'Thunder Shock', 'Electric', 40, 100, 30),
  (85, 'Thunderbolt', 'Electric', 90, 100, 15),
  (86, 'Thunder Wave', 'Electric', NULL, 90, 20),
  (87, 'Thunder', 'Electric', 110, 70, 10),
  (88, 'Rock Throw', 'Rock', 50, 90, 15),
  (89, 'Earthquake', 'Ground', 100, 100, 10),
  (90, 'Fissure', 'Ground', NULL, 30, 5),
  (91, 'Dig', 'Ground', 80, 100, 10),
  (92, 'Toxic', 'Poison', NULL, 90, 10),
  (93, 'Confusion', 'Psychic', 50, 100, 25),
  (94, 'Psychic', 'Psychic', 90, 100, 10),
  (95, 'Hypnosis', 'Psychic', NULL, 60, 20),
  (96, 'Meditate', 'Psychic', NULL, NULL, 40),
  (97, 'Agility', 'Psychic', NULL, NULL, 30),
  (98, 'Quick Attack', 'Normal', 40, 100, 30),
  (99, 'Rage', 'Normal', 20, 100, 20),
  (100, 'Teleport', 'Psychic', NULL, NULL, 20),
  (101, 'Night Shade', 'Ghost', NULL, 100, 15),
  (102, 'Mimic', 'Normal', NULL, NULL, 10),
  (103, 'Screech', 'Normal', NULL, 85, 40),
  (104, 'Double Team', 'Normal', NULL, NULL, 15),
  (105, 'Recover', 'Normal', NULL, NULL, 5),
  (106, 'Harden', 'Normal', NULL, NULL, 30),
  (107, 'Minimize', 'Normal', NULL, NULL, 10),
  (108, 'Smokescreen', 'Normal', NULL, 100, 20),
  (109, 'Confuse Ray', 'Ghost', NULL, 100, 10),
  (110, 'Withdraw', 'Water', NULL, NULL, 40);

-- Tabela: Pokemon_Golpe (golpes que cada espécie pode aprender)
INSERT INTO `Pokemon_Golpe` (`Pokemon_id_especie`, `Golpe_id_golpe`) VALUES
  (1, 13),
  (1, 33),
  (1, 29),
  (1, 70),
  (1, 77),
  (1, 76),
  (2, 70),
  (2, 76),
  (2, 92),
  (2, 15),
  (2, 72),
  (2, 73),
  (3, 72),
  (3, 92),
  (3, 45),
  (3, 33),
  (3, 102),
  (3, 14),
  (4, 104),
  (4, 53),
  (4, 99),
  (4, 17),
  (4, 15),
  (4, 34),
  (5, 29),
  (5, 43),
  (5, 66),
  (5, 7),
  (5, 15),
  (5, 69),
  (6, 70),
  (6, 44),
  (6, 29),
  (6, 46),
  (6, 69),
  (6, 53),
  (7, 66),
  (7, 57),
  (7, 55),
  (7, 61),
  (7, 8),
  (7, 33),
  (8, 70),
  (8, 91),
  (8, 104),
  (8, 57),
  (8, 39),
  (8, 59),
  (9, 66),
  (9, 33),
  (9, 69),
  (9, 57),
  (9, 89),
  (9, 46),
  (10, 33),
  (10, 81),
  (10, 9),
  (10, 105),
  (10, 8),
  (10, 34),
  (11, 106),
  (11, 81),
  (11, 97),
  (11, 9),
  (11, 78),
  (11, 44),
  (12, 38),
  (12, 18),
  (12, 78),
  (12, 33),
  (12, 36),
  (12, 48),
  (13, 40),
  (13, 81),
  (13, 17),
  (13, 65),
  (13, 24),
  (13, 2),
  (14, 81),
  (14, 106),
  (14, 108),
  (14, 90),
  (14, 100),
  (14, 20),
  (15, 38),
  (15, 106),
  (15, 102),
  (15, 36),
  (15, 14),
  (15, 81),
  (16, 97),
  (16, 17),
  (16, 13),
  (16, 33),
  (16, 104),
  (16, 102),
  (17, 13),
  (17, 97),
  (17, 104),
  (17, 28),
  (17, 29),
  (17, 102),
  (18, 33),
  (18, 104),
  (18, 38),
  (18, 16),
  (18, 63),
  (18, 36),
  (19, 33),
  (19, 61),
  (19, 59),
  (19, 55),
  (19, 98),
  (19, 39),
  (20, 55),
  (20, 104),
  (20, 39),
  (20, 99),
  (20, 92),
  (20, 61),
  (21, 65),
  (21, 19),
  (21, 104),
  (21, 13),
  (21, 98),
  (21, 29),
  (22, 102),
  (22, 97),
  (22, 38),
  (22, 17),
  (22, 18),
  (22, 64),
  (23, 89),
  (23, 70),
  (23, 92),
  (23, 51),
  (23, 91),
  (23, 21),
  (24, 43),
  (24, 70),
  (24, 90),
  (24, 51),
  (24, 92),
  (24, 20),
  (25, 24),
  (25, 21),
  (25, 91),
  (25, 68),
  (25, 39),
  (25, 38),
  (26, 69),
  (26, 6),
  (26, 104),
  (26, 97),
  (26, 98),
  (26, 25),
  (27, 91),
  (27, 29),
  (27, 102),
  (27, 92),
  (27, 67),
  (27, 68),
  (28, 63),
  (28, 69),
  (28, 40),
  (28, 92),
  (28, 34),
  (28, 91),
  (29, 38),
  (29, 50),
  (29, 24),
  (29, 45),
  (29, 102),
  (29, 70),
  (30, 59),
  (30, 36),
  (30, 10),
  (30, 55),
  (30, 24),
  (30, 70),
  (31, 58),
  (31, 15),
  (31, 104),
  (31, 32),
  (31, 70),
  (31, 55),
  (32, 37),
  (32, 64),
  (32, 38),
  (32, 24),
  (32, 68),
  (32, 104),
  (33, 58),
  (33, 70),
  (33, 61),
  (33, 91),
  (33, 99),
  (33, 31),
  (34, 30),
  (34, 33);

INSERT INTO `Pokemon_Golpe` (`Pokemon_id_especie`, `Golpe_id_golpe`) VALUES
  (34, 43),
  (34, 89),
  (34, 24),
  (34, 85),
  (35, 38),
  (35, 87),
  (35, 7),
  (35, 99),
  (35, 61),
  (35, 100),
  (36, 38),
  (36, 33),
  (36, 94),
  (36, 47),
  (36, 91),
  (36, 1),
  (37, 39),
  (37, 38),
  (37, 97),
  (37, 50),
  (37, 104),
  (37, 36),
  (38, 76),
  (38, 98),
  (38, 38),
  (38, 34),
  (38, 36),
  (38, 52),
  (39, 34),
  (39, 36),
  (39, 8),
  (39, 99),
  (39, 94),
  (39, 102),
  (40, 36),
  (40, 1),
  (40, 103),
  (40, 3),
  (40, 66),
  (40, 86),
  (41, 13),
  (41, 102),
  (41, 36),
  (41, 48),
  (41, 95),
  (41, 44),
  (42, 16),
  (42, 98),
  (42, 63),
  (42, 72),
  (42, 17),
  (42, 29),
  (43, 38),
  (43, 29),
  (43, 102),
  (43, 92),
  (43, 99),
  (43, 15),
  (44, 74),
  (44, 51),
  (44, 99),
  (44, 15),
  (44, 102),
  (44, 80),
  (45, 99),
  (45, 72),
  (45, 77),
  (45, 104),
  (45, 76),
  (45, 73),
  (46, 71),
  (46, 14),
  (46, 78),
  (46, 15),
  (46, 92),
  (46, 81),
  (47, 10),
  (47, 34),
  (47, 36),
  (47, 68),
  (47, 76),
  (47, 73),
  (48, 97),
  (48, 38),
  (48, 50),
  (48, 77),
  (48, 102),
  (48, 33),
  (49, 93),
  (49, 38),
  (49, 48),
  (49, 79),
  (49, 92),
  (49, 104),
  (50, 90),
  (50, 14),
  (50, 97),
  (50, 10),
  (50, 89),
  (50, 99),
  (51, 103),
  (51, 10),
  (51, 91),
  (51, 102),
  (51, 34),
  (51, 63),
  (52, 38),
  (52, 10),
  (52, 44),
  (52, 91),
  (52, 103),
  (52, 29),
  (53, 92),
  (53, 46),
  (53, 95),
  (53, 34),
  (53, 45),
  (53, 86),
  (54, 92),
  (54, 8),
  (54, 70),
  (54, 109),
  (54, 5),
  (54, 102),
  (55, 38),
  (55, 67),
  (55, 55),
  (55, 29),
  (55, 102),
  (55, 58),
  (56, 6),
  (56, 85),
  (56, 92),
  (56, 99),
  (56, 7),
  (56, 104),
  (57, 85),
  (57, 89),
  (57, 92),
  (57, 9),
  (57, 25),
  (57, 29),
  (58, 52),
  (58, 43),
  (58, 102),
  (58, 83),
  (58, 53),
  (58, 82),
  (59, 102),
  (59, 63),
  (59, 97),
  (59, 44),
  (59, 37),
  (59, 83),
  (60, 3),
  (60, 56),
  (60, 102),
  (60, 91),
  (60, 99),
  (60, 1),
  (61, 38),
  (61, 55),
  (61, 8),
  (61, 67),
  (61, 92),
  (61, 3),
  (62, 55),
  (62, 25),
  (62, 99),
  (62, 8),
  (62, 94),
  (62, 58),
  (63, 102),
  (63, 100),
  (63, 5),
  (63, 36),
  (63, 69),
  (63, 66),
  (64, 29),
  (64, 95),
  (64, 92),
  (64, 94),
  (64, 100),
  (64, 34),
  (65, 9),
  (65, 94),
  (65, 100),
  (65, 86),
  (65, 25),
  (65, 91),
  (66, 34),
  (66, 8),
  (66, 92),
  (66, 7),
  (66, 102),
  (66, 27),
  (67, 70),
  (67, 90),
  (67, 34),
  (67, 91);

INSERT INTO `Pokemon_Golpe` (`Pokemon_id_especie`, `Golpe_id_golpe`) VALUES
  (67, 2),
  (67, 99),
  (68, 70),
  (68, 34),
  (68, 29),
  (68, 90),
  (68, 91),
  (68, 69),
  (69, 51),
  (69, 104),
  (69, 36),
  (69, 102),
  (69, 72),
  (69, 75),
  (70, 34),
  (70, 72),
  (70, 38),
  (70, 29),
  (70, 15),
  (70, 20),
  (71, 34),
  (71, 36),
  (71, 75),
  (71, 79),
  (71, 99),
  (71, 76),
  (72, 40),
  (72, 92),
  (72, 14),
  (72, 55),
  (72, 51),
  (72, 62),
  (73, 58),
  (73, 15),
  (73, 109),
  (73, 55),
  (73, 29),
  (73, 40),
  (74, 90),
  (74, 34),
  (74, 28),
  (74, 9),
  (74, 88),
  (74, 66),
  (75, 106),
  (75, 68),
  (75, 102),
  (75, 33),
  (75, 34),
  (75, 29),
  (76, 46),
  (76, 66),
  (76, 91),
  (76, 38),
  (76, 104),
  (76, 92),
  (77, 38),
  (77, 34),
  (77, 24),
  (77, 83),
  (77, 102),
  (77, 98),
  (78, 92),
  (78, 39),
  (78, 34),
  (78, 23),
  (78, 36),
  (78, 33),
  (79, 29),
  (79, 38),
  (79, 36),
  (79, 99),
  (79, 33),
  (79, 56),
  (80, 5),
  (80, 33),
  (80, 57),
  (80, 89),
  (80, 53),
  (80, 100),
  (81, 33),
  (81, 92),
  (81, 85),
  (81, 36),
  (81, 100),
  (81, 86),
  (82, 63),
  (82, 84),
  (82, 49),
  (82, 86),
  (82, 99),
  (82, 85),
  (83, 98),
  (83, 13),
  (83, 31),
  (83, 43),
  (83, 34),
  (83, 104),
  (84, 99),
  (84, 36),
  (84, 43),
  (84, 98),
  (84, 29),
  (84, 97),
  (85, 97),
  (85, 29),
  (85, 98),
  (85, 17),
  (85, 48),
  (85, 19),
  (86, 64),
  (86, 29),
  (86, 21),
  (86, 36),
  (86, 32),
  (86, 70),
  (87, 70),
  (87, 50),
  (87, 56),
  (87, 36),
  (87, 57),
  (87, 61),
  (88, 50),
  (88, 1),
  (88, 9),
  (88, 109),
  (88, 70),
  (88, 103),
  (89, 92),
  (89, 106),
  (89, 8),
  (89, 104),
  (89, 50),
  (89, 63),
  (90, 103),
  (90, 62),
  (90, 100),
  (90, 55),
  (90, 104),
  (90, 61),
  (91, 42),
  (91, 58),
  (91, 57),
  (91, 62),
  (91, 92),
  (91, 36),
  (92, 9),
  (92, 72),
  (92, 95),
  (92, 50),
  (92, 102),
  (92, 101),
  (93, 99),
  (93, 9),
  (93, 94),
  (93, 85),
  (93, 29),
  (93, 8),
  (94, 87),
  (94, 104),
  (94, 50),
  (94, 69),
  (94, 102),
  (94, 9),
  (95, 90),
  (95, 89),
  (95, 99),
  (95, 70),
  (95, 103),
  (95, 21),
  (96, 1),
  (96, 67),
  (96, 94),
  (96, 7),
  (96, 96),
  (96, 69),
  (97, 66),
  (97, 101),
  (97, 99),
  (97, 68),
  (97, 5),
  (97, 109),
  (98, 36),
  (98, 11),
  (98, 34),
  (98, 57),
  (98, 23),
  (98, 59),
  (99, 38),
  (99, 59),
  (99, 36),
  (99, 63),
  (99, 91),
  (99, 29),
  (100, 92),
  (100, 103),
  (100, 99),
  (100, 86),
  (100, 33),
  (100, 97);

INSERT INTO `Pokemon_Golpe` (`Pokemon_id_especie`, `Golpe_id_golpe`) VALUES
  (101, 85),
  (101, 38),
  (101, 49),
  (101, 103),
  (101, 36),
  (101, 97),
  (102, 70),
  (102, 99),
  (102, 92),
  (102, 73),
  (102, 36),
  (102, 14),
  (103, 89),
  (103, 70),
  (103, 72),
  (103, 38),
  (103, 94),
  (103, 95),
  (104, 43),
  (104, 53),
  (104, 14),
  (104, 70),
  (104, 90),
  (104, 102),
  (105, 66),
  (105, 59),
  (105, 29),
  (105, 99),
  (105, 104),
  (105, 9),
  (106, 96),
  (106, 68),
  (106, 89),
  (106, 34),
  (106, 29),
  (106, 25),
  (107, 8),
  (107, 67),
  (107, 70),
  (107, 43),
  (107, 5),
  (107, 92),
  (108, 29),
  (108, 14),
  (108, 87),
  (108, 76),
  (108, 48),
  (108, 85),
  (109, 102),
  (109, 87),
  (109, 33),
  (109, 36),
  (109, 103),
  (109, 60),
  (110, 60),
  (110, 108),
  (110, 92),
  (110, 33),
  (110, 103),
  (110, 87),
  (111, 91),
  (111, 29),
  (111, 87),
  (111, 90),
  (111, 14),
  (111, 99),
  (112, 31),
  (112, 7),
  (112, 9),
  (112, 61),
  (112, 5),
  (112, 30),
  (113, 9),
  (113, 34),
  (113, 47),
  (113, 33),
  (113, 107),
  (113, 55),
  (114, 76),
  (114, 93),
  (114, 20),
  (114, 74),
  (114, 73),
  (114, 22),
  (115, 102),
  (115, 15),
  (115, 39),
  (115, 7),
  (115, 57),
  (115, 85),
  (116, 104),
  (116, 55),
  (116, 59),
  (116, 82),
  (116, 102),
  (116, 58),
  (117, 104),
  (117, 38),
  (117, 58),
  (117, 56),
  (117, 36),
  (117, 92),
  (118, 55),
  (118, 14),
  (118, 38),
  (118, 64),
  (118, 58),
  (118, 102),
  (119, 31),
  (119, 32),
  (119, 59),
  (119, 104),
  (119, 30),
  (119, 36),
  (120, 60),
  (120, 92),
  (120, 38),
  (120, 56),
  (120, 109),
  (120, 85),
  (121, 107),
  (121, 58),
  (121, 99),
  (121, 106),
  (121, 33),
  (121, 57),
  (122, 92),
  (122, 76),
  (122, 102),
  (122, 68),
  (122, 36),
  (122, 104),
  (123, 92),
  (123, 98),
  (123, 97),
  (123, 63),
  (123, 15),
  (123, 17),
  (124, 66),
  (124, 61),
  (124, 94),
  (124, 55),
  (124, 58),
  (124, 36),
  (125, 9),
  (125, 34),
  (125, 63),
  (125, 94),
  (125, 103),
  (125, 29),
  (126, 70),
  (126, 36),
  (126, 100),
  (126, 99),
  (126, 94),
  (126, 63),
  (127, 106),
  (127, 36),
  (127, 14),
  (127, 104),
  (127, 37),
  (127, 34),
  (128, 59),
  (128, 99),
  (128, 57),
  (128, 34),
  (128, 29),
  (128, 92),
  (129, 33),
  (129, 56),
  (129, 1),
  (129, 65),
  (129, 32),
  (129, 21),
  (130, 61),
  (130, 34),
  (130, 102),
  (130, 59),
  (130, 43),
  (130, 44),
  (131, 55),
  (131, 70),
  (131, 102),
  (131, 62),
  (131, 89),
  (131, 63),
  (132, 9),
  (132, 15),
  (132, 16),
  (132, 63),
  (132, 18),
  (132, 68),
  (133, 99),
  (133, 36),
  (133, 38),
  (133, 102),
  (133, 98),
  (133, 46),
  (134, 54),
  (134, 58);

INSERT INTO `Pokemon_Golpe` (`Pokemon_id_especie`, `Golpe_id_golpe`) VALUES
  (134, 44),
  (134, 59),
  (134, 29),
  (134, 46),
  (135, 24),
  (135, 34),
  (135, 97),
  (135, 38),
  (135, 42),
  (135, 87),
  (136, 83),
  (136, 91),
  (136, 52),
  (136, 102),
  (136, 36),
  (136, 104),
  (137, 94),
  (137, 29),
  (137, 63),
  (137, 59),
  (137, 104),
  (137, 84),
  (138, 110),
  (138, 21),
  (138, 44),
  (138, 62),
  (138, 88),
  (138, 58),
  (139, 34),
  (139, 104),
  (139, 102),
  (139, 20),
  (139, 44),
  (139, 99),
  (140, 102),
  (140, 92),
  (140, 38),
  (140, 43),
  (140, 29),
  (140, 28),
  (141, 34),
  (141, 92),
  (141, 88),
  (141, 67),
  (141, 106),
  (141, 15),
  (142, 29),
  (142, 89),
  (142, 88),
  (142, 19),
  (142, 48),
  (142, 13),
  (143, 104),
  (143, 7),
  (143, 18),
  (143, 68),
  (143, 53),
  (143, 33),
  (144, 46),
  (144, 63),
  (144, 43),
  (144, 58),
  (144, 99),
  (144, 59),
  (145, 46),
  (145, 92),
  (145, 84),
  (145, 104),
  (145, 38),
  (145, 29),
  (146, 99),
  (146, 102),
  (146, 83),
  (146, 13),
  (146, 104),
  (146, 43),
  (147, 36),
  (147, 99),
  (147, 35),
  (147, 87),
  (147, 92),
  (147, 86),
  (148, 59),
  (148, 63),
  (148, 34),
  (148, 58),
  (148, 102),
  (148, 92),
  (149, 5),
  (149, 89),
  (149, 32),
  (149, 25),
  (149, 70),
  (149, 15),
  (150, 104),
  (150, 92),
  (150, 25),
  (150, 50),
  (150, 101),
  (150, 58),
  (151, 32),
  (151, 81),
  (151, 18),
  (151, 109),
  (151, 68),
  (151, 99);

-- Tabela: Batalha (histórico do torneio)
INSERT INTO `Batalha` (`id_batalha`, `data_batalha`, `fase_torneio`, `Treinador_id_treinador`, `Treinador_id_treinador1`, `id_vencedor`) VALUES
  (1, '2025-02-26', 'Fase de Grupos', 85, 83, 85),
  (2, '2025-02-25', 'Fase de Grupos', 85, 5, 5),
  (3, '2025-02-08', 'Fase de Grupos', 83, 5, 83),
  (4, '2025-02-19', 'Fase de Grupos', 117, 114, 117),
  (5, '2025-02-18', 'Fase de Grupos', 117, 67, 67),
  (6, '2025-03-01', 'Fase de Grupos', 114, 67, 114),
  (7, '2025-02-19', 'Fase de Grupos', 14, 65, 65),
  (8, '2025-02-08', 'Fase de Grupos', 19, 64, 19),
  (9, '2025-02-22', 'Fase de Grupos', 19, 57, 57),
  (10, '2025-02-26', 'Fase de Grupos', 64, 57, 57),
  (11, '2025-02-01', 'Fase de Grupos', 1, 99, 99),
  (12, '2025-02-16', 'Fase de Grupos', 1, 80, 80),
  (13, '2025-02-04', 'Fase de Grupos', 99, 80, 99),
  (14, '2025-02-14', 'Fase de Grupos', 2, 6, 6),
  (15, '2025-02-12', 'Fase de Grupos', 120, 96, 120),
  (16, '2025-02-28', 'Fase de Grupos', 120, 82, 82),
  (17, '2025-02-20', 'Fase de Grupos', 96, 82, 82),
  (18, '2025-02-10', 'Fase de Grupos', 119, 44, 119),
  (19, '2025-02-03', 'Fase de Grupos', 119, 51, 51),
  (20, '2025-02-06', 'Fase de Grupos', 44, 51, 51),
  (21, '2025-02-14', 'Fase de Grupos', 13, 69, 69),
  (22, '2025-02-11', 'Fase de Grupos', 102, 39, 39),
  (23, '2025-02-12', 'Fase de Grupos', 102, 71, 102),
  (24, '2025-02-08', 'Fase de Grupos', 39, 71, 39),
  (25, '2025-03-01', 'Fase de Grupos', 79, 10, 10),
  (26, '2025-02-10', 'Fase de Grupos', 79, 55, 55),
  (27, '2025-02-11', 'Fase de Grupos', 10, 55, 55),
  (28, '2025-02-28', 'Fase de Grupos', 104, 73, 104),
  (29, '2025-02-15', 'Fase de Grupos', 36, 54, 36),
  (30, '2025-02-24', 'Fase de Grupos', 36, 97, 97),
  (31, '2025-02-22', 'Fase de Grupos', 54, 97, 97),
  (32, '2025-02-18', 'Fase de Grupos', 78, 107, 78),
  (33, '2025-02-05', 'Fase de Grupos', 78, 4, 4),
  (34, '2025-02-22', 'Fase de Grupos', 107, 4, 4),
  (35, '2025-02-03', 'Fase de Grupos', 113, 21, 21),
  (36, '2025-02-21', 'Fase de Grupos', 111, 58, 111),
  (37, '2025-02-16', 'Fase de Grupos', 111, 9, 9),
  (38, '2025-02-23', 'Fase de Grupos', 58, 9, 9),
  (39, '2025-02-02', 'Fase de Grupos', 49, 8, 49),
  (40, '2025-02-18', 'Fase de Grupos', 49, 34, 49),
  (41, '2025-02-15', 'Fase de Grupos', 8, 34, 34),
  (42, '2025-02-25', 'Fase de Grupos', 115, 32, 32),
  (43, '2025-02-01', 'Fase de Grupos', 35, 46, 35),
  (44, '2025-02-05', 'Fase de Grupos', 35, 23, 23),
  (45, '2025-02-19', 'Fase de Grupos', 46, 23, 46),
  (46, '2025-02-13', 'Fase de Grupos', 108, 66, 108),
  (47, '2025-02-24', 'Fase de Grupos', 108, 20, 108),
  (48, '2025-02-21', 'Fase de Grupos', 66, 20, 20),
  (49, '2025-02-10', 'Fase de Grupos', 94, 60, 94),
  (50, '2025-02-23', 'Fase de Grupos', 84, 41, 41),
  (51, '2025-02-23', 'Fase de Grupos', 84, 43, 43),
  (52, '2025-02-11', 'Fase de Grupos', 41, 43, 43),
  (53, '2025-02-27', 'Fase de Grupos', 101, 118, 101),
  (54, '2025-02-27', 'Fase de Grupos', 101, 22, 22),
  (55, '2025-02-26', 'Fase de Grupos', 118, 22, 118),
  (56, '2025-03-01', 'Fase de Grupos', 31, 42, 42),
  (57, '2025-02-22', 'Fase de Grupos', 70, 25, 70),
  (58, '2025-02-02', 'Fase de Grupos', 70, 76, 76),
  (59, '2025-02-13', 'Fase de Grupos', 25, 76, 76),
  (60, '2025-02-23', 'Fase de Grupos', 88, 103, 103),
  (61, '2025-02-09', 'Fase de Grupos', 88, 12, 88),
  (62, '2025-03-01', 'Fase de Grupos', 103, 12, 12),
  (63, '2025-02-22', 'Fase de Grupos', 86, 105, 86),
  (64, '2025-02-12', 'Fase de Grupos', 86, 112, 112),
  (65, '2025-02-11', 'Fase de Grupos', 105, 112, 112),
  (66, '2025-02-26', 'Fase de Grupos', 87, 28, 28),
  (67, '2025-02-09', 'Fase de Grupos', 87, 30, 30),
  (68, '2025-02-07', 'Fase de Grupos', 28, 30, 28),
  (69, '2025-02-02', 'Fase de Grupos', 95, 59, 59),
  (70, '2025-02-09', 'Fase de Grupos', 95, 68, 95),
  (71, '2025-02-22', 'Fase de Grupos', 59, 68, 68),
  (72, '2025-02-25', 'Fase de Grupos', 53, 75, 75),
  (73, '2025-02-09', 'Fase de Grupos', 53, 89, 53),
  (74, '2025-02-12', 'Fase de Grupos', 75, 89, 89),
  (75, '2025-02-15', 'Fase de Grupos', 61, 98, 98),
  (76, '2025-02-02', 'Fase de Grupos', 61, 77, 61),
  (77, '2025-02-12', 'Fase de Grupos', 98, 77, 77),
  (78, '2025-02-09', 'Fase de Grupos', 91, 11, 11),
  (79, '2025-03-01', 'Fase de Grupos', 91, 106, 91),
  (80, '2025-03-01', 'Fase de Grupos', 11, 106, 11),
  (81, '2025-02-06', 'Fase de Grupos', 100, 81, 81),
  (82, '2025-02-24', 'Fase de Grupos', 100, 56, 100),
  (83, '2025-02-25', 'Fase de Grupos', 81, 56, 81),
  (84, '2025-02-13', 'Fase de Grupos', 45, 16, 16),
  (85, '2025-02-13', 'Fase de Grupos', 45, 74, 74),
  (86, '2025-02-16', 'Fase de Grupos', 16, 74, 74),
  (87, '2025-02-22', 'Fase de Grupos', 24, 29, 29),
  (88, '2025-02-05', 'Fase de Grupos', 24, 3, 3),
  (89, '2025-02-11', 'Fase de Grupos', 29, 3, 29),
  (90, '2025-02-14', 'Fase de Grupos', 50, 116, 50),
  (91, '2025-02-17', 'Fase de Grupos', 50, 90, 50),
  (92, '2025-02-28', 'Fase de Grupos', 116, 90, 116),
  (93, '2025-02-26', 'Fase de Grupos', 18, 110, 110),
  (94, '2025-02-05', 'Fase de Grupos', 18, 48, 18),
  (95, '2025-02-22', 'Fase de Grupos', 110, 48, 110),
  (96, '2025-02-17', 'Fase de Grupos', 40, 38, 40),
  (97, '2025-03-01', 'Fase de Grupos', 40, 63, 40),
  (98, '2025-03-01', 'Fase de Grupos', 38, 63, 63),
  (99, '2025-02-23', 'Fase de Grupos', 109, 62, 62),
  (100, '2025-02-25', 'Fase de Grupos', 109, 92, 109),
  (101, '2025-02-20', 'Fase de Grupos', 62, 92, 92),
  (102, '2025-03-01', 'Fase de Grupos', 93, 15, 93),
  (103, '2025-02-10', 'Fase de Grupos', 93, 7, 93),
  (104, '2025-02-12', 'Fase de Grupos', 15, 7, 15),
  (105, '2025-03-19', 'Oitavas de Final', 93, 108, 108),
  (106, '2025-03-15', 'Oitavas de Final', 97, 81, 97),
  (107, '2025-03-15', 'Oitavas de Final', 112, 43, 43),
  (108, '2025-03-16', 'Oitavas de Final', 29, 39, 39),
  (109, '2025-03-20', 'Oitavas de Final', 110, 95, 95),
  (110, '2025-03-17', 'Oitavas de Final', 57, 76, 76),
  (111, '2025-03-16', 'Oitavas de Final', 11, 85, 11),
  (112, '2025-03-17', 'Oitavas de Final', 9, 82, 9),
  (113, '2025-04-06', 'Quartas de Final', 108, 97, 108),
  (114, '2025-04-05', 'Quartas de Final', 43, 39, 43),
  (115, '2025-04-08', 'Quartas de Final', 95, 76, 76),
  (116, '2025-04-05', 'Quartas de Final', 11, 9, 9),
  (117, '2025-05-01', 'Semifinal', 108, 43, 43),
  (118, '2025-04-30', 'Semifinal', 76, 9, 76),
  (119, '2025-05-17', 'Terceiro Lugar', 108, 9, 108),
  (120, '2025-05-27', 'Final', 43, 76, 76);

SET FOREIGN_KEY_CHECKS = 1;
