# Mentoring

## Reasonable solutions

### Solution using `filter` and `exists` 
```scala
object SumOfMultiples {
  def sum(factors: Set[Int], limit: Int): Int =
    (1 until limit)
      .filter(n => factors.exists(n % _ == 0))
      .sum
}
```

### Solution using `flatMap`
```scala
object SumOfMultiples {
  def sum(factors: Set[Int], limit: Int): Int = 
    factors flatMap(x => x until limit by x) sum
}
```


### Common suggestions

- As an additional challenge, this exercise can be solved without using a local mutable var. If instead of using the for comprehension, filter over the (1 until limit) range, then checking if there exists n that are divisible by one of the factors.
- As an additional challenge, this exercise can be solved without using recursion. If instead of using recursion, 'filter' over the (1 until limit) range, then checking if there 'exists' n that are divisible by one of the factors. 
- Did you know that this solution does not pass all the unit test cases? Note that most of the test cases are marked pending. And, it is up to you to turn the test cases on as you develop your solution.



