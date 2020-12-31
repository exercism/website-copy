### Reasonable Solutions

```bash
#!/usr/bin/env bash
main () {    
  # check to ensure an argument is supplied
  INPUT="${@}"
  if [[ -z "${INPUT}" ]]
  then
    echo "Please supply a string."
    exit 1
  else

    # translate the punctuations into whitespace 
    # Remove the apostrophe and anything but the alphabets
    OUTPUT=$(echo "${INPUT}" | tr -d '\'\' | tr -c '[:alpha:]' ' ')

    # Uppercase compatable with bash < 4.0
    printf "%c" ${OUTPUT} | tr '[:lower:]' '[:upper:]'
  fi
}
main "$@"

#!/usr/bin/env bash
main () {
  [[ -n $1 ]] || exit 1
  declare -ra WORDS=( ${1//[![:alpha:]]/ } )

  for word in "${WORDS[@]}"; do
    output+=${word:0:1}
  done

  # requires bash >= 4.0 to capitalize output
  printf "%s\n" ${output^^}
}
main "$@"

#!/usr/bin/env bash
main () {
  IFS=' !"#$%&()*+,-./:;<=>?@[\]^_`{|}~';
  read -r -a array <<< "$*";
  set acronym;
  for element in "${array[@]}";
  do
      acronym+="${element:0:1}";
  done
  printf "%s\n" $acronym | tr '[:lower:]' '[:upper:]';
  unset acronym;
  unset IFS;
}
main "$@";
```

### Common Suggestions

* Loop is not needed for the solution printf "%c" can be used to print the first characters of each element of an array. (see solution no.1) 

* Loop will work with an array or a string seperated by spaces.  [looping constructs](https://www.gnu.org/software/bash/manual/html_node/Looping-Constructs.html#Looping-Constructs) https://www.gnu.org/software/bash/manual/html_node/Looping-Constructs.html#Looping-Constructs

* An array to use a for loop can be created with read:

```bash
IFS=' !"#$%&()*+,-./:;<=>?@[\]^_`{|}~';
read -r -a array <<< "$*";
```

* A string to use a for loop separated with spaces can be created with parameter substitution [Parameter Substitution](https://tldp.org/LDP/abs/html/parameter-substitution.html)
1) words=${1//[!\'[:alpha:]]/ };
2) words="${1//[^\'a-zA-Z]/ }";

* Suggest using [Parameter Expansion - Substring Extraction](https://www.gnu.org/software/bash/manual/html_node/Shell-Parameter-Expansion.html) to access the first character of each word string. https://www.gnu.org/software/bash/manual/html_node/Shell-Parameter-Expansion.html

### Talking Points

* List Constructs used instead of `if`/`else`

The `&&` and `||` in bash are short-circuit logical operators. They stop evaluating as soon as possible.

`a && b` will only run b if a is true. `a || b` will only run b if a is false. `a || b || c` will stop as soon as anything is true. `a && b || c` will run a and ... b or c or both!! This is why a full blown if-else is often a good idea.

### General Guidelines

* Unquoted variables

Always expand all expansions. Failing to quote an expansion, one string might be split into multiple words by the shell parser. With `a='1 = 2'`, `[ "$a" ]` is true while `[ $a ]` is false.

* No `main` function

```md
It encapsulates a chunk of logic in one function which is good practice for when
things get bigger.
```

* `[` is used

```md
In bash, prefer `[[`/`]]` over `[`/`]`. It's more powerful than `[`/`]` and less likely to act
in unexpected ways.
```

* No shebang

* Remove boilerplate comments are left in
