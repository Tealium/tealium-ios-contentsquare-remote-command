#!/bin/sh

for (( n = 0; n < SCRIPT_INPUT_FILE_COUNT; n++ )); do
    VAR=SCRIPT_INPUT_FILE_$n
    framework=$(basename "${!VAR}")
    export SCRIPT_INPUT_FILE_$n="$SRCROOT"/Carthage/Build/iOS/"$framework"
done

/usr/local/bin/carthage copy-frameworks || exit

for (( n = 0; n < SCRIPT_INPUT_FILE_COUNT; n++ )); do
    VAR=SCRIPT_INPUT_FILE_$n
    source=${!VAR}.dSYM
    dest=${BUILT_PRODUCTS_DIR}/$(basename "$source")
    ditto "$source" "$dest" || exit
done