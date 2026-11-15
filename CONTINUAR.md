# Tradução pt-BR do Pyre — como continuar

## PENDENTE: ajustes apontados jogando (2026-11-15)
- **Fonte do jogo não tem "õ"**: aparecia "*" (apariç*es, provis*es). Os scripts de build (`build.pl` e `subs.pl build`) trocam õ→o e Õ→O só na saída (`out/`); os textos em `work/*/pt` continuam com a grafia certa. Se aparecer outro caractere como "*", acrescentar na função `fonte_jogo` em `scripts/common.pm`.
- **Sandra, a Cega**: o nome completo é montado pelo jogo como Nome + `Nomad_LinkWord_Female` ("a") + `Nomad_Title_07`. O título estava "Cego" (HelpText, índice 747). Só a Sandra (Rivals_Captain17, feminino) usa o título 07, então ele ficou "Cega". Os outros títulos: 01 Desertor (Hedwyn), 02 Tocada pela Lua (Rukey/Psycho, feminino), 03 Mentiroso (Accuser), 04 Indefeso (FateSon).
- **Hedwyn é homem**: a usuária viu uma fala que se refere a ele no feminino. Ainda não localizada: as buscas por {$CharFriend...} e "Hedwyn" com formas femininas não acharam nada óbvio. Pedir o trecho exato (ou uma foto) para achar o texto.
- **Revisão geral de gênero dos personagens**: conferir falas com nomes fixos e variáveis ({$CharX.ShortName}) contra o gênero de cada um (Lua: `Gender = "Char_Gender_..."` em LeagueGenerationScripts.lua).

## CONCLUÍDO (2026-11-15): legendas das cutscenes (Subtitles)
- As falas narradas da Voz (cutscenes e narração dos Ritos) NÃO estão no Events: ficam em `Content/Subtitles/es/Justice.csv` e `Match.csv`. Por isso a cutscene após o 1º manuscrito aparecia em espanhol.
- Originais (es e en) copiados para `work/Subtitles/orig/`. Script: `scripts/subs.pl extract|check|build` (extract já feito: 53 lotes em `work/Subtitles/src/`). Formato do PT: `ID|tradução` (ex.: `Justice_219|...`), em `work/Subtitles/pt/chunk_NNN.txt`.
- **Todos os 53 lotes feitos (2102/2102)**, check sem problemas, build e instalação feitos. O `install.sh` agora também copia `out/Subtitles/es/*.csv` para `Content/Subtitles/es/`.
- Corrigido no subs.pl: IDs com sufixo de letra (Justice_15a, Match_18a etc.) eram ignorados pela leitura do PT; agora entram.
- Exilados de uma sílaba (Kae, Fae, Dae…, Match_735–825) têm gênero indefinido: frases neutras ("Kae desapareceu", "Pobre Kae").
- Para reinstalar: `perl scripts/subs.pl build` e `sh scripts/install.sh`. Fechar e reabrir o jogo.
- LaunchText.xml (tela inicial: "Pressione qualquer tecla", aviso de salvamento, copyright): seção `lang="es"` traduzida à mão em `out/LaunchText.xml` (original em `original/`); o install.sh copia.
- Varredura de 2026-11-15: não há mais texto do jogo em espanhol. Restam só os 12 placeholders de teste do Events (de propósito). Datas usam o formato do ES ("dia, N de mês"), que serve para o PT.
- Convenções das legendas: a Voz usa "vós" (Contemplai, sabeis, vosso); manter os blocos {IF $Coach.Gender ...} exatamente como no ES (se precisar variar mais palavras, colocar dentro dos ramos do IF, não duplicar o IF). ES às vezes erra/inverte: seguir o EN (ex.: Justice_566/568, 221–229).
- Nomes já fixados: Otherworld = Outro Mundo; Downside = Submundo; Commonwealth = Comunidade; times: Asas Noturnas, Acusadores, o Destino, Dissidentes, Retraídos, Corações Incendiários, a Essência, a Castidade, Temperamentais, Transgressores, Verdadeiros Asas Noturnas, a Ruptura. Lugares: Morro de Gol, Manancial de Jomuer, Túmulo de Ha'ub, Abismo de Milithe, Casco de Ores, Ninho de Triesta, Prado de Lu, Cascata de Soliam, Ilha de Khaylmer, Monte Alodiel. Pessoas: Khaylmer Chama-Cordas, Volfred Sândalo, Rukey Cauda-Verde, Mae (a Tocada pela Lua), Dalbert/Almer Coração-Antigo, Barker Patas-de-Cinza, Manley Tinderstauf, Sandra, a Cega; Shax Seis Ombros, Príncipe Assobiador, Legião Arruinada. Titãs: Dolnis, o Medalhão; Endriga, a Viúva; O Manto Esfarrapado; Xilvias Cabeça-de-Cavalo; Arizech, o Sem-Membros; Plurnes, a Insondável; Harn, o Cantor do Tempo; Yslach, o Nascido dos Astros. Escribas (para Match_717–734): Jomuer Muitas-Jubas, Ha'ub, a Andorinha, Viajante dos Mares, Sub-Rei Ores, Lu Sclorian Cem-Mentes, Bruxa Selvagem, Chefe Alfa, Santa Triesta. Rite of Ascension = Rito de Libertação. "banished" = banido.

