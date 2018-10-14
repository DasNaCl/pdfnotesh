#!/bin/bash

if [[ -z "$1" ]]; then
  echo "Lecture frames are not set."
  exit 1
fi

if [[ -z "$2" ]]; then
  echo "Note frames are not set."
  exit 1
fi

lecture=$(readlink -f "$1")
notes=$(readlink -f "$2")

lecture2=${lecture##*/}
notes2=${notes##*/}

mkdir -p build
cd build

cp -n "$lecture" "$lecture2"
cp -n "$notes" "$notes2"

num0=$(identify "$lecture" 2>/dev/null | wc -l | tr -d ' ')
num1=$(identify "$notes" 2>/dev/null | wc -l | tr -d ' ')

if [ $num0 -ne $num1 ]; then
  echo "Number of pages should match! ($num0 vs. $num1)"
  echo "You may want to use generate_pages.sh"
  exit 1
fi

read -r -d '' merge << EOM
\documentclass[a4paper]{memoir}
\usepackage{pdfpages,pgffor}
\begin{document}
\foreach\n in{1,...,%1%}{
  \includepdfmerge[nup=1x2]{%2%,\n,%3%,\n}
}
\end{document}
EOM

echo "$num1"

merge2="${merge//%1%/$num0}"
merge3="${merge2//%2%/$lecture2}"
merge4="${merge3//%3%/$notes2}"

echo "$merge4" > merged.tex

pdflatex merged.tex
pdflatex merged.tex

cd ..
