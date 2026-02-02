#!/bin/bash
set -xv
mvn archetype:generate -DgroupId=fr.patouche.soat -DartifactId=sample-liquibase -DarchetypeArtifactId=maven-archetype-quickstart -DinteractiveMode=false
exit 0
