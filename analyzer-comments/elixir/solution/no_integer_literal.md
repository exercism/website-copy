# no integer literal

Elixir has a [special syntax](https://elixir-lang.org/getting-started/binaries-strings-and-char-lists.html#unicode-and-code-points) to write integers that correspond to [Unicode Code Points](https://en.wikipedia.org/wiki/Code_point): you can use a `?` in front of the character literal to reveal its code point.

For example,

```elixir
?a === 97
?\s === 32
?ß === 223
?互 === 20114
```

In the context of manipulating code points, this notation is much more readable than numbers and should always be preferred.
