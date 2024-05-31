#!/bin/bash

# Add expansion to all ValueSet compose definitions.

# for i in *.json; do
java -jar ../../../input-cache/tooling-cli-2.4.0.jar -EnsureExecutableValueSet -valuesetpath=. -outputpath=../input/vocabulary/ValueSet/expanded;
# done

# This dir hierarchy is added with an empty output folder, maybe due to missing Logger?  Remove this folder.
# rm -rf src