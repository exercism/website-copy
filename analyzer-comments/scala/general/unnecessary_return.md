# unnecessary return

Scala best practices indicate that the `return` keyword should be avoided. In Scala, the result of the last expression in a function is implicitly returned. Specifying `return` explicitly at the end of a function can have unintended side effects. [Say No To Return](https://blog.knoldus.com/scala-best-practices-say-no-to-return/).
