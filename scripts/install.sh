#!/usr/bin/env bash

# Runs `pub get` on packages and the app
# Usage:
#    * sh ./scripts/install.sh 
#

function run_install {
  flutter pub get

  if [ -d "packages" ]
  then
    cd packages || exit 1
    for d in ./*/ ; do
      echo "╠ ---- Installing packages on $d ----"
      (cd "$d" && run_install);
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
    echo "╠ ---- Installing $current_dir ----"
    echo
    run_install
else
    for d in ./*/ ; do
      echo "╠ ---- Installing packages on $d ----"
      (cd "$d" && run_install);
    done
fi
