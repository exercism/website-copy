Rather than using `string.Format`, consider using [string interpolation](https://csharp.net-tutorials.com/operators/the-string-interpolation-operator/) to dynamically build a string.

Note that string interpolation is just a compiler trick, also known as syntactic sugar. This means that when a string interpolation expression is compiled, the compiler will just convert it to a `string.Format` call. The benefit of using string interpolation is thus purely visual.
