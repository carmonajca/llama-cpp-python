#!/bin/bash

if [ $# -eq 0 ]; then
    echo "Please, provide the main path to the folder where the models (ckpt_dirs) are."
    exit 1
fi
MAIN_DIR="$1"

SCRIPT_DIR=$(dirname "$0")

cd "${SCRIPT_DIR}/vendor/llama.cpp"
echo $(pwd)
if [ ! -f "quantize" ]; then
    make quantize
fi
for dir in $(find $MAIN_DIR/* -type d); do
    echo $dir
    if [ -f "${dir}/ggml-model-f16.bin" ]; then
        rm -f ${dir}/*q4_0.bin.*
        ./quantize ${dir}/ggml-model-f16.bin q4_0 30
    else
        echo "The file 'ggml-model-f16.bin' does not exist in ${dir}"
    fi
done
