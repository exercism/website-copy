Hello,

I sugget to use a ```while``` loop and a ternary expression (more concise than an if-else) for this exercice.

Example of solution :

```cpp

#include "collatz_conjecture.h"
#include <stdexcept>

namespace collatz_conjecture {

    int steps(int number) {

        if (number <= 0) {
            throw std::domain_error("Only positive numbers are allowed!");
        }

        int steps = 0;

        while (number != 1) {
            number = number % 2 == 0 ? number / 2 : number * 3 + 1;
            ++steps;
        }

        return steps;
    }

}  // namespace collatz_conjecture

```

Good luck !
