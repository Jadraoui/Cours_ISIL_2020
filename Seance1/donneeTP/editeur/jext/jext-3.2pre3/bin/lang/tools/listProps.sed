#s/^.*<property name="\(.*\)" value=".*[^\]\?"[\t ]*\/>/\1/

s/^[^<]\+$// 
#The above line deletes all rows which don't start a tag(and so have values that 
#start in other lines)
s/<[x\/!?].*// 
s/^.*<property name="\(.*\)" value=".*/\1/
#s/^[]$//
