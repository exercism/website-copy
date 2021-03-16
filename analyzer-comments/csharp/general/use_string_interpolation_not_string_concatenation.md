# use string interpolation not string concatenation

Use [string interpolation](https://csharp.net-tutorials.com/operators/the-string-interpolation-operator/) to dynamically build a string, rather than using string concatenation. The main benefit is less "noise"; whereas string concatenation requires `+` to be added between each string, string interpolation has no such limitation. As a result, string interpolation code is usually a bit easier to read.
