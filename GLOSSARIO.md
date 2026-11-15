# Glossário e regras — tradução pt-BR do Pyre

## Como funciona
- O português ocupa o **slot do espanhol** (`*.es.xml`). Base da tradução: espanhol original; inglês como referência de sentido.
- `perl scripts/extract.pl <Arquivo>` → lotes em `work/<Arquivo>/src/chunk_NNN.txt`
- Tradução em `work/<Arquivo>/pt/chunk_NNN.txt`, uma linha por texto: `índice<TAB>texto`
- `perl scripts/check.pl <Arquivo>` → confere códigos `{...}`, `\n`, aspas/`<`/`&`
- `perl scripts/build.pl <Arquivo>` → `out/<Arquivo>.es.xml` (o que não foi traduzido sai em inglês)

## Regras de marcação (não negociáveis)
- Todo `{...}` do espanhol tem que aparecer igual na tradução (mesma quantidade): `{$...}`, `{#...}`, `{!...}`, `{@...}`, `{^...}`, `{+...}`, `{%...}`, botões `{BL}`, `{IF ...}`, `{END}`.
- `[texto]{$Var}` = mostra "texto" no lugar do valor, mas mantém a palavra interativa. Usar para concordância: `[sóis]{$Keywords.Gold}`, `[da Comunidade]`... (preferir colocar só a palavra dentro: `da [Comunidade]{$Keywords.Commonwealth}` não é necessário — o valor já é "Comunidade").
- Gênero do Leitor: `{IF $Coach.Gender Char_Gender_Male} Leitor {IF $Coach.Gender Char_Gender_Female} Leitora {END}` (mesma estrutura do espanhol).
- `\n` literal, `&lt;` `&gt;` `&amp;` `&quot;` mantidos como estão. Nunca usar `"` cru — usar aspas tipográficas “ ” ou &quot;.

## Pronomes (HelpText: Char_Pronoun*)
- Sub: ele / ela — Obj: ele / ela (usado após preposição: "com ele") — Pos: **dele / dela** (vai DEPOIS do substantivo: "o plano {$X.PronounPos}")
- Se o espanhol tem `{$X.PronounPos}` antes do substantivo ("su plan"), reestruturar para "o plano {$X.PronounPos}" ou usar `[seu]{$X.PronounPos}`/`[sua]{$X.PronounPos}` quando o personagem tem gênero fixo.

## Tratamento
- Jogador = **você**; o grupo = **vocês** (espanhol usa vosotros → vocês).
- Tom do Livro dos Ritos / narração: formal, levemente arcaico ("há de", "deverá"), sem exagero.
- Interface: imperativo com "você": "Interaja", "Pressione {BL}".

## Termos
| Inglês | Espanhol | Português |
|---|---|---|
| Commonwealth | Mancomunidad | Comunidade (a) |
| Downside | Bajorreverso | Submundo (o) |
| Eight Scribes / Scribes | Ocho Escribas / Escribas | Oito Escribas / Escribas |
| Sol (moeda) | Sol / soles | Sol / sóis |
| Plan | Plan | Plano |
| Reader | Lector/Lectora | Leitor/Leitora |
| Blackwagon | Carromato negro | Carroça Negra (a) |
| Rite / Rites | Rito / Ritos | Rito / Ritos |
| Liberation Rite | Rito de Liberación | Rito de Libertação |
| Book of Rites | Libro de los Ritos | Livro dos Ritos |
| exile | exiliado | exilado |
| Orb | Orbe | Orbe (o) |
| Aura | Aura | Aura |
| Pyre | Pira | Pira |
| banish / banishment | expulsar / expulsión | banir / banimento |
| Banishment Sickness | Mal de expulsión | Mal do Banimento |
| Shimmer-Pool | Lacus aurora | Lago Cintilante |
| Highwing Remnants / Harps | Vestigios Alados / Arpías | Remanescentes Alados / Harpias |
| Sea-Dominion | Dominio del Mar | Domínio do Mar |
| wyrm | gusano | serpe |
| Sisters of the Arch | Hermanas del Arco | Irmãs do Arco |
| Slugmarket | Babomercado | Lesmercado (o) |
| imp / drive-imps | diablillo / diablillos impulsores | diabrete / diabretes propulsores |
| Talisman | Talismán | Talismã |
| Presence / Glory / Hope / Quickness | Presencia / Gloria / Esperanza / Rapidez | Presença / Glória / Esperança / Rapidez |
| Titan Star(s) | Estrella(s) del/de los Titán(es) | Estrela(s) dos Titãs |
| Vocations / Vocation Time | Vocaciones / Tiempo de vocación | Vocações / Tempo de Vocação |
| Forage / Study / Mentor | Buscar recursos / Estudiar / Tutelar | Coletar Recursos / Estudar / Orientar |
| Old Ways | Artes Antiguas | Artes Antigas |
| Archjustice | Archimagistrado | Arquijuiz |
| Justices of Peace | Magistrados de la Paz | Magistrados da Paz |
| Southern Bogs / bog-crone | Ciénagas del Sur / bruja de las ciénagas | Pântanos do Sul / bruxa do pântano |
| Bloodborder | Frontera de Sangre | Fronteira de Sangue |
| First Veil | Primer Velo | Primeiro Véu |
| Spiral Sanctum | Santuario en Espiral | Santuário Espiral |
| Centrifuge | Centrifugadora | Centrífuga |
| Downriver | Ríoabajo | Rio Abaixo |
| Empire | Imperio | Império |
| howlers | aulladores | uivadores |
| Sandalwood | Sándalo | Sândalo |
| Yslach | Yslach | Yslach |
| Trait | Rasgo | Traço |
| Tenacity / Righteousness / Spirit / Celerity | Tenacidad / Honorabilidad / Espíritu / Celeridad | Tenacidade / Retidão / Espírito / Celeridade |
| A.S. (ano) | d. E. | A.S. |

## Times
Nightwings = Asas Noturnas (os) · Accusers = Acusadores · Fate = Destino · Dissidents = Dissidentes · Withdrawn = Retraídos · Pyrehearts = Corações Incendiários · Essence = Essência · Chastity = Castidade · Tempers = Temperamentais · Beyonders = Transgressores · True Nightwings = Verdadeiros Asas Noturnas

## Regiões
Downside Prairie = Pradaria do Submundo · Jomuer Valley = Vale de Jomuer · Flagging Hands = Mãos Desfalecidas · Wyrm Gulf = Golfo da Serpe · Sea of Solis = Mar de Solis · Deathless Tempest = Tempestade Imortal · Black Basin = Bacia Negra · Sclorian Shore = Costa Scloriana · Mount Alodiel = Monte Alodiel

## Nomes próprios
Manter como no inglês (Hedwyn, Jodariel, Rukey, Ti'zo, Pamitha, Bertrude, Volfred, Sandalwood→Sândalo como sobrenome? manter "Sandalwood" se for nome).
Onomatopeias dos diabretes: usar a grafia do INGLÊS (o espanhol trocou H por J).

## Gênero dos locais (IMPORTANTE)
O jogo decide "no/na", "ao/à" pelo gênero do nome do local numa tabela fixa do script (espanhol), copiada em `work/generos_locais_es.txt`.
Ao traduzir nomes de locais (Swath_*, Player_Hometown), escolher um nome em português com o MESMO gênero do espanhol.
Ex.: Cerro de Gol (m) → Morro de Gol (m), nunca "Colina de Gol".
