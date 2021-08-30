# send_newsletter returns implicitly

The function `send_newsletter/3` should not explicitly return `:ok`, but implicitly return what `close_log/1` returns (which happens to be `:ok` when all goes well).

