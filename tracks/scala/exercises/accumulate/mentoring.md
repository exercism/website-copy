### Reasonable solutions

#### Solution using immutable collection

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

#### Solution using mutable collection

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

- Appending to a list in Scala is linear in proportion to the collection size. Prepend is constant time. Suggest prepending to build the list in reverse order. Then reverse the resulting list before returning. Alternately ListBuffer could be used.  https://docs.scala-lang.org/overviews/collections/performance-characteristics.html
- The instructions for this exercise forbid the use of map, flatmap and for comprehensions. The exercise is asking that the solution is solved using other tools. One possible solution is tail recursion.
