#!/bin/bash
[[ $# -ne 2 ]] && echo -e "Error: parametros incorrectos\n$0 LOG_NUEVO LOG_OBJETIVO" && exit 1
LOG_NEW=$1 
LOG_TGT=$2
awk '{print $1}' $LOG_NEW | sort -u > pivote
while read IP; do sed -i "/${IP}/d" $LOG_TGT; done < pivote
cat $LOG_NEW >> $LOG_TGT
rm -f pivote
