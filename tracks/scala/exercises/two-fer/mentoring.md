# Mentoring

## Reasonable solutions

```scala
object Twofer {
  def twofer(name: String = "you"): String =
    s"One for $name, one for me."
}
```

## Common suggestions

- Use default parameters instead of multipe `twofer` functions.
- Instead of using an if-statement, suggest to use a single expression. This will force the student to remove any duplication in the code.
- Suggest using string interpolation over [string contatenation](https://docs.scala-lang.org/overviews/core/string-interpolation.html), scala string formatting or StringBuilder approaches.