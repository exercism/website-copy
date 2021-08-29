# log_sent_email returns implicitly

The function `log_sent_email/1` should not explicitly return `:ok`, but implicitly return what `IO.puts` returns (which happens to be `:ok` when all goes well).

