#!/bin/bash

MAIN_DIR="/mnt/data/LLM_models/llama-cpp/"

cd $(pwd)"/vendor/llama.cpp"
echo $(pwd)
make quantize
for dir in $(find $MAIN_DIR/* -type d); do
    echo $dir
    if [ -f "${dir}/ggml-model-f16.bin" ]; then
        rm -f ${dir}/*q4_0.bin
        ./quantize ${dir}/ggml-model-f16.bin q4_0 30
    else
        echo "The file 'ggml-model-f16.bin' does not exist in ${dir}"
    fi
done
