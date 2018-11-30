### Reasonable Solutions

A solution with a single loop that uses a lookup table to keep track of letters already seen.

```c
#include "isogram.h"
#include <string.h>
#include <ctype.h>
#include <stdint.h>

bool is_isogram(const char phrase[])
{
  size_t phraseLength = strlen(phrase);
  uint32_t used[26] = { 0 };
  size_t usedIndex;

  for (size_t i = 0; i < phraseLength; i++)
  {
    if (!isalpha(phrase[i]))
      continue;

    usedIndex = tolower(phrase[i]) - 'a';

    if (used[usedIndex])
      return false;

    used[usedIndex] = 1;
  }

  return true;
}
```

### Common Suggestions

- An initial solution will often have a second loop inside the first to check for duplicate letters. A lookup table, of either a 32-bit bitmask or a 26-item array, will let them avoid this second loop.
  - Sometimes the solution will have an array that is not 26 items long. Greek, for instance, uses 24 letters in its alphabet.

- Use standard library functions like tolower() (or toupper()) and isalpha() to avoid re-implementing the same functionality.

- Use character constants like 'A' instead of bare numbers.

- If an array is used for the lookup table, use the array initializer '{0}' instead of a loop for initialization.

### Talking Points

- Sometimes a solution will use a lookup table, but then will have a second loop after the first to go through the table. You can tell if a phrase isn't an isogram as soon as the first duplicate is found in the first loop.
