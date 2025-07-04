#!/bin/bash

artifacts_dir=$1
outputs_dir=$2

# Get assembly names, for now it's just the names of all the files/dircs in the artifact folder
artifact_names=($(ls "${artifacts_dir}"))

# For each assembly name, using find, get the hardcoded path to the .dll 
artifact_paths=()

for artifact_name in "${artifact_names[@]}"
do
    path=$(find "${artifacts_dir}" -type f -name "${artifact_name}.dll")

    if [[ ! -z ${path} ]]; then
        artifact_paths+=("${path}")
    fi
done


# For each dll, run dotnet test against it.
log_file_path="${outputs_dir}/TestResults.xml"
dotnet test --no-build --configuration Release --logger:"junit;LogFileName=${log_file_path}" "${artifact_paths[@]}"
