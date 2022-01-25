#!/bin/bash
[[ $# -ne 1 ]] && echo Faltan parametros && exit 1
INVENTARIO=$1
PROGRESO=logs/progreso_playbook_$(date +"%d-%m-%y_%H%M").out
[[ ! -f $INVENTARIO ]] && echo "Error: no existe el archivo inventario" && exit 1
clear

cp $INVENTARIO inventario #Se copia en un archivo inventario por si el inventario original se modifica mientras se realiza el script
cp inventario inventarioSeccion
while [[ -s inventarioSeccion ]]; 
do
  head -25 inventarioSeccion > pivote_25
  sed -i '1,25d' inventarioSeccion
  #ansible-playbook -f 10 -i pivote_25 main.yml -t config_plugins 2>&1 | tee -a $PROGRESO
  ansible-playbook -f 10 -i pivote_25 main.yml 2>&1 | tee -a $PROGRESO
done
rm -f pivote_25 inventarioSeccion
