# private helper functions

[comment]: # (requires 2 params:)
[comment]: # (- expected: the corrected function definition)
[comment]: # (- actual: the incorrect function definition that the student used)

The public interface of a codebase should be carefully considered. Each public function increases long term maintenance cost because it can be used anywhere in the project. The more times a function is used, the more work it takes to change that function.

In every Exercism exercise, the public interface is defined by the test suite. If a function is being tested, it needs to the public. All other functions should be private.

```elixir
# this is a private function

%{expected}

# this is a public function

%{actual}
```

Note that when writing a library, it is often necessary to make functions public for use among modules. To hide such functions from the documentation and from library users, add `@doc false` before each function definition.
