#!/bin/sh
# Copia a tradução (out/) para a pasta do Pyre, no lugar do espanhol.
T="/c/Program Files (x86)/Steam/steamapps/common/Pyre/Content/Game/Text"
D="$(cd "$(dirname "$0")/.." && pwd)"
cp "$D/out/1_Keywords.es.xml" "$D/out/HelpText.es.xml" "$D/out/Events.es.xml" "$D/out/Languages.xml" "$D/out/LaunchText.xml" "$T/" && echo "instalado em $T"
# Legendas das cutscenes/narração (Content/Subtitles/es)
S="/c/Program Files (x86)/Steam/steamapps/common/Pyre/Content/Subtitles/es"
cp "$D/out/Subtitles/es/Justice.csv" "$D/out/Subtitles/es/Match.csv" "$S/" && echo "legendas instaladas em $S"
