In Go, it's conventional to use multiple returns, returning as soon as possible from a function.
Typically edge cases and error cases are handled as early as possible, leaving the happy path aligned to the left edge.
For a nice explanation of this practice, 
see [Align the happy path to the left edge](https://medium.com/@matryer/line-of-sight-in-code-186dd7cdea88),
or watch the talk that he gave on the same topic.
