#!/bin/bash
#set -xv

# See https://docs.incredibuild.com/win/latest/windows/system_requirements.html

ADD PROXY in Windows

set https_proxy=http://10.21.185.171:3128/
set http_proxy=http://10.21.185.171:3128/

https://www.incredibuild.com/downloads/windows/weekly/Incredibuild9_59.exe

"C:\Program Files (x86)\IncrediBuild\Samples\Dev Tools Acceleration\DevTools Interfaces Usage Samples\Interception Interface"
run_XGE.bat

#incredibuild license server address: licensing.incredibuild.com

80,443,31104-31130

XgConsole /command="MainProcess.exe DummySubProcess.exe 100 100 100" /profile="profile.xml" /openmonitor /title="Automatic Interception Sample"

buildconsole /COMMAND="scons"

Main controller is 10.21.224.254

exit 0
