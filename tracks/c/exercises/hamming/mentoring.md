### Reasonable Solutions

A solution with a single loop that counts the differnces:

```c
#include <stddef.h>
#include <string.h>
#include "hamming.h"

int compute(const char *lhs, const char *rhs)
{
   int count = -1;
   if (lhs && rhs && (strlen(lhs) == strlen(rhs))) {
      count = 0;
      int length = (int)strlen(lhs);
      for (int i = 0; i < length; ++i) {
         if (lhs[i] != rhs[i]) {
            ++count;
         }
      }
   }
   return count;
}
```

The `strlen` can be discarded, resulting with less iterations over the loop:

```c
#include "hamming.h"

int compute(const char *lhs, const char *rhs)
{
    if (!lhs || !rhs)
        return -1;
    
    int count = 0;
    for (; *lhs && *rhs; ++lhs, ++rhs)
    {
        if (*lhs != *rhs)
            ++count;
    }

    if (*rhs != '\x0' || *lhs != '\x0')
        return -1;
    
    return count;
}
```
