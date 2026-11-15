# Pyre em português do Brasil (tradução de fã, não oficial)

Tradução para pt-BR dos textos do jogo **Pyre** (Supergiant Games): diálogos e eventos, Livro dos Ritos, interface, dicas, legendas das cutscenes e da narração dos Ritos.

> **Aviso:** esta tradução **não é oficial** e não tem ligação com a Supergiant Games.
> Foi feita por uma fã **com ajuda de IA (Claude, da Anthropic)**, e não por um tradutor profissional.
> Espere erros, frases estranhas e concordâncias trocadas. Correções são bem-vindas (abra uma *issue*).

## Como instalar

O português **ocupa o lugar do espanhol** no jogo. Depois de instalar, escolha o idioma **"Português - BR"** nas opções.

1. Baixe este repositório (botão **Code → Download ZIP**) e extraia.
2. Na pasta do jogo (no Steam: botão direito em Pyre → Gerenciar → Navegar pelos arquivos locais), copie:
   - `out/1_Keywords.es.xml`, `out/HelpText.es.xml`, `out/Events.es.xml`, `out/Languages.xml` e `out/LaunchText.xml` → `Content/Game/Text/`
   - `out/Subtitles/es/Justice.csv` e `out/Subtitles/es/Match.csv` → `Content/Subtitles/es/`
3. Substitua os arquivos quando o Windows perguntar. Feche e abra o jogo.

Se você usa o Git Bash e o jogo está no lugar padrão do Steam, basta rodar `sh scripts/install.sh`.

**Se o jogo for atualizado** e o português sumir, é só copiar os arquivos de novo.
Para voltar ao espanhol original, use "Verificar integridade dos arquivos" no Steam.

## Limitações conhecidas

- A fonte do jogo não tem a letra **"õ"**: ela aparece trocada por **"o"** (ex.: "aparicoes").
- Ainda há falas com o gênero de personagens trocado; veja `CONTINUAR.md`.

## Para quem quiser mexer na tradução

- `work/<Arquivo>/pt/` tem as traduções (uma linha por texto: `índice|tradução`); `work/<Arquivo>/src/` tem os textos de referência em inglês/espanhol.
- `scripts/` tem as ferramentas (Perl): `check.pl`/`build.pl` para os XML e `subs.pl check|build` para as legendas.
- `GLOSSARIO.md` tem os termos e as regras de marcação; `CONTINUAR.md` tem o estado do trabalho e as pendências.
- Os arquivos originais do jogo (`original/` e `work/Subtitles/orig/`) **não estão no repositório**: para rodar o build, copie-os da sua instalação (`Content/Game/Text/*.en.xml`/`*.es.xml` originais e `Content/Subtitles/en|es/*.csv`).

Pyre © Supergiant Games. Todos os direitos sobre o jogo e seus textos originais pertencem aos seus donos.
