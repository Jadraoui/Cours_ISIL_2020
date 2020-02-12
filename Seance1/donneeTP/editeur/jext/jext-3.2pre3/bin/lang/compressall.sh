#!/bin/sh

#for i in `find  -type d ! -name tools -maxdepth 1 ! -name .`
#do
for i in *; do
  if [ -d $i ]; then
    case $i in
      tools|diffs|check|new_tr|new_en|old_en|old_tr|CVS) ;;
      *)
	cd $i
	# "Jarring" files
	#We say *.xml because there are no folders now.
	jar cvMf ${i}_pack.jar *.xml
	mv --force ${i}_pack.jar ..
	cd ..
      ;;
    esac
  fi
done
