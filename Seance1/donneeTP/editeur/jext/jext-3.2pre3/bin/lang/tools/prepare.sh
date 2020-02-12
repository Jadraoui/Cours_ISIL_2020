#! /bin/sh
# Set nl(New Language) to the language you are translating to

mkdir new_en
mkdir new_tr
mkdir old_en
mkdir old_tr
mkdir diffs
mkdir check

# \', \<, \>, \; are escape sequences for the char after the \
echo "Place the new English xml's in new_en dir, old ones in old_en dir;
compare.sh will compare them and output difference in the directory
diffs, in a file named diff<Filename>; then you'll apply the same patches
in your translation, to update it. new_tr is the directory for you new
translation, old_tr the dir for the older one."
