# use `Map.update/4`

Use [`Map.update`] instead of [`Map.put`] + [`Map.get`] in `update_score` to
update `scores` in a single call. For the updating function, use an
[anonymous function] or the [`&` operator shorthand].

[`Map.update`]: https://hexdocs.pm/elixir/Map.html#update/4
[`Map.put`]: https://hexdocs.pm/elixir/Map.html#get/3
[`Map.get`]: https://hexdocs.pm/elixir/Map.html#put/3
[anonymous function]: https://hexdocs.pm/elixir/Kernel.SpecialForms.html#fn/1
[`&` operator shorthand]: https://hexdocs.pm/elixir/Kernel.SpecialForms.html#&/1
