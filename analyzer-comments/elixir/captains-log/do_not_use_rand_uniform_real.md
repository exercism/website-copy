# Use `rand.uniform` instead of `rand.uniform_real`

Use `:rand.uniform` instead of `:rand.uniform_real` in the `random_stardate` function. Those two functions differ slightly in that `:rand.uniform` returns a value equal or greater than 0 and lower than 1, but `:rand.uniform_real` always returns a value greater than 0 and lower than 1. The instructions for `random_stardate` call for a value between 41000.0 (inclusive) and 42000.0 (exclusive), and this cannot be achieved with `:rand.uniform_real`.
