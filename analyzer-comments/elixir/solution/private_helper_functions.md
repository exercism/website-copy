# private helper functions

[comment]: # (requires 2 params:)
[comment]: # (- expected: the corrected function definition)
[comment]: # (- actual: the incorrect function definition that the student used)

The public interface of a codebase should be carefully considered, as each public function increases long term maintenance costs and makes refactoring harder.

In every Exercism exercise, the public interface is defined by the test suite.
If a function is being tested, it needs to the public.
All other functions should be private, including functions with the same name but different arities.

```elixir
# you defined the following public function

%{actual}

# make it private like this

%{expected}
```
Note that default arguments modify the arity of a function.

When writing a library, it is often necessary to make functions public for use among modules.
To hide such functions from the documentation, library authors add `@doc false` before the function definitions or `@moduledoc false` to hide the whole module.
