#!/bin/bash
pushd "`dirname $0`" > /dev/null
cd algo/sub
for f in *.cpp; do
echo "compiling $f"
mkoctfile --mex $f
done
popd > /dev/null
