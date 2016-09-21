#!/bin/bash

ACTION=$1

function start_remote_agent {
	if [ -z "`cat /proc/modules | grep amdtPwrProf`" ]; then
		insmod /opt/codexl/amdtPwrProf.ko
	fi
	export DISPLAY=:0
	/opt/codexl/CodeXLRemoteAgent
}

function stop_remote_agent {
	killall -q CodeXLRemoteAgent-bin
	if [ -n "`cat /proc/modules | grep amdtPwrProf`" ]; then
		rmmod amdtPwrProf
	fi
}

if [ $ACTION = "start" ]; then
	echo "START the remote agent"
	stop_remote_agent
	start_remote_agent
else
	echo "STOP the remote agent"
	stop_remote_agent
fi
