#!/bin/bash
#export IFS=$'\n'
RED='\033[0;31m'
GREEN='\033[0;33m'
for dir in `ls -1 | grep -viE "extract.sh" | xargs -d '\n'`
  do
    cd $dir
    count=`ls | grep -iE ".rar" -c`
    if [ "$count" == 0 ]; then
      echo -e "$RED >>> There are no rar files in `basename $dir`. Trying next folder... >>>"
      cd ..
      continue
    else
       type1=`ls | grep -iE "part1.rar|part01.rar" -c`
	  if [ "$type1" == 0 ]; then
            echo -e "$RED >>> Single .rar file found in $dir <<<"
            ls -1 | xargs unrar x
            ls -1 *.rar | xargs rm -fv
           cd ..
          else
            echo ">>> Splitted rar files are found in $dir <<<"
            type2=`ls | grep -iE "part1.rar" -c`
              if [ "$type2" == 0 ]; then
                echo -e "$GREEN Part0X mode found"
                ls -1 *.part01* | xargs unrar x
              else
                echo -e "$GREEN PartX mode found"
                ls -1 *.part1* | xargs unrar x
              fi
            find . -iname "*.part*.rar" -exec rm -rfv {} \;
           cd ..
          fi
    fi
  done
