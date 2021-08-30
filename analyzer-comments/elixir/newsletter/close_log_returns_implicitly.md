# close_log returns implicitly

The function `close_log/1` should not explicitly return `:ok`, but implicitly return what `File.close` returns (which happens to be `:ok` when all goes well).

