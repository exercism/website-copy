# Mentoring

### Reasonable Solutions

```bash
#!/usr/bin/env bash

declare -i number="$1"
declare -i power="${#number}"
declare -i total=0

while read -r -n 1 digit; do
  (( total += digit**power ))
done <<< "$number"

if [[ $total -eq $number ]]; then
  echo "true"
else
  echo "false"
fi
```

Another nice solution makes use of a for loop and indexing.

```bash
#!/usr/bin/env bash

declare -i number="$1"
declare -i power="${#number}"
declare -i total=0

for (( i=0; i<power; i++ )); do
  (( total += ${number:i:1}**power ))
done

if [[ $total -eq $number ]]; then
  echo "true"
else
  echo "false"
fi
```

### Common Suggestions

This exercise is the first core exercise where the students need to split a
string into individual characters.  So it's a good opportunity to introduce
string indexing, finding the length of a string, and/or character by character
reading with `while read`.

This link: (https://www.tldp.org/LDP/abs/html/string-manipulation.html) is
often a good one to link to for further reading on indexing and length-finding.

### Talking Points

It's really easy for students to reach for external commands to do these things
(e.g. `grep -o '[[:digit:]]'`).  Some of these are simple and clear, some are
clever, and some are a little sketchy.  The clear/clever ones are probably OK,
with a post-approval nudge in the pure Bash direction.  The hacky ones should
probably find a better way.

After the last exercise (Grains), the student should be able to complete this
exercise without using `bc` command.  Some students will be paranoid about
expecting possible giant numbers and will want to use `bc` just in case
somebody wants to see if a giant number is an Armstrong Number.  If this happens,
it might be good to discuss the pros and cons of coding "future features" that
aren't required by the current tests.



