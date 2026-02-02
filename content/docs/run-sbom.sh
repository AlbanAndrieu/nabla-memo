#!/bin/bash
set -xv
mvn org.cyclonedx:cyclonedx-maven-plugin:makeAggregateBom
pip3 install cyclonedx-bom
pip3 install .
python3 -m cyclonedx_py poetry --output-format json --outfile sbom.json
exit 0
