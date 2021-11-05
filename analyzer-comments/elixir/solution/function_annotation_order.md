# doc spec order

[comment]: # (requires 2 params:)
[comment]: # (- expected: How the doc and spec order should be)
[comment]: # (- actual: The incorrect order that the student used)


There is not a correct order between the `@doc` and `@spec` modules attributes. But the elixir community convention is to use `@doc` first and `@spec` next to the function  

```elixir
# recommended order
%{expected}

# your order
%{actual}
```