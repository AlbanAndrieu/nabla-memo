#!/bin/bash
pkg update -f
pkg install openjdk20
java -version
exit 0
