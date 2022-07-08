# Mentoring

## Reasonable Solutions

Short and sweet
```bash
(($1%3==0)) && output+=Pling
(($1%5==0)) && output+=Plang
(($1%7==0)) && output+=Plong
echo ${output:-$1}
```

Using an array
```bash
output=""
sounds=([3]=Pling [5]=Plang [7]=Plong)
# extracting the list of indices for an indexed array
# returns the indices numerically sorted.
# https://stackoverflow.com/q/57185987/7552
for i in "${!sounds[@]}"; do
    (( $1 % i == 0 )) && output+=${sounds[i]}
done
echo "${output:-$1}"
```

## Common Suggestions

See the [two-fer notes](https://raw.githubusercontent.com/exercism/website-copy/main/tracks/bash/exercises/two-fer/mentoring.md) for some common suggestions.

## Talking Points

* numerically indexed arrays
* string concatentation `+=` operator
* arithmetic expressions
    * `((...))` conditional construct
      ([https://www.gnu.org/software/bash/manual/bash.html#Conditional-Constructs](https://www.gnu.org/software/bash/manual/bash.html#Conditional-Constructs))
    * no need to use `$` for variables:

        > Within an expression, shell variables may also be referenced by name without using the parameter expansion syntax.

      [https://www.gnu.org/software/bash/manual/bash.html#Shell-Arithmetic](https://www.gnu.org/software/bash/manual/bash.html#Shell-Arithmetic)


# Bash Guidance


## Preflight checks

Check if the interpreter directive, aka hash-bash `#!` is present.
[Increased portability](http://mywiki.wooledge.org/BashGuide/CommandsAndArguments#Scripts) is achieved by not hard-coding this path, but looked up using `env`.
Contrast:

```
#! /bin/bash
#! /usr/bin/env bash
```


## Interactive prompt self-help

Query if there is an awareness of classic documentation that is typically available:

```
$ man  bash
$ info bash
```

A leaner alternative, [`tldr` (https://github.com/tldr-pages/tldr/)](https://github.com/tldr-pages/tldr/), reduces documentation down to common usage examples:

```
$ tldr bash

bash

Bourne-Again SHell, an `sh`-compatible command-line interpreter.
More information: <https://gnu.org/software/bash/>.

- Start an interactive shell session:
    bash

- Execute a command and then exit:
    bash -c "command"

...

```


## Static analysis & linting

[ShellCheck (https://shellcheck.net/)](https://shellcheck.net/) by Vidar Holen is a tool that detects common issues
Other less problematic recommendations can also be requested:

```
$ shellcheck <file>
$ shellcheck --enable=all <file>
```


## Debug

Consider Aaron Maxwell's [Bash Strict Mode (http://redsymbol.net/articles/unofficial-bash-strict-mode/)](http://redsymbol.net/articles/unofficial-bash-strict-mode/) to help reduce an invisible issue down to a minimal working example:

```
set -Eeuo pipefail
IFS=$'\n\t'
```


## Resources

A special mention must be made of Michael Mol's chrestomathy site, [Rosetta Code (https://rosettacode.org/wiki/Category:Bash)](https://rosettacode.org/wiki/Category:Bash). Comparing solutions with other known or even unknown languages can be rather instructive.

|                                  | Address
---------------------------------- | ---------------------
Manual                             | https://www.gnu.org/software/bash/manual/
Frequently Asked Questions         | http://mywiki.wooledge.org/BashFAQ
Reference Card                     | https://devhints.io/bash
Pure Bash Bible                    | https://github.com/dylanaraps/pure-bash-bible
Essential Bash                     | https://www.programming-books.io/essential/
Bash Notes for Professionals + PDF | https://www.programming-books.io/essential/bash/ https://books.goalkicker.com/BashBook/BashNotesForProfessionals.pdf
