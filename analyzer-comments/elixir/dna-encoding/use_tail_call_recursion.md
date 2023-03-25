# use tail call recursion

The purpose of this exercise is to teach tail call recursion. Solve it without using recursive functions that are not tail-recursive.

Tail-recursive functions found in your solution: %{tail_call_recursive_functions}. Other recursive functions found in your solution: %{non_tail_call_recursive_functions}.

Remember, tail call recursion is if the _last_ expression evaluated by the function is a call to itself.

```elixir
# this is tail call recursion,
# the last expression is a call to `do_encode`
defp do_encode([n | rest], acc) do
  do_encode(rest, <<acc::bitstring, encode_nucleotide(n)::4>>)
end

# this is not tail call recursion,
# the last expression is a call to `<<>>`
def encode([head | tail]) do
  <<encode_nucleotide(head)::4, encode(tail)::bitstring>>
end
```
