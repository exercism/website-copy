## Common Suggestions

* use brace expansion

```md
On LN, consider a more concise way to provide a sequence of letters.
[Brace Expansion](https://www.gnu.org/software/bash/manual/html_node/Brace-Expansion.html)
in the Bash Reference Manual might be useful.
```

## General Guidelines

* there is no `main` function

```md
Generally, you should encapsulate the main body of your script in a `main`
function, like you may remember from the Hello World exercise.  It
encapsulates a chunk of logic in one function which is good practice for when
things get bigger.
```

* `[` is used

```md
In bash, prefer `[[`/`]]` over `[`/`]`. It's more powerful than `[`/`]` and less likely to act
in unexpected ways.
```

* there is no shebang

```md
There is no  shebang on the top line. This means if you `chmod +x` your
script, you can't control what shell is used to run it! Also, it makes it
harder for another person to see that the script is written for Bash.
```

* boilerplate comments are left in

```md
It would be nice if you removed the boiler plate comments, to make it easier
to read your code.
```
