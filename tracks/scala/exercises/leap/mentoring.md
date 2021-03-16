# Mentoring

### Reasonable solutions

#### With helper function
```scala
object Leap {
  def leapYear(year: Int): Boolean = {
    val isYearDivisibleBy: (Int) => Boolean = year % _  == 0

    (isYearDivisibleBy(4) && !isYearDivisibleBy(100)) ||  isYearDivisibleBy(400)
  }
}
```

#### Without helper function
```scala
object Leap {
  def leapYear(year: Int): Boolean = {
    (year % 4 == 0 && !(year % 100 ==0)) || year % 400 == 0
  }
}
```


### Common suggestions

- `true` and `false` do not need to be returned explicitly. Instead return the result of combining expressions with `&&`, `||` and `!`

