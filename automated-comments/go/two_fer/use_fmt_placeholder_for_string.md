Tip: any type of value in Go can be printed using the format character `%v`. However, there's also a different format for each type (for example `%s` for strings). The type specific formats also offer more options for formatting that type. For example the format `%f`, for `float` values, can also specify the precision: `%.2f`.

Additionally, if you use the type specific placeholders and you refactor your code you will get notified 
if you changed the type of the variable but not the type of the placeholder. This can e.g. help 
to avoid breaking a string based api without noticing it.
