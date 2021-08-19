# welcome ends with IO puts

The function `welcome/0` should not explicitly return `:ok`, but implicitly return what `IO.puts` returns (which happens to be `:ok`).
