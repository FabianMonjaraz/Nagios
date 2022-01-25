#!/bin/bash
[[ $# -ne 4 ]] && echo "Numero de parametros incorrecto" && echo "$0 -f [INVENTARIO_2_HOSTS] -c '[COMANDO_A_ENVIAR]'" && exit 1
clear
while  getopts 'i:c:' o
do
  case $o in
    i) INVENTORY=$(realpath $OPTARG);;
    c) COMMAND=$OPTARG ;;
  esac  
done  
[[ ! -f $INVENTORY ]] && echo "No existe el archivo de inventario" && exit 1
[[ $(wc -l $INVENTORY | awk '{print $1}') -ne 2 ]] && echo "El archivo del inventario debe tener exactamente dos ips/hostnames" && exit 2
HOST1=$(sed -n 1p $INVENTORY)
HOST2=$(sed -n 2p $INVENTORY)
echo -e "--- \tDiferencias entre $HOST1 y $HOST2 \t---"
echo -e "--- \t$COMMAND \t---"
echo
sdiff -w 200 <(ssh $HOST1 "$COMMAND") <(ssh $HOST2 "$COMMAND")
