# Mentoring

## Reasonable solutions

This is a very simple (but not optimal) solution using a for-loop:

```cpp
namespace reverse_string {
  std::string reverse_string(std::string_view input){
    std::string output{};
    for(char c : input){
      output = c + output;
    }
    return output;
  }
}
```

A better approach could use existing std algorithms to get the same result:

```cpp
namespace reverse_string {
  std::string reverse_string(std::string_view str) {
    std::string output{};
    std::copy(input.crbegin(), input.crend(),
              std::back_insert_iterator<std::string>(output));
    return output;
  }
}
```

## Common suggestions
 - Use `const std::string&` or `std::string_view` instead of `std::string` as a parameter.
 - Use std algorithms when possible instead of implementing algorithms yourself.
 - Avoid for loops that go from some number to 0 → implicit type cast to unsigned number can cause infinite loop.

## Talking points
 - Do not reinvent the weel, reuse existing algorithms when possible.
 - Be aware of hidden copies being made:
   - By using certain types as function parameters (`std::string` in this case).
   - By adding a char in front of the output string by doing `c + output`.
 - Usage of modern c++ features to solve a problem.
 - Make sure you enabled **all** tests.
