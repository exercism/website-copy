# Mentoring

## Reasonable solutions

A simple solution using reverse iterators and the string constructor. Note the usage of `std::string_view` as an input parameter.

```cpp
namespace reverse_string {
    std::string reverse_string_iterator(std::string_view str) {
        return std::string(rbegin(str), rend(str));
    }
}
```

The string could also directly be reversed using `std::reverse`. Note that we use `std::string` as an input parameter, causing a copy that we will modify and return.

```cpp
namespace reverse_string {
    std::string reverse_string(std::string str) {
        std::reverse(begin(str), end(str));
        return str;
    }
}
```

## Common suggestions

 - Use `const std::string&` or `std::string_view` instead of `std::string` as a parameter, unless the string is re-used and returned.
 - Use std algorithms when possible instead of implementing algorithms yourself.
 - Avoid for loops that go from some number to 0 → implicit type cast to unsigned number can cause infinite loop. This can often be the case when students use `str.length() - 1`, since it returns an unsigned size type.
 - Use angle brackets (`<>`) to include headers from the standard library. (use `#include <algorithm>` instead of `#include "algorithm"`)
 - Avoid `using namespace` directives in the global namespace of the `.h` file.

## Talking points

 - Do not reinvent the wheel, reuse existing algorithms when possible.
 - Be aware of hidden copies being made by using certain types as function parameters. (`std::string` in this case)
 - Usage of modern c++ features to solve a problem.
 - Make sure you enabled **all** tests.
 - When appending to a vector or string, *reserving* size can be an optimization. (although there's usually even better alternatives)
 - It's good practice to define functions in the `.h` file and implement them in the `.cpp` file. (with exceptions for inline, constexpr or templated functions)
