# Mentoring

## Reasonable Solutions

```bash
#!/usr/bin/env bash

set -o errexit
set -o nounset

main() {
    echo "One for ${1:-you}, one for me."
}

main "$@"
```

## Common Suggestions

* the sentence is repeated for each case

```md
I decided I want two for me every time I give one away. Can you change the
code so that you only need to edit the string ("one for me") once whenever
you want to update it? I suggest looking into parameter expansion with a
default value [here in the manual](https://www.gnu.org/software/bash/manual/html_node/Shell-Parameter-Expansion.html).
```

* `if`/`else` used to check if there is an input value.

```md
There is a more concise way to manage the optional input here. I suggest
looking into parameter expansion with a default value [here in the manual](https://www.gnu.org/software/bash/manual/html_node/Shell-Parameter-Expansion.html).
```

* there are unquoted variables

```md
On LN you have an unquoted variable! That can lead to unexpected behavior.
Try this for instance: `$ bash ./two_fer.sh "a -o -n a"`
```

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

## Talking Points

This is the first exercise where some kind of conditional is needed. If the
student uses `if`/`else` it's an opportunity to talk about the test constructs
`[` and `[[`.

However, it's also a good time to introduce parameter expansion, since the task
can be solved without any `if`/`else` construct at all.
