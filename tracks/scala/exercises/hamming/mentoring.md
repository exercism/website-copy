# Mentoring

## Reasonable solutions

### Solution using zip and count

```scala
object Hamming {
   def distance(strand1: String, strand2: String): Option[Int] =
      if (strand1.length != strand2.length) None
      else Some(strand1.zip(strand2).count(p => p._1 != p._2))
}
```

### Solution using range and count

```scala
package object Hamming {
  def compute(a: String, b: String): Int =
    if (left.length != right.length) None
    else Some((0 until a.length).count(i => a(i) != b(i)))
}
```

### Common suggestions

- Recursion is not needed for this exercise.
- Mutable local variable is not needed for this exercise.