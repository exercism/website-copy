# Mentoring

### Reasonable Solutions

A solution with a single loop that uses a lookup table to keep track of letters already seen.

```c
#include "isogram.h"
#include <string.h>
#include <ctype.h>
#include <stdint.h>

bool is_isogram(const char phrase[])
{
  if (phrase == NULL)
    return true;
  
  size_t phraseLength = strlen(phrase);
  bool used[26] = { false };
  size_t usedIndex;

  for (size_t i = 0; i < phraseLength; i++)
  {
    if (!isalpha(phrase[i]))
      continue;

    usedIndex = tolower(phrase[i]) - 'a';

    if (used[usedIndex])
      return false;

    used[usedIndex] = true;
  }

  return true;
}
```

### Common Suggestions

- An initial solution will often have a second loop inside the first to check for duplicate letters. A lookup table, of either a 32-bit bitmask or a 26-item array, will let them avoid this second loop.
  - Sometimes the solution will have an array that is not 26 items long. Greek, for instance, uses 24 letters in its alphabet.

- Some solution will use `strchr` instead of the second loop mentioned in the previous point. This has the additional downside of the need to call `strchr` twice for case-insensitive search.

- Use standard library functions like tolower() (or toupper()) and isalpha() to avoid re-implementing the same functionality.

- Use character constants like 'A' instead of bare numbers.

- If a boolean array is used for the lookup table, use the array initializer '{false}' instead of a loop for initialization.

### Talking Points

- Sometimes a solution will use a lookup table, but then will have a second loop after the first to go through the table. You can tell if a phrase isn't an isogram as soon as the first duplicate is found in the first loop.
