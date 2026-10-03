#!/usr/bin/env bash

set -euo pipefail

if [ "$#" -ne 2 ]; then
    echo "Uso: $0 arquivo.csv numero_da_coluna" >&2
    exit 1
fi

arquivo="$1"
coluna="$2"

nome_coluna=$(awk -F',' -v c="$coluna" 'NR==1 {print $c}' "$arquivo")

echo "Coluna: $nome_coluna"

observacoes=$(awk 'END {print NR-1}' "$arquivo")
echo "Observações: $observacoes"

nas=$(awk -F',' -v c="$coluna" 'NR > 1 && $c == "NA" {n++} END {print n}' "$arquivo")
echo "NA: $nas"

echo "Média por mês:"

awk -F',' -v c="$coluna" '
NR > 1 && $c != "NA" {
    soma[$5] += $c
    n[$5]++
}
END {
    for (mes in soma) {
        printf "Mês %s: média = %.2f (%d dias medidos)\n", mes, soma[mes]/n[mes], n[mes]
    }
}' "$arquivo"