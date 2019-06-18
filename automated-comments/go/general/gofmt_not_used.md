Code formatting in Go is very important to the community. Take a look at `gofmt` and run it on your code. Your editor or IDE should be able to do this for you automatically:

- Visual Studio Code has [great Go support](https://code.visualstudio.com/docs/languages/go)

- Vim also has a [fantastic Go extension](https://github.com/fatih/vim-go)

- [Jetbrains Goland](https://www.jetbrains.com/go/) is an entire IDE for Go
    
If you want to get to know `gofmt` you can run it manually:
    
```bash
# will only show the differences
gofmt -d filename.go

# will apply the changes
gofmt -w filename.go
```

```git
%{gofmt}
```
