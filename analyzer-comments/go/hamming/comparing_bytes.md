`byte` comparisons are safe when dealing with ASCII characters. 
As soon as `utf-8` characters are involved, it complicates matters. 
To explore, add an extra test with special characters to see what happens.
