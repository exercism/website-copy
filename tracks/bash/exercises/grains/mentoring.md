# Grains

*Grains* focuses on validating input and managing control flow, as well as doing
arithmetic (probably exponentiation) in Bash.

## Reasonable Solutions

```bash
#!/usr/bin/env bash

function main() {
  square="$1"

  if [[ "$square" == "total" ]]; then
    echo "2^64 - 1" | bc
  elif (( square < 1 || square > 64 )); then
    echo "Error: invalid input"
    return 1
  else
    echo "2^($square - 1)" | bc
  fi
}

main "$@"
```

## Bonus Pure Bash Solution

If the student completes the exercise with something similar to the solution
above, they can be challenged to complete a bonus solution that is pure Bash
(i.e. built-in functions and language features only).  Here's one implementation
like that:

```bash
#!/usr/bin/env bash

function main() {
  square="$1"

  if [[ "$square" == "total" ]]; then
    printf '%u\n' "$(( 2**64 - 1 ))"
  elif (( square < 1 || square > 64 )); then
    echo "Error: invalid input"
    return 1
  else
    printf '%u\n' "$(( 2**(square - 1) ))"
  fi
}

main "$@"
```

Many students run up against the wall of "the Bash integer limit," but the limit
doesn't seem to be a calculation limit.  It's a printing issue.  `echo` seems
to print signed integers by default.  To sidestep this, we use `printf` to 
print as an unsigned integer.

## Common suggestions
 - Don't forget that the exponentiation symbol differs between pure Bash and
   `bc`.  `bc` uses `^` and Bash uses `**`.
 - Dollar signs aren't needed inside arithmetic substitutions.
 - A lot of students us a `for` or `while` loop to calculate the total.  This is
   slow, *especially* if they are sending out to `bc` to calculate each square.
   This is a good time to suggest coming up with a solution that only performs
   one calculation: either building a gigantic string to send to `bc`, or
   calculating the total using a mathematic relationship (e.g. powers of 2).

## Talking points

If the student doesn't have a strong grasp on math, it seems effective to
tabulate the first several powers of two alongside their values and the
values of the running sum.

```
Power     Value      Sum of all previous values
2**0      1          0
2**1      2          1
2**2      4          3
2**3      8          7
2**4     16         15
2**5     32         31
2**6     64         63
2**7    128        127
```

By this point, the student should start to catch on to the fact that the 
running total is 1 less than the next value.  This should help.
