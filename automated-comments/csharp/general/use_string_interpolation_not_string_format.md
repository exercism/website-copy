A more common approach in C# is to use [string interpolation](https://csharp.net-tutorials.com/operators/the-string-interpolation-operator/), rather than using `string.Format` to dynamically build a string.

Note that string interpolation is just a compiler trick, also known as syntactic sugar. This means that when a string interpolation expression is compiled, the compiler will actually convert it to a `string.Format` call. The benefit of using string interpolation is thus purely visual.
