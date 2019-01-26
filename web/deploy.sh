#!/bin/bash
# Yes, I know this is bad. It uses a custom chunk-based file fingerprinter,
# but it's not ready just yet and has shortcomings that have to be patched
# by this bash script. I'm working on it.
rm -rf build
webdev build
cd build/images && mv * ../ && cd ../

dart ../../../fingerprint/bin/fingerprint.dart

for i in $(find . -type f | egrep '\.(svg|png|jpeg|jpg)$'); do
    mv "$i" ./images/$i
done

cd ../
# firebase deploy