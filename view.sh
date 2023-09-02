#!/bin/sh -
printf '[2m'; column -ts'	' | sed -e 's/#/[m/g' -e 's/$/[2m/'
