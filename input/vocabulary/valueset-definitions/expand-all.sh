#!/bin/bash

# Add expansion to all ValueSet compose definitions.

# for i in *.json; do
java -jar ../../../input-cache/tooling-cli-2.4.0.jar -EnsureExecutableValueSet -valuesetpath=. -outputpath=../ValueSet/expanded;
# done
