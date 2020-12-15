### Reasonable Solutions

```bash
#!/usr/bin/env bash

main() {
  if [ $# -eq 0 ]; then
    echo ""
    exit
  fi
  for ((currentNounIndex = 1, nextNounIndex = 2; currentNounIndex < $#; currentNounIndex++, nextNounIndex++)); do
    proverb+=$"For want of a ${!currentNounIndex} the "${!nextNounIndex}" was lost.\n"
  done
  proverb+="And all for the want of a $1."
  echo -e "$proverb"
}

main "$@"
```


### Common suggestions
- use `"$#"` to get number of arguments
This will even handle the whitespace tests, such as:

\```shell
bash proverb.sh "rusty nail" "horse shoe"
\```
output:
\```
$# = 2
$1 = "rusty nail"
$2 = "horse shoe"
\```


### Talking points
- Suggest using [Indirect Parameter Expansion](https://www.gnu.org/software/bash/manual/html_node/Shell-Parameter-Expansion.html)
`"${!index}"` to dynamically access the shell argument. https://www.gnu.org/software/bash/manual/html_node/Shell-Parameter-Expansion.html
```bash
# example
# index = 1
# "${!index}" = $1
```

- Multiple Initialized loop-variables can be added to the loop initializer using a comma.

Note, if the variables are not part of the control flow they should be excluded from the loop initializer.<br/>
In this case, both `currentNounIndex`, and `nextNounIndex` are part of the control flow and each iteration both variables are incremented by 1.
