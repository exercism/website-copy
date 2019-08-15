There's a great tool called [`golint`](https://github.com/golang/lint) which will examine the code for common problems and style issues.
Try running `golint` on the solution, e.g.: `golint two_fer.go`; it will make some useful suggestions.

It's a good idea to always check ones code with `golint`.
When writing Go software for production, many build pipelines will automatically fail if the code doesn't pass `golint`.

If you are keen on getting much more feedback from code linters there is the [golangci-lint](https://github.com/golangci/golangci-lint) project
allowing you to run a lot of linters with one command.
You can create a config file for your project to adjust the behaviour to your needs.

```
> golint
%{golint}
```
