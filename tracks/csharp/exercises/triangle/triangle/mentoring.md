# Mentoring Notes: Triangle

## Goal
The goal of the Triangle exercise is to practice working with conditional logic, enums, and C#'s switch expressions and pattern matching. This exercise demonstrates how to use both `if` statements and `switch` expressions effectively, encouraging students to write clean, readable, and maintainable code.

---

## Talking Points

### Enums
Enums are a strongly typed way to represent a set of named constants. They are commonly used to make code more readable and maintainable. In this exercise, an enum is used to represent the types of triangles.

- [MS Docs: Enum Documentation](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/builtin-types/enum)
- [Stack Overflow: what is enum and where can we use it?](https://stackoverflow.com/questions/38468017/what-is-enum-and-where-can-we-use-it)

### Switch Statements and Pattern Matching
Switch expressions and pattern matching in C# provide a concise and powerful way to control flow based on conditions. They are particularly useful for implementing logic to determine the type of a triangle.

- [MS Docs: Switch Statement](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/statements/selection-statements#the-switch-statement)
- [MS Docs: Pattern Matching](https://learn.microsoft.com/en-us/dotnet/csharp/fundamentals/functional/pattern-matching)
- [Medium: # C# Pattern Matching Examples](https://medium.com/@josiahmahachi/c-pattern-matching-examples-f8162ea76db6)

### Triangle Logic
Understanding the rules that determine the type of a triangle is key to solving this problem:
- An equilateral triangle has all sides equal.
- An isosceles triangle has at least two sides equal.
- A scalene triangle has all sides different.
- A triangle must satisfy the triangle inequality rule: the sum of any two sides must be greater than the third side.

---

## Example Code: Full Solution
Here is a complete example solution to the Triangle exercise:

```csharp
public static class Triangle
{
    private enum TriangleType
    {
        NotATriangle = 0,
        Scalene = 1,
        Isosceles = 2,
        Equalateral = 4
    }

    public static bool IsScalene(double side1, double side2, double side3)
        => GetTriangleType(side1, side2, side3).HasFlag(TriangleType.Scalene);

    public static bool IsIsosceles(double side1, double side2, double side3)
        => GetTriangleType(side1, side2, side3).HasFlag(TriangleType.Isosceles);

    public static bool IsEquilateral(double side1, double side2, double side3) 
        => GetTriangleType(side1, side2, side3).HasFlag(TriangleType.Equalateral);

    private static TriangleType GetTriangleType(double side1, double side2, double side3)
        => (side1, side2, side3) switch
        {
            _ when side1 >= side2 + side3 || side2 >= side1 + side3 || side3 >= side1 + side2 
                => TriangleType.NotATriangle,
            _ when side1 != side2 && side2 != side3 && side1 != side3 
                => TriangleType.Scalene,
            _ when side1 != side2 || side2 != side3 
                => TriangleType.Isosceles,
            _ => TriangleType.Equalateral | TriangleType.Isosceles,
        };
}
```

### Explanation
1. **Enum Usage**:
   - `TriangleType` represents different triangle types and includes a bitwise combination for `Equalateral | Isosceles`.
   - Enums improve readability by replacing magic numbers or strings with named constants.

2. **Switch Expressions**:
   - Switch expressions simplify conditional logic.
   - Pattern matching ensures the logic is concise and expressive.

3. **Validation**:
   - The `NotATriangle` case validates the triangle inequality rule upfront.
   - The rest of the logic identifies the triangle type based on its side lengths.

4. **Bitwise Flags**:
   - The `HasFlag` method is used to check if a triangle type matches a specific flag, allowing for clean and efficient checks.

---

## Key Concepts for Mentoring

1. **Enum Usage**: Highlight the use of enums for defining triangle types and the benefits of combining flags for multiple classifications.

2. **Switch and Pattern Matching**:
   - Discuss how switch expressions simplify code.
   - Emphasize the use of pattern matching for clear and maintainable logic.

3. **Validation and Bitwise Operations**:
   - Ensure students understand the importance of validating inputs.
   - Explain how bitwise operations are used with enums for efficient flag handling.

---

## Additional Resources
- [C# Enum Best Practices](https://learn.microsoft.com/en-us/dotnet/standard/design-guidelines/enum)
- [What does the [Flags] Enum Attribute mean in C#?](https://stackoverflow.com/questions/8447/what-does-the-flags-enum-attribute-mean-in-c)
- [Bitwise Operations in C#](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/operators/bitwise-and-shift-operators)
- [Pattern Matching in C#](https://learn.microsoft.com/en-us/dotnet/csharp/fundamentals/functional/pattern-matching)
- [Triangle Inequality](https://en.wikipedia.org/wiki/Triangle_inequality)


---
