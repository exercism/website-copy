# Mentoring

### Reasonable solutions

#### Solution using `flapMap`

```scala
object Etl {
  def transform(old: Map[Int,Seq[String]]): Map[String,Int] =
    old flatMap { case (key, values) => values map (_.toLowerCase -> key) }
}
```

#### Solution using `for` comprehension

```scala
object Etl {
  def transform(scores: Map[Int, Seq[String]]): Map[String, Int] =
    for { (point, letters) <- scores; letter <- letters } yield (letter.toLowerCase, point)
}
```

### Common suggestions

- Mutable local variable is not needed for this exercise.