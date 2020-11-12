### Reasonable Solutions

```bash
#!/usr/bin/env bash
main () {
  (( "$#" == 2 )) || {
      echo "Usage: hamming.sh <string1> <string2>"
      exit 1
  }
  
  # Regular vars are easier to read when doing fancy parameter expansion.
  a=$1 b=$2 
  
  (( "${#a}" == "${#b}" )) || {
      echo "left and right strands must be of equal length"
      exit 1
  }

  declare -i count
  for (( i = 0; i < "${#a}"; i++ )); do
    [[ "${a:i:1}" == "${b:i:1}" ]] || count+=1
  done

  printf '%d' "$count"
}

main "$@"
```
```bash
#!/usr/bin/env bash
main () {
  (( $# != 2 )) && 
    echo "Usage: hamming.sh <string1> <string2>" && 
    exit 1
  (( ${#1} != ${#2} )) && 
    echo "left and right strands must be of equal length" && 
    exit 1

  hamming=0;
  for (( i = 0; i < ${#1}; i++ )); do
    [[ "${1:i:1}" != "${2:i:1}" ]] && (( ++hamming ))
  done

  echo "$hamming"
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
    if (( ${#1} != ${#2} ))
    then
        echo "left and right strands must be of equal length"
        exit 1
    fi
    hamming=0
    for (( i=0; i<${#1}; i++ )); do
        [[ "${1:$i:1}" != "${2:$i:1}" ]] && let "hamming+=1"
    done
    echo "$hamming"
}

main "$@"
```


### Common Suggestions

* Suggest using a for loop in bash or other [looping constructs](https://www.gnu.org/software/bash/manual/html_node/Looping-Constructs.html#Looping-Constructs) https://www.gnu.org/software/bash/manual/html_node/Looping-Constructs.html#Looping-Constructs

* Suggest using [Parameter Expansion - Substring Extraction](https://www.gnu.org/software/bash/manual/html_node/Shell-Parameter-Expansion.html) to access the index of the string. https://www.gnu.org/software/bash/manual/html_node/Shell-Parameter-Expansion.html

* Suggest creating a counter to gather hammingDistance
1) let "hammingDistance+=1"
2) counter=0; (( ++counter ));
3) counter=0; counter=(( $counter+1 ));

* Suggest Quote the right-hand side of == in [[ ]] to prevent glob matching, the left hand side can be quoted too.
```
run bash hamming.sh 'AAA' 'A?A'

✗ expose subtle '[[ $x == $y ]]' bug
   (in test file hamming_test.sh, line 92)
     `(( status == 0 ))' failed
```

Problem line of code: 
```bash
[[ ${a:i:1} == ${b:i:1} ]] || count+=1
```
Potential fix:
```bash
[[ "${a:i:1}" == "${b:i:1}" ]] || count+=1
```


### Talking Points

* `if`/`else` used instead of List Constructs.

Because conditionals are needed. If the
student uses `if`/`else` it's an opportunity to talk about the list constructs for a more concise answer. `&&`/`||` The and list and or list constructs provide a means of processing a number of commands consecutively. These can effectively replace complex nested if/then or even case statements. [List Constructs](https://tldp.org/LDP/abs/html/list-cons.html#LISTCONSREF)

### General Guidelines


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