# private helper functions

[comment]: # (requires 2 params:)
[comment]: # (- expected: the corrected function definition)
[comment]: # (- actual: the incorrect function definition that the student used)

The public interface of a codebase should be carefully considered, as each public function should to be maintained in the long term. In this exercise, the public interface has already been provided by the stub file, all other functions should be private.

```elixir
# this is a private function

%{expected}

# this is a public function

%{actual}
```

Note that when writing a library, it is often necessary to make functions public for use among modules. To hide such functions from the documentation and from library users, add `@doc false` before each function definition.
