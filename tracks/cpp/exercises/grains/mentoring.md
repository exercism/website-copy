# Mentoring

## First function

The first way to implement this function is to use a for loop :
```cpp
unsigned long long square(int indice) {
    unsigned long long result = 1;
    for (int i = 0; i < indice; i++) result *= 2;
    return result;
}
```
A cleaner way to do this is to use a recursive function :
```cpp
unsigned long long square(int indice) {
    if (indice == 1) return 1;
    else return square(indice - 1) * 2;
}
```
This way, the code is shorter and in my mind, easier to read.

## Second function
At first sight, we want to use the first function to do it easily :
```cpp
unsigned long long total() {
    unsigned long long sum = 0;
    for (int i = 1; i <= 64; i++) sum += square(i);
    return sum;
}
```
However with this solution, each time you call the function square with the indice i, you do i products.
In the following solution, you only do 64 products and by adding to the sum each time you multiply by 2 :
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
