### Common suggestions

- Use Gauss's formula:

![](https://wikimedia.org/api/rest_v1/media/math/render/svg/5852a9aaf138078bfb5a60e1e6cad558b57a9c3e)

- Analytical solutions for sum of the first N square numbers: [square pyramidal number](https://en.wikipedia.org/wiki/Square_pyramidal_number)

- `sum_of_squares = sum((1:n) .^ 2)`. This is correct, but it allocates an array (at least in Julia 1.4), can you see how to do this without allocation?

### Talking points

- You might be interested to know that \`sum(1:n)\` already uses Gauss' formula. You can see this with \`@edit sum(1:n)\`
- For integer division, students should use `÷` and not `/` (see [#138](https://github.com/exercism/julia/issues/138))


### Example solutions

Naive:

````
```julia
square_of_sum(n) = sum(1:n)^2

# 0:n because otherwise the case where n = 0 would be reducing over an empty collection.
sum_of_squares(n) = sum(x -> x^2, 0:n)

difference(n) = square_of_sum(n) - sum_of_squares(n)
```
````

Using square pyramidal number formula:

````
```julia
"Square the sum of the first `n` positive integers"
square_of_sum(n) = sum(1:n)^2

"Sum the squares of the first `n` positive integers"
sum_of_squares(n) = n * (n + 1) * (2n + 1) ÷ 6

"Subtract the sum of squares from square of the sum of the first `n` positive ints"
difference(n) = square_of_sum(n) - sum_of_squares(n)
```
````

You may see some solutions where the `difference` has been partially expanded analytically, too.


#### Interesting solutions:

n111b111's solution:

````
Using `evalpoly` makes this more efficient than most hand-written analytic solutions because `evalpoly` generates efficient code using Horner's method.

```julia
"Square the sum of the numbers up to the given number"
square_of_sum(n::Int) = evalpoly(n, (0,0,1,2,1)) ÷ 4

"Sum the squares of the numbers up to the given number"
sum_of_squares(n::Int) = evalpoly(n, (0,1,3,2)) ÷ 6

"Subtract sum of squares from square of sums"
difference(n::Int) = evalpoly(n, (0,-2,-3,2,3)) ÷ 12
```
````
