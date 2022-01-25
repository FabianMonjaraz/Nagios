#!/bin/bash
INVENTARIO=$1
[[ ! -f $INVENTARIO ]] && echo "Error: no existe el inventario" && exit 1
clear
INVENTARIO_NOMBRE=$(basename $INVENTARIO)
LOG=logs/monitor_mty_${INVENTARIO_NOMBRE}_$(date +"%y%m%d_%H%M%S")
[[ ! -d ./logs ]] && mkdir logs
> $LOG
scp files/comandos.sh server_nagios1:/tmp
while read IP; 
do
  ssh -n server_nagios1 "bash /tmp/comandos.sh $IP"
  scp server_nagios1:/tmp/salida.tmp temp
  cat temp >> $LOG 
  echo "---------------------" >> $LOG  
done < $INVENTARIO
