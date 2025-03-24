#!/bin/bash

CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
MEM_USAGE=$(free | grep Mem | awk '{print $3/$2 * 100.0}')
DISK_USAGE=$(df -h / | grep / | awk '{ print $5}' | sed 's/%//g')

echo "current CPU usage: $CPU_USAGE" ;
echo "current MEM usage: $MEM_USAGE" ;
echo "current DSC usage: $DISK_USAGE"
