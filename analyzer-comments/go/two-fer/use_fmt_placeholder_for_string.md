# use fmt placeholder for string

In Go, people tend to prefer type-specific placeholders rather than the generic `%%v`. 
There are two reasons for this. First, more specific placeholders often have additional options, 
for example the format `%%f` for `float` values can also specify the precision: `%%.2f`. 
The second reason is that `%%v` accepts any value type. If a variable type changes during a refactoring, 
`%%v` will print the default for that type, which might not be the desired behavior. 
A type-specific placeholder will cause the linter to complain, catching the error before it gets deployed to production.
