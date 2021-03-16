# Mentoring

### Reasonable solutions

#### Solution using case objects

```scala
object PerfectNumbers {
  import NumberType._

  def classify(number: Int):  Either[String, NumberType] = {
    if (number <= 0)
      Left("Classification is only possible for natural numbers.")
    else {
      val isFactor: Int => Boolean = number % _ == 0

      val candidates = 1 to number/2
      val factors = candidates filter isFactor
      val aliquotSum = factors sum

      if (aliquotSum == number) Right(Perfect)
      else if (aliquotSum > number) Right(Abundant)
      else Right(Deficient)
    }
  }
}

object NumberType {
  sealed trait NumberType

  case object Perfect   extends NumberType
  case object Abundant  extends NumberType
  case object Deficient extends NumberType
}
```

#### Solution using `Enumeration`

```scala
object PerfectNumbers {
  private[perfectnumbers] def factors(n: Int): IndexedSeq[Int] = {
    1 to (n / 2) filter (n % _ == 0)
  }

  def aliquot_sum(n: Int): Int = factors(n) sum

  def classify(n: Int): Either[String, NumberType.Value] =
    if (n > 0)
      Right(aliquot_sum(n) match {
        case sum if sum == n => NumberType.Perfect
        case sum if sum > n  => NumberType.Abundant
        case _  => NumberType.Deficient
      })
    else
      Left("Classification is only possible for natural numbers.")
}

object NumberType extends Enumeration {
  val Deficient, Perfect, Abundant = Value
}
```

### Common suggestions

- Performance - check range only from 1 to n / 2.