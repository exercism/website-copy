# Mentoring

## Reasonable solutions

### First function

The first way to implement this function is to use a for loop:
```cpp
unsigned long long square(int index) {
    unsigned long long result = 1;
    for (int i = 0; i < index; i++) result *= 2;
    return result;
}
```
Another good way to do this is to use a recursive function:
```cpp
unsigned long long square(int index) {
    if (index == 1) return 1;
    else return square(index - 1) * 2;
}
```
This way, the code is shorter and in my mind, easier to read.

The last option and the more direct one is:
```cpp
unsigned long long square(int index)
{
    return 1ULL << (index - 1);
}
```
This code use left bitshifting. Left bitshifting consists in adding 0 at the end of the binary writing of the number.

If you do `5 << 2`, you are taking 5, which is 101 in binary, and you shift the bits by 2, so you end up with 10100 and that equal to 20.

### Second function
At first sight, we want to use the first function to do it easily:
```cpp
unsigned long long total() {
    unsigned long long sum = 0;
    for (int i = 1; i <= 64; i++) sum += square(i);
    return sum;
}
```
However with this solution only works with a direct implementation of the first function, else each time you call the function square with the index i, you do i products.
In the following solution, you only do 64 products and by adding to the sum each time you multiply by 2:
```cpp
unsigned long long total() {
    unsigned long long total = 0;
    unsigned long long square = 1;
    
    for (int k = 0; k < 64; k++) {
        total += square;
        square *= 2;
    }

    return total;
}
```
Moreover, this is also possible to use a direct implementation for this function:
```cpp
unsigned long long total() {
    return ~0ULL;
}
```
With this way we use the fact that a ULL is 64 bits long and we use the ~ to do the complement.

## Common issues

- Not using unsigned long long types
- Using ULLONG_MAX, for the second function, which works, however this is like returning directly the good number
- Using std::pow that implies conversion from float to int and could lead to errors mainly in the total function
- Hard coding the solution for the total

## Common suggestions

- Use the square function in total only if square use a direct implementation
- The optimal way is to use bitwise operations


