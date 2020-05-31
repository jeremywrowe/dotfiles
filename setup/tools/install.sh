#!/usr/bin/env sh

set -e

for dir_path in */;
do
    dir=${dir_path%*/}
    executable="./target/release/${dir}"
    output="../../bin"
    echo "Building ${dir}..."
    cd $dir_path
    cargo build --release > /dev/null 2>&1
    echo "Copying ${executable} to ${output}"
    cp $executable $output
    cd - > /dev/null
done