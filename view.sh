#!/bin/sh -
printf '[2m'; column -ts'	' "${1:-manifest.tsv}" | sed -e 's/#/[m/g' -e 's/$/[2m/'
