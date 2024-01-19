# do not use main method

Try removing the `main` method from your code.
Exercise tests don't require solutions to have a `main` method and having one makes the code slightly harder to read.

Usually, a `main` method is added to help debug the code.
However, a better approach is to debug the code while running one or more unit tests.
This has the added advantage that one can focus on debugging a specific test case.

Here are some links that explain how to debug Java code while running unit tests in various IDEs:

- [Running and debugging Java tests in Visual Studio Code](https://code.visualstudio.com/docs/java/java-testing#_rundebug-test-cases)
- [Debugging tests in IntelliJ IDEA](https://www.jetbrains.com/help/idea/performing-tests.html#RedebugFailedTests)
