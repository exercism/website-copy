### Reasonable solutions

```scala
object Twofer {
  def twofer(name: String = "you"): String =
    s"One for $name, one for me."
}
```

### Common suggestions

- Use default parameters instead of multipe `twofer` functions.