# replace magic with identifier

There is a [magic value](https://en.wikipedia.org/wiki/Magic_number_(programming)) `%{literal}` can be replaced by `%{identifier}`.
When possible, named constants are often a better choice than inlined literals because, but not limited to:

- It is easier to read and understand.
  A programmer reading the literal `%{literal}` might wonder: "What does `%{literal}` mean here? Why `%{literal}`?"
  The programmer might infer the meaning after reading the code carefully, but it is not obvious.
  Magic values become particularly confusing when the same value is used for different purposes in one section of code.
- It is easier to alter the value, as it is not duplicated.
- It encourages and facilitates documentation and translation.
- It aids with autocompletion in many IDEs.
