#!/bin/bash

if [[ -z "$1" ]]; then
  echo "Please provide the lecture's pdf."
  exit 1
fi

lecture=$(readlink -f "$1")

num=$(identify "$lecture" 2>/dev/null | wc -l | tr -d ' ')

read -r -d '' notes << EOM
\documentclass{beamer}
\usepackage[utf8]{inputenc}
\usepackage{amsmath}
\begin{document}
EOM

nosuff=y=${lecture%.pdf}
notespath="${nosuff##*/}_notes.tex"

mkdir -p build
cd build

if [[ -f "$notespath" ]]; then
  echo "File $notespath already exists. Aborting!"
  exit 1 
fi

cp -n "$lecture" "${lecture##*/}"

echo "$notes" > "$notespath"

for i in $(seq 1 $num); do
  read -r -d '' me << EOM
\begin{frame}{Notes of page %1%}

\end{frame}
EOM
  echo "${me//%1%/$i}" >> "$notespath"
done

cat <<EOT >> $notespath
\end{document}
EOT

echo "You can find it $(readlink -e $notespath)."

cd ..
