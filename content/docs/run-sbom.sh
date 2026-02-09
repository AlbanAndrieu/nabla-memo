#!/bin/bash
set -xv

# https://medium.com/@theowni/a-practical-approach-to-sbom-in-ci-cd-f3ce8071c0fa

mvn org.cyclonedx:cyclonedx-maven-plugin:makeAggregateBom

# install CycloneDX SBOM generation tool for Python
pip3 install cyclonedx-bom

# install dependencies specified in pyproject.toml
pip3 install .

# generate CycloneDX SBOM
# python3 -m cyclonedx_py --format json -e
python3 -m cyclonedx_py poetry --output-format json --outfile sbom.json

# https://github.com/CycloneDX/cyclonedx-cli

# cyclonedx-cli merge --input-files sbom1.xml sbom2.xml --output-format json | grep "something"

exit 0
