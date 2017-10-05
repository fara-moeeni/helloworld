#!/bin/bash
#export IFS=$'\n'
RED='\033[0;31m'
YELLOW='\033[0;33m'
NC='\033[0m'
for rootdir in `ls -1 | grep -viE "extract2.sh" | xargs -d '\n'`
  do
  cd $rootdir
  countroot=`find . -type d | sed '1d' | wc -l`
    if [ ! $countroot == 0 ]; then
      for dir in `ls -1 | grep -viE "extract2.sh" | xargs -d '\n'`
      do
          cd $dir
          count=`ls | grep -iE ".rar" -c`
          if [ "$count" == 0 ]; then
          echo -e "$RED >>> There are no rar files in `basename $dir`. Trying next folder... >>>"
          echo -e "$NC"
          cd ..
          continue
          else
          type1=`ls | grep -iE "part1.rar|part01.rar" -c`
          if [ "$type1" == 0 ]; then
                  echo -e "$RED >>> Single .rar file found in $dir <<<"
                  echo -e "$NC"
                  ls -1 | xargs unrar x
                  ls -1 *.rar | xargs rm -fv
              cd ..
              else
                  echo ">>> Splitted rar files are found in $dir <<<"
                  type2=`ls | grep -iE "part1.rar" -c`
                  if [ "$type2" == 0 ]; then
                      echo -e "$YELLOW Part0X mode found"
                      echo -e "$NC"
                      ls -1 *.part01* | xargs unrar x
                  else
                      echo -e "$YELLOW PartX mode found"
                      echo -e "$NC"
                      ls -1 *.part1* | xargs unrar x
                  fi
                  find . -iname "*.part*.rar" -exec rm -rfv {} \;
              cd ..
              fi
          fi
      done
    fi
    echo "Going back to another rootdir"
    cd ..
    continue
  done
