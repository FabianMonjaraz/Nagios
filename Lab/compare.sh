#!/bin/bash
[[ $# -ne 3 ]] && echo "Numero de parametros incorrecto" && exit 1
clear
HOST1=$1
HOST2=$2
COMMAND=$3
echo -e "--- \tDiferencias entre $HOST1 y $HOST2 \t---"
echo -e "--- \t$COMMAND \t---"
echo
sdiff -w 200 <(ssh $HOST1 "$COMMAND") <(ssh $HOST2 "$COMMAND")
