#!/bin/bash

mknod /dev/amdtPwrProf -m 666 c `cat /proc/amdtPwrProf/device` 0
