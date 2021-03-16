# Mentoring

## Reasonable solutions

### Solution using immutable collection

```scala
import scala.annotation.tailrec

class Accumulate {
  def accumulate[A, B](f: (A) => B, list : List[A]): List[B] = accumulateHelper(f, list, List.empty)

  @tailrec
  private def accumulateHelper[A, B](f: (A) => B, list : List[A], result : List[B]): List[B] =
    list match {
      case Nil => result.reverse
      case x :: xs => accumulateHelper(f, xs, f(x) :: result)
    }
}
```

### Solution using mutable collection

```scala
import scala.annotation.tailrec
import scala.collection.mutable.ListBuffer

class Accumulate {

  def accumulate[A, B](f: A => B, list: List[A]): List[B] = {
    @tailrec
    def loop(rest: List[A], result: ListBuffer[B]): ListBuffer[B] = rest match {
      case Nil => result
      case head :: tail => run(tail, result :+ f(head))
    }

    loop(list, ListBuffer.empty).toList
  }
}
```

### Common suggestions

- Use tail recursion. [Reference: tail recursive algorithms](https://alvinalexander.com/scala/fp-book/tail-recursive-algorithms).
- Do not append to immutable list. Instead prepend to immutable list. Or, use ListBuffer. [Reference: performance characteristics](https://docs.scala-lang.org/overviews/collections/performance-characteristics.html).
- The instructions for this exercise forbid the use of `map`, `flatmap` and `for` comprehensions. 
