#!/bin/bash
#echo "first parameter is language, second is file"
#awk -f comparison.awk ../../src/lib/org/jext/`echo $i|cut -d/ -f2` $i
plugPath=../../src/plugins

doCompareProps() {
  local baseName=$1
  local engPath=$2
  local translPath=$3
  local language=$4
  #This always finds listProps.sed, even when we are in the plugins folder.
  sed -f ../../bin/lang/tools/listProps.sed $engPath|grep -v '^[\t [:cntrl:]]*$'|sort >check/$baseName.props.English
  sed -f ../../bin/lang/tools/listProps.sed $translPath|grep -v '^[\t [:cntrl:]]*$'|sort >check/$baseName.props.$language
  #now do the same for $i and compare the 2 lists! so everything is fine.
  #sed now removes the headings and the @@ lines, so it shows a pretty output.
  diff check/$baseName.props.$language check/$baseName.props.English -U0|\
  sed -e "1s/^---.*$//"     -e "2s/^+++.*$//"       -e "s/^@@.*@@$//" \
  -e "s/^+/Added property: /"           -e "s/^-/Removed property: /" \
  |grep -v '^[\t ]*$'>diffs/propdiff.$baseName.$language
  #[ -s diffs/propdiff.$basename.$language ] || echo diffs/propdiff.$baseName.$language
  #the above line was to remove empty files; but it doesn't work because files still
  #doesn't exist(pipes are run in parallel).
}

diffMainTransl() {	#This is intended for jext's main files, not for plugins;
  #for them we need a different calling function, but doCompare remains the same.
  #Every parameter is the name of a translated file.
  local origsPath=../../src/lib/org/jext/
  for i in $@; do
    [ -f $i ] || continue
    #local baseName=`echo $i|cut -d/ -f2`
    #local language=`echo $i|cut -d/ -f1`
    local baseName=`basename $i`
    local language=$(basename `dirname $i`)
    [ -f $origsPath/$baseName ] || continue
    case $baseName in
      *.props.xml) doCompareProps $baseName $origsPath/$baseName $i $language;;
    esac
  done
}

diffPlugTransl() {
  #Here every parameter is instead the name of the original file.
  local translPath=../../bin/lang
  for i in $@; do
    [ -f $i ] || continue
    local baseName=`basename $i`
    for language in $langs
    do
      [ -f $translPath/$language/$baseName ] || continue
      doCompareProps $baseName $i $translPath/$language/$baseName $language
    done
  done
}

clean() {
  for i in diffs/*
  do
    [ -s $i ] || rm -f $i
  done
}

mkdir -p diffs check
for i in * #`find  -type d ! -name tools -maxdepth 1 ! -name .`
do
  if [ -d $i ]; then
    case $i in
      tools|diffs|check|new_tr|new_en|old_en|old_tr|CVS) ;;
      *) diffMainTransl $i/*
      langs="$langs $i"
      ;;
    esac
  fi
done
clean

cd $plugPath
mkdir -p diffs check
for i in *
do
  if [ -d $i ]; then
    case $i in
      CVS|diffs|check) ;;
      *) diffPlugTransl $i/*.props.xml
    esac
  fi
done
clean
