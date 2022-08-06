#!/usr/bin/env bash

# Runs `pub clean` on packages and the app
# Usage:
#    * sh ./scripts/clean.sh 
#

function run_clean {
  flutter clean

  if [ -d "packages" ]
  then
    cd packages || exit 1
    for d in ./*/ ; do
      echo "╠ ---- Cleaning packages on $d ----"
      (cd "$d" && run_clean);
    done
    cd ..
  fi
}


# if the given folder is a dart project, then run tests on the given package and sub-packages
# otherwiser iterate all folders and try to run tests on those packages and their sub-packages
if [ -f "pubspec.yaml" ]
then
    current_dir=$(basename "$PWD")
    echo
    echo "╠ ---- Cleaning $current_dir ----"
    echo
    run_clean
else
    for d in ./*/ ; do
      echo "╠ ---- Cleaning packages on $d ----"
      (cd "$d" && run_clean);
    done
fi
