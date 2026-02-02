#!/bin/bash
set -xv
cat /proc/sys/kernel/core_pattern
gdb $JAVA_HOME/bin/java core.11051
jstack -J-d64 $JAVA_HOME/bin/java core.11051
jmap -J-d64 $JAVA_HOME/bin/java core.11051
