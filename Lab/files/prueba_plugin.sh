#!/bin/bash
IP=$1
LOG=/tmp/salida.tmp
> $LOG
#echo $IP - check_init_service: $(/usr/local/nagios/libexec/check_nrpe -H $IP -t 20 -c check_init_service -a 'crond') |& tee -a $LOG
#echo $IP - check_disk: $(/usr/local/nagios/libexec/check_nrpe -H $IP -t 20 -c check_disk -a '-w 20% -c 10% -H -m') |& tee -a $LOG
#echo $IP - check_yum: $(/usr/local/nagios/libexec/check_nrpe -H $IP -t 20 -c check_yum) |& tee -a $LOG
#echo $IP - check_users: $(/usr/local/nagios/libexec/check_nrpe -H $IP -t 20 -c check_users -a '-w 5 -c 10') |& tee -a $LOG
#echo $IP - check_procs: $(/usr/local/nagios/libexec/check_nrpe -H $IP -t 20 -c check_procs -a '-w 250 -c 400') |& tee -a $LOG
#echo $IP - check_swap: $(/usr/local/nagios/libexec/check_nrpe -H $IP -t 20 -c check_swap -a '-w 50% -c 40%') |& tee -a $LOG
#echo $IP - check_init_service: $(/usr/local/nagios/libexec/check_nrpe -H $IP -t 20 -c check_init_service -a 'sshd') |& tee -a $LOG
#echo $IP - check_open_files: $(/usr/local/nagios/libexec/check_nrpe -H $IP -t 20 -c check_open_files -a '-w 30% -c 50%') |& tee -a $LOG
#echo $IP - check_mem: $(/usr/local/nagios/libexec/check_nrpe -H $IP -t 20 -c check_mem -a '-w 20 -c 10 -n') |& tee -a $LOG
#echo $IP - check_load: $(/usr/local/nagios/libexec/check_nrpe -H $IP -t 20 -c check_load -a '-w 15,10,5 -c 30,20,10') |& tee -a $LOG
#echo $IP - check_cpu: $(/usr/local/nagios/libexec/check_nrpe -H $IP -t 20 -c check_cpu -a '-w 80 -c 90') |& tee -a $LOG
#echo $IP - check_services: $(/usr/local/nagios/libexec/check_nrpe -H $IP -t 20 -c check_services -a '-w 2 -c 1 -p "ssh"') |& tee -a $LOG
#echo $IP - check_log: $(/usr/local/nagios/libexec/check_nrpe -H $IP -t 20 -c check_log -a '-F /var/log/messages -O /tmp/log_nrpe_messages -q "Deprecated" -w 3') |& tee -a $LOG
echo $IP - check_rhel_subscription: $(/usr/local/nagios/libexec/check_nrpe -H $IP -t 20 -c check_rhel_subscription) |& tee -a $LOG
