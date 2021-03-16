# Mentoring

### Reasonable solutions

#### Simple Solution
```scala
object Bob {
  def response(statement: String): String = {
    statement.trim match {
      case s if s.isEmpty => "Fine. Be that way!"
      case s if isQuestion(s) && isYell(s) =>
        "Calm down, I know what I'm doing!"
      case s if isQuestion(s) => "Sure."
      case s if isYell(s) =>
        "Whoa, chill out!"
      case _ => "Whatever."
    }
  }
  
  private def isQuestion(statement: String): Boolean = {
    statement.last == '?'
  }

  private def isYell(statement: String): Boolean = {
    statement.exists(_.isUpper) && !statement.exists(_.isLower)
  }
}
```

#### Solution using Extractors

```scala
object Bob {
  def response(statement: String): String = statement match {
    case ShoutingQuestion() => "Calm down, I know what I'm doing!"
    case Shouting() => "Whoa, chill out!"
    case Question() => "Sure."
    case Silence() => "Fine. Be that way!"
    case _ => "Whatever."
  }

  case object ShoutingQuestion {
    def unapply(statement: String) =
      hasLetter(statement) && isOnlyUppercase(statement) &&
        statement.trim.endsWith("?")

    private def hasLetter(s: String) = s.matches(".*[A-Z].*")

    private def isOnlyUppercase(s: String) = s == s.toUpperCase
  }

  case object Shouting {
    def unapply(statement: String) =
      hasLetter(statement) && isOnlyUppercase(statement)

    private def hasLetter(s: String) = s.matches(".*[A-Z].*")

    private def isOnlyUppercase(s: String) = s == s.toUpperCase
  }

  case object Question {
    def unapply(statement: String) = statement.trim.endsWith("?")
  }

  case object Silence {
    def unapply(statement: String) = statement.trim.isEmpty
  }
}
```


### Common suggestions

- Tests for the different cases should be broken into well named functions - `isShouting`, `isShoutingQuestion`, etc.
- The exercise can be solved without use of complex regular expressions.

