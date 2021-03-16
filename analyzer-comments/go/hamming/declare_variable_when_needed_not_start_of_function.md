# declare variable when needed not start of function

Variable `%{returnVar}` is defined earlier than necessary.
It's common when writing Go to declare variables as late as possible before they are used. 
This tends to reduce mental overhead when reading the code, and sometimes also leads to simpler code, 
since the code might return before the variable is needed.
