You are converting the variable `%{name}` multiple times to a `[]rune`. 
Since this is a comparatively expensive operation it would be better to do the conversion once, save the result
to a variable and reuse that.
