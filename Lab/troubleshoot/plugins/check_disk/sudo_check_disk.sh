#!/bin/bash
setsebool nagios_run_sudo on
semanage fcontext -a -t nagios_unconfined_plugin_exec_t /usr/lib/nagios/plugins/check_disk
restorecon -v /usr/lib64/nagios/plugins/check_disk
chcon -t nagios_unconfined_plugin_exec_t /usr/lib64/nagios/plugins/check_disk
