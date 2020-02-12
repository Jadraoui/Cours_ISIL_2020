#! /bin/sh
# Compares old and new Jext xmls
# In the en dir there should be the new English XML's

cd new_en
for i in *.xml
do
  diff -U2 -b $i ../old_en/$i > ../diffs/diff$i
done
cd ..
