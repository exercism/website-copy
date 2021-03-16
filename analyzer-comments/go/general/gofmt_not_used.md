# gofmt not used

Run `gofmt` on the solution, which helps formatting code in Go.

Code formatting in Go is very important to the community.
Most IDEs can be set up to auto-format the code on every save. For example:

- Visual Studio Code has [great Go support](https://code.visualstudio.com/docs/languages/go)
- Vim also has a [fantastic Go extension](https://github.com/fatih/vim-go)
- [Jetbrains Goland](https://www.jetbrains.com/go/) is an entire IDE for Go

To run `gofmt` manually:

```bash
# will only show the differences
gofmt -d filename.go

# will apply the changes
gofmt -w filename.go
```

```git
%{gofmt}
```
