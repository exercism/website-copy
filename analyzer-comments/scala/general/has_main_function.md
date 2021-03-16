# has main function

Remove the `Main` function, as the tests don't require them and they make the code slightly harder to read.

Usually, the `Main` function is added to help debug the code. However, a better approach is to debug the code while running one or more unit tests. This has the added advantage that one can focus on debugging a specific test case. Here are some links that explain how to debug Scala code while running unit tests in various IDE's:

- [IntelliJ](https://www.jetbrains.com/help/idea/run-debug-and-test-scala.html)
- [Eclipse](http://scala-ide.org/docs/current-user-doc/features/scaladebugger/index.html)
