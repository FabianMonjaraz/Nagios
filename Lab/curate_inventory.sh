#!/bin/bash

ip_en_log(){
  IPS=$1  
  SALIDA_PLAYBOOK=$2
  SALIDA_BUSQUEDA=$3
  while read IP;
  do
    grep $IP $SALIDA_PLAYBOOK
  done < $IPS | tee -a $SALIDA_BUSQUEDA
}

[[ -z $1 ]] && echo "Inventorio Faltante" && exit 1
echo "======= Filtrando OS por inventario ======="
cp $1 raw_inv
sort -u raw_inv > p1
mv p1 raw_inv 
ansible-playbook -f 10 -i raw_inv supercomando.yml | tee progreso_playbook.out
grep failed= progreso_playbook.out > aux_file
ERRORES=logs/curate_inv_$(date +"%Y-%m-%d_%H%M")
[[ ! -d ./logs ]] && mkdir logs

echo "--------- FALLIDOS -----------" | tee $ERRORES 
grep -E 'failed=[^0]' aux_file | awk '{print $1}' | tee -a $ERRORES aux_ips
echo "--------- SALIDA FALLIDOS -----------" | tee -a $ERRORES 
ip_en_log aux_ips progreso_playbook.out $ERRORES
> aux

echo "--------- INALCANZABLES -----------" | tee -a $ERRORES 
grep -E 'unreachable=[^0]' aux_file | awk '{print $1}' | tee -a $ERRORES aux_ips
echo "--------- SALIDA INALCANZABLES -----------" | tee -a $ERRORES 
ip_en_log aux_ips progreso_playbook.out $ERRORES

grep Linux salida_tmp | awk -F, '{print $1}' >> curated_inventory
sed -i '/unreachable=/d' $ERRORES
mv progreso_playbook.out logs/curate_inv_pp_$(date +"%Y-%m-%d_%H%M")

echo "======= Unificando Inventarios ======="
sort -u curated_inventory > processed_inv
mv processed_inv curated_inventory

echo "======= Eliminando archivos temporales ======="
rm raw_inv salida_tmp aux aux_file

echo "======= Inventario curado ======="
cat curated_inventory
