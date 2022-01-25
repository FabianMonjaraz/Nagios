#!/usr/bin/env python
import subprocess
import sys
import re
import argparse
def run(*popenargs, **kwargs):
    input = kwargs.pop("input", None)
    check = kwargs.pop("handle", False)

    if input is not None:
        if 'stdin' in kwargs:
            raise ValueError('stdin and input arguments may not both be used.')
        kwargs['stdin'] = subprocess.PIPE

    process = subprocess.Popen(*popenargs, **kwargs)
    try:
        stdout, stderr = process.communicate(input)
    except:
        process.kill()
        process.wait()
        raise
    retcode = process.poll()
    if check and retcode:
        raise subprocess.CalledProcessError(
            retcode, process.args, output=stdout, stderr=stderr)
    return retcode, stdout, stderr


#OS_TYPE = subprocess.run(["uname"],capture_output=True).stdout.decode().strip()
RET_COD,OS_TYPE,COMM_ERR = run(["uname"])

if OS_TYPE != "Linux" and OS_TYPE != "AIX":
    print("Script enfocado a equipos Linux (Con posibilidades para AIX); OS encontrado: {}".format(OS_TYPE))
    exit(1)

DESCRIPTION = """
Script para validar la salida 
de ciertos comandos
"""
print(DESCRIPTION)
HOST = "127.0.0.1"
if len(sys.argv) == 2:
    HOST = sys.argv[1]

PATH_CHECK_NRPE = "/usr/local/nagios/libexec/check_nrpe"
DICT_NRPE = {
        "check_init_service": "crond",
        "check_disk": "-w 20% -c 10% -H -m -l",
        "check_yum": "",
        "check_users": "-w 5 -c 10",
        "check_procs": "-w 250 -c 400", 
        "check_swap": "-w 50% -c 40%", 
        "check_init_service": "sshd", 
        "check_open_files": "-w 30% -c 50%", 
        "check_mem": "-w 85 -c 90", 
        "check_load": "-w 15,10,5 -c 30,20,10", 
        "check_services": "-w 2 -c 1 -p 'ssh'", 
        "check_log": "-F /var/log/messages -O /tmp/log_nrpe_messages -q 'Deprecated' -w 3", 
        "check_rhel_subscription": "",
        "check_eth": "-t 3"
        }
DICT_COMMANDS = {}
for COMMAND_NAME,COMMAND in DICT_NRPE.items():
        DICT_COMMANDS[COMMAND_NAME] = [PATH_CHECK_NRPE, "-H", HOST, "-t", "20", "-c", COMMAND_NAME, "-a", COMMAND]

#for KEY,VAL in DICT_COMMANDS.items():
#    OUTPUT=subprocess.run(VAL,capture_output=True).stdout.decode().strip()
#    if re.search(r"\n",OUTPUT) != None:
#        OUTPUT = "\n"+OUTPUT
#    print("{}, {}, {}".format(HOST,KEY,OUTPUT))
#    #print("{}, {}".format(HOST,OUTPUT))


for KEY,VAL in DICT_COMMANDS.items():
    
    print("{:<24s} -> {}".format(KEY,VAL))
