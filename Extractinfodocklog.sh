#!/bin/bash
for FILE in *.log
do
	grep -H '0.000' $FILE >> ../draft.csv
done
