We need to check first if the triangle is a triangle.
```
  static bool IsTriangle(double a, double b, double c) => a + b > c && a + c > b && b + c > a;
```
Then, all of the methods have to invoke it as a first step and add the rest of the condition
```
  public static bool IsEquilateral(double a, double b, double c) => IsTriangle(a,b,c) && a == b && b == c;
  public static bool IsIsosceles(double a, double b, double c) => IsTriangle(a,b,c) && (a == b || b == c || a == c);
  public static bool IsScalene(double a, double b, double c) => IsTriangle(a,b,c) && (a != b && b != c && a != c);
```
As in the example above, all of them can be one-line methods set with lambda expression,
here is a helpful part of the documentation for [lambda expression](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/operators/lambda-operator#expression-body-definition)

You may also make a remark that lambda expression aren't only related to C#, they are also used in different languages like [javascript/typescript](https://www.tutorialspoint.com/how-to-use-lambda-expression-in-typescript#:~:text=Lambda%20expressions%2C%20commonly%20referred%20to,defining%20functions%20in%20both%20languages.)
