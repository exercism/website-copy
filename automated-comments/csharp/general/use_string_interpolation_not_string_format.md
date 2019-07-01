Rather than using `string.Format` to dynamically build a string, the more common C# approach is to use [string interpolation](https://csharp.net-tutorials.com/operators/the-string-interpolation-operator/).

Note that string interpolation is just a compiler trick, also known as syntactic sugar. This means that when a string interpolation expression is compiled, the compiler will just convert it to a `string.Format` call. The benefit of using string interpolation is thus purely visual.
