You are declaring `%{returnVar}` before you check if the length is equal, so the declaration may end up being unnecessary. It's better to declare a variable right before you use it.
