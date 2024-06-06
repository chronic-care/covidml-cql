#!/bin/bash

# Convet all spreadsheets to FHIR ValueSet resources.

for i in *.xlsx; do
java -jar ../../../input-cache/tooling-cli-2.4.0.jar -VsacXlsxToValueSet -baseurl=http://emiadvisors.net/fhir/ValueSet/ -pathtospreadsheet=$i -outputpath=../ValueSet/expanded;
done

# This dir hierarchy is added with an empty output folder, maybe due to missing Logger?  Remove this folder.
rm -rf src