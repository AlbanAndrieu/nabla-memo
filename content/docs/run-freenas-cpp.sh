#!/bin/bash
set -xv
pkg install python27
pkg install py27-pip
pkg install python
pkg install scons
pkg install cmake
cd /usr/ports/devel/doxygen/&&  make install clean
pkg install doxygen
cd /usr/ports&&  make search name=clang
cd /usr/ports/devel/llvm90&&  make install clean
pkg install llvm80 llvm90
pkg install gcc
pkg install git
pkg install cppcheck rats java-findbugs flawfinder gperf
pkg install hs-ShellCheck
pkg install gnuplot
pkg install p5-LaTeXML
pkg install lzlib libxml2
pkg install boost-all boost-libs
exit 0
