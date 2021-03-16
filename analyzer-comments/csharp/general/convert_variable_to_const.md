# convert variable to const

Consider converting the `%{name}` variable to a `const`, as the value is intended never to change. Usually, `const` values are defined at the class level, as they are frequently used in multiple methods. In this case, the `const` value can be defined within the method itself, which means that other methods cannot use its value.
