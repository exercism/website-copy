There's a great tool called [`golint`](https://github.com/golang/lint) which will examine your code for common problems and style issues. Try running `golint` on your code, e.g.: `golint two_fer.go`; it will make some useful suggestions for you.

It's a good idea to always check your code with `golint` (or configure your editor to do it for you). When you're writing Go software for production, many build pipelines will automatically fail if the code doesn't pass `golint` (and `gofmt`). You can avoid this by linting code yourself prior to submitting it.
    
If you are keen on getting much more feedback from code linters there is the [golangci-lint](https://github.com/golangci/golangci-lint) 
project allowing you to run a lot of linters with one command. You can create a config file for you project to adjust the behaviour to your needs.

```
> golint
%{golint}
```
