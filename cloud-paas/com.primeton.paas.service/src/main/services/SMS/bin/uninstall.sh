#!/bin/bash

# author liuyi(mailto:liu-yi@primeton.com)

#
# Uninstall sms service
#

# import paas-env.sh
source $(cd $(dirname ${0})/../..; pwd)/Common/bin/paas-env.sh

# my variables
# Root directory for programs
program_home=${PROGRAME_HOME_PATH}/SMS
bin_home=${BIN_HOME_PATH}/SMS

# Help, print help information to terminal.
function _dohelp() {
    echo "Usage: ./uninstall.sh"
    echo "-h) Print help"
    echo "-reqId) Request id"
}

# Parse execute arguments
function _doparse() {
    while [ -n "$1" ]; do
		case $1 in
		-arg0) arg0=$2;shift 2;;
		*) break;;
		esac
	done
}

# Write your core/main code
function _doexecute() {
	# print variables
	echo "program_home = ${program_home}"
	echo "bin_home = ${bin_home}"
	
	_return "[`date`] Begin uninstall sms."
	
	# remove program
	_return "[`date`] Remove ${program_home}."
	if [ -d ${program_home} ]; then
		rm -rf ${program_home}
	fi
	
	# remove bin
	_return "[`date`] Remove ${bin_home}."
	if [ -d ${bin_home} ]; then
		rm -rf ${bin_home}
	fi
	
	_return "[`date`] End uninstall sms."
	
	_success
	exit 0
}

# import template.sh
source ${BIN_HOME_PATH}/Common/bin/template.sh