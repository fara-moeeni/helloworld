#!/bin/bash

for dir in `ls -1 | grep -viE ".sh" | xargs`
  do
    cd $dir
    count=`ls | grep -iE ".rar" -c`
    if [ "$count" == 0 ]; then
      echo ">>> There are no rar files in `basename $dir`. Trying next folder... <<<"
      cd ..
      continue
    else
       type1=`ls | grep -iE "part1.rar" -c`
	  if [ "$type1" == 0 ]; then
            echo ">>> Single .rar file found in $dir <<<"
            ls -1 | xargs unrar x
            ls -1 *.rar | xargs rm -fv
           cd ..
          else
            echo ">>> Splitted rar files are found in $dir <<<"
            ls -1 *.part1* | xargs unrar x
            find . -iname "*.part*.rar" -exec rm -rfv {} \;
           cd ..
          fi
    fi
  done
