Remove the explicit existence check `.includes`. When the color (input string)
is converted to a code (`colorCode` number), there is already a special value 
which is returned if the color is not present. Look for and use that value 
instead.