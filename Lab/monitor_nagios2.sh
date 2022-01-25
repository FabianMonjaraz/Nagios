#!/bin/bash
INVENTARIO=$1
[[ ! -f $INVENTARIO ]] && echo "Error: no existe el inventario" && exit 1
clear
INVENTARIO_NOMBRE=$(basename $INVENTARIO)
LOG=logs/monitor_qro_${INVENTARIO_NOMBRE}_$(date +"%y%m%d_%H%M%S")
[[ ! -d ./logs ]] && mkdir logs
> $LOG
scp files/comandos.sh server_nagios2:/tmp
while read IP; 
do
  ssh -n server_nagios2 "bash /tmp/comandos.sh $IP"
  scp server_nagios2:/tmp/salida.tmp temp
  cat temp >> $LOG 
done < $INVENTARIO
