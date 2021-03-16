# Mentoring

### Reasonable Solutions

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

### Common Suggestions

See the [two-fer notes](https://raw.githubusercontent.com/exercism/website-copy/main/tracks/bash/exercises/two-fer/mentoring.md) for some common suggestions.

### Talking Points

* numerically indexed arrays
* string concatentation `+=` operator
* arithmetic expressions
    * `((...))` conditional construct
      ([https://www.gnu.org/software/bash/manual/bash.html#Conditional-Constructs](https://www.gnu.org/software/bash/manual/bash.html#Conditional-Constructs))
    * no need to use `$` for variables:

        > Within an expression, shell variables may also be referenced by name without using the parameter expansion syntax.

      [https://www.gnu.org/software/bash/manual/bash.html#Shell-Arithmetic](https://www.gnu.org/software/bash/manual/bash.html#Shell-Arithmetic)
