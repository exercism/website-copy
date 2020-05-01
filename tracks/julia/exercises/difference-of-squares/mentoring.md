### Common suggestions

- Use Gauss's formula:

![](https://wikimedia.org/api/rest_v1/media/math/render/svg/5852a9aaf138078bfb5a60e1e6cad558b57a9c3e)

- Analytical solutions for sum of the first N square numbers: [square pyramidal number](https://en.wikipedia.org/wiki/Square_pyramidal_number)

### Talking points

- You might be interested to know that `sum(1:n)` already uses Gauss' formula. You can see this with `@edit sum(1:n)`
- For integer division, students should use `÷` and not `/` (see [#138](https://github.com/exercism/julia/issues/138))

### Interesting solutions

n111b111's solution:

```julia
"Square the sum of the numbers up to the given number"
square_of_sum(n::Int) = evalpoly(n, (0,0,1,2,1)) ÷ 4

"Sum the squares of the numbers up to the given number"
sum_of_squares(n::Int) = evalpoly(n, (0,1,3,2)) ÷ 6

"Subtract sum of squares from square of sums"
difference(n::Int) = evalpoly(n, (0,-2,-3,2,3)) ÷ 12
```
