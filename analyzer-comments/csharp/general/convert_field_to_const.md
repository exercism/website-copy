# convert field to const

Consider converting the `%{name}` field to a `const`, as the value is intended never to change. Using constants is not only more common, there are also some subtle differences between a `const` and a `field`, which are explained in [this StackOverflow post](https://stackoverflow.com/questions/755685/static-readonly-vs-const#755693).
