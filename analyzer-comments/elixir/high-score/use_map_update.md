# use `Map.update/4`

Use [`Map.update`] in `update_score` to
update `scores` in a single call. For the updating function, define an
anonymous function using [`fn`] or the [`&` operator shorthand].

[`Map.update`]: https://hexdocs.pm/elixir/Map.html#update/4
[`Map.put`]: https://hexdocs.pm/elixir/Map.html#get/3
[`Map.get`]: https://hexdocs.pm/elixir/Map.html#put/3
[`fn`]: https://hexdocs.pm/elixir/Kernel.SpecialForms.html#fn/1
[`&` operator shorthand]: https://hexdocs.pm/elixir/Kernel.SpecialForms.html#&/1
