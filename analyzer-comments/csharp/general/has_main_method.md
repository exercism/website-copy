Try removing the `Main` method from code, as the tests don't require them and they make the code slightly harder to read.

Usually, the `Main` method is added to help debug the code. However, a better approach is to debug the code while running one or more unit tests. This has the added advantage that one can focus on debugging a specific test case. Here are some links that explain how to debug C# code while running unit tests in various IDE's:

- [Visual Studio](https://docs.microsoft.com/en-us/visualstudio/test/run-unit-tests-with-test-explorer?view=vs-2019)
- [VS Code](https://github.com/OmniSharp/omnisharp-vscode/wiki/How-to-run-and-debug-unit-tests)
- [Rider](https://www.jetbrains.com/help/rider/Unit_Testing__Index.html)
