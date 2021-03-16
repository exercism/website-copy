# Mentoring

## Reasonable Solutions

```bash
#!/usr/bin/env bash
main () {
  local -i count

  if (( "$#" != 2 )); then
      echo "Usage: hamming.sh <string1> <string2>"
      return 1
  fi
  
  # Regular vars are easier to read when doing fancy parameter expansion.
  a=$1 b=$2 
  
  if (( "${#a}" != "${#b}" )); then
      echo "left and right strands must be of equal length"
      return 1
  fi

  for (( i = 0; i < "${#a}"; i++ )); do
    [[ "${a:i:1}" != "${b:i:1}" ]] && count+=1
  done

  printf '%d\n' "$count"
}

main "$@"
```
```bash
#!/usr/bin/env bash
main () {
    if (( $# != 2 )); then 
        echo "Usage: hamming.sh <string1> <string2>"
        exit 1
    fi

    if (( ${#1} != ${#2} )); then
        echo "left and right strands must be of equal length"
        exit 1
    fi
    hamming=0
    for (( i=0; i<${#1}; i++ )); do
        [[ "${1:$i:1}" != "${2:$i:1}" ]] && (( ++hamming ))
    done
    echo "$hamming"
}

main "$@"
```

## Common Suggestions

* Suggest using a for loop in bash or other [looping constructs](https://www.gnu.org/software/bash/manual/html_node/Looping-Constructs.html#Looping-Constructs) https://www.gnu.org/software/bash/manual/html_node/Looping-Constructs.html#Looping-Constructs

* Suggest using [Parameter Expansion - Substring Extraction](https://www.gnu.org/software/bash/manual/html_node/Shell-Parameter-Expansion.html) to access the index of the string. https://www.gnu.org/software/bash/manual/html_node/Shell-Parameter-Expansion.html

* Suggest creating a counter to gather hammingDistance
1) local -i hammingDistance; "hammingDistance+=1"
2) counter=0; (( ++counter ))
3) counter=0; counter=$(( counter + 1 ))

* Suggest to quote the right-hand side of == in [[ ]] to prevent glob matching, the left hand side can be quoted too.
```bash
@test "expose subtle '[[ \$x == \$y ]]' bug" {
  [[ $BATS_RUN_SKIPPED == "true" ]] || skip
  run bash hamming.sh 'AAA' 'A?A'
  (( status == 0 ))
  [[ $output == "1" ]]
}
```
output:
```
✗ expose subtle '[[ $x == $y ]]' bug
   (in test file hamming_test.sh, line 92)
     `(( status == 0 ))' failed
```
Problem line of code: 
```bash
a=$1
b=$2
[[ ${a:i:1} == ${b:i:1} ]] || count+=1
```
Potential fix:
```bash
a=$1
b=$2
[[ "${a:i:1}" == "${b:i:1}" ]] || count+=1
```

## Talking Points

* List Constructs used instead of `if`/`else`

The `&&` and `||` in bash are short-circuit logical operators. They stop evaluating as soon as possible.

`a && b` will only run b if a is true. `a || b` will only run b if a is false. `a || b || c` will stop as soon as anything is true. `a && b || c` will run a and ... b or c or both!! This is why a full blown if-else is often a good idea.

## General Guidelines

* Unquoted variables

Always expand all expansions. If you fail to quote an expansion, one string might be split into multiple words by the shell parser. With `a='1 = 2'`, `[ "$a" ]` is true while `[ $a ]` is false.

```md
On line <line number> you have an unquoted variable! That can lead to unexpected behavior.
Try this for instance: `$ bash ./two_fer.sh "a -o -n a"`
```

* No `main` function

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

* No shebang

```md
There is no shebang on the top line. This means if you `chmod +x` your
script, you can't control what shell is used to run it! Also, it makes it
harder for another person to see that the script is written for Bash.
```

* Boilerplate comments are left in

```md
It would be nice if you removed the boiler plate comments to make it easier
to read your code.
```