## Estado (2026-11-14)
- 1_Keywords: 100%, reconstruído e instalado (inclui as alterações #947/#949).
- HelpText: 100%, instalado.
- Events: **246/246 lotes feitos**, check.pl sem problemas, XML validado e instalado. As 12 entradas não traduzidas (#822–830, #1640–1643) são textos de teste/placeholders e ficam no original de propósito.
- Próximo passo sugerido: revisão jogando (concordância de gênero de nomes de lugar {$PlayerTeam.TeamNextMatchVenue}/{$currentNodeData.Location}, tom das falas).
- Termos fixados nos lotes finais: Sapling = Muda (f); Curly-Horns = Chifrinhos; sallow-caps = chapéus-pálidos; Glopgill = Guelra-Gosmenta; Firecaps = Chapéus-de-Fogo; slurgh/caranguejos de sarjeta/mingau de lodo como no HelpText; Diva fala "tu" com todos (plural majestático feminino); a Beyonder usa "vós".
- A aparição {$RivalBeyonder} (líder dos Transgressores) é MULHER. Revolution = "Retorno dos Escribas" (sem artigo) e Riot = "Levante de X": usar "a noite do {$Keywords.Revolution}". O 1_Keywords foi alterado depois de instalado (#947/#949): rodar build+install do 1_Keywords também no fim.
- Escribas: Harpia, Nômade, Lenho (Sap), Serpe (Wyrm), Diabrete (Imp), Demônio, Canino (Cur), Bruxa (Crone). "Rito de Libertação". Carroça Negra. ES "Prueba de los Escribas" = "Provação dos Escribas".
- Orações aos Escribas, a aparição (Beyonder) e falas arcaicas ("thou/ye") usam "vós"; companheiros entre si e com a Leitora usam "você".
- Estilo: a Voz e falas cerimoniais (que no ES usam "vosotros" formal, ex. "Dad un paso adelante") usam "vós" arcaico ("Dai um passo à frente, apresentai-vos").

## Para continuar numa sessão nova do Claude
Abra uma sessão nesta pasta (Downloads\traducao-pyre) e cole:

> Continue a tradução pt-BR do Pyre. Leia CONTINUAR.md e GLOSSARIO.md. Falta o Events: traduza os lotes de work/Events/src/ para work/Events/pt/ (mesmo nome de arquivo), rodando `perl scripts/check.pl Events` a cada lote; ao terminar, `perl scripts/build.pl Events`, valide o XML e instale com `sh scripts/install.sh`.

## Regras essenciais (detalhes no GLOSSARIO.md)
- O português ocupa o slot do **espanhol** (`*.es.xml`); a base é o texto ES, o EN é só referência.
- Formato de saída: uma linha por texto, `índice|tradução`. Pular textos que são só nomes ou tokens.
- Os tokens `{...}` e `\n` precisam ser **idênticos e na mesma ordem** que no ES (o check.pl acusa).
  Isso inclui `{IF $X.Gender Char_Gender_Male} .. {IF $X.Gender Char_Gender_Female} .. {END}` e
  `{IF $Lugar_Gender m} o {IF $Lugar_Gender f} a {END}` (gênero dos lugares segue o espanhol).
- Sem `"`, `<`, `&` soltos nem tabulação. `&amp;` só onde o ES tiver.
- A usuária joga como **Leitora** (feminino): cuidar das formas femininas.
- Tratamento: jogador = "você"; grupo = "vocês"; Livro dos Ritos = "vós".
- Não editar arquivos com `perl -i`/`sed` contendo acentos na linha de comando (corrompe UTF-8).

## Instalação
`sh scripts/install.sh` copia `out/*.es.xml` e `out/Languages.xml` para a pasta Text do jogo
(Steam\steamapps\common\Pyre\Content\Game\Text). No jogo, escolher o idioma "Português - BR".
Se o jogo for atualizado, basta rodar o install.sh de novo (ou copiar os arquivos de `out/` à mão).
