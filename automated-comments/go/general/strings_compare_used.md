`strings.Compare` is an interesting choice to use here. It's [official documentation](https://golang.org/pkg/strings/#Compare) states:

> Compare is included only for symmetry with package bytes.
> It is usually clearer and always faster to use the built-in string comparison operators ==, <, >, and so on.
