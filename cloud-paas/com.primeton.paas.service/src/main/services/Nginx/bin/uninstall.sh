#!/bin/bash

#
# ----------------------------------------------------------------
# Copyright (c) 2009 - 2015 Primeton. All Rights Reserved.
# ----------------------------------------------------------------
#
# author ZhongWen.Li (mailto:lizw@primeton.com)
#

#
# Uninstall nginx service
#

# import paas-env.sh
source $(cd $(dirname ${0})/../..; pwd)/Common/bin/paas-env.sh

# my variables

# Root directory for programs
program_home=${PROGRAME_HOME_PATH}/Nginx
bin_home=${BIN_HOME_PATH}/Nginx

# Help, print help information to terminal.
function _dohelp() {
    echo "Useage: ./install.sh"
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
	echo "package_home = ${package_home}"
	echo "bin_home = ${bin_home}"
	
	_return "[`date`] Begin uninstall nginx."
	
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
	
	# remove zlib-devel # TODO
	# rpm -e zlib-devel
	
	_return "[`date`] End uninstall nginx."
	
	_success
	exit 0	
}

# import template.sh
source ${BIN_HOME_PATH}/Common/bin/template.sh