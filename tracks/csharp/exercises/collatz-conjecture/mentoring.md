### Reasonable solutions

#### Using a while loop

```csharp
using System;

public static class CollatzConjecture
{
    public static int Steps(int number)
    {
        if (number <= 0)
        {
            throw new ArgumentException("Only positive numbers are allowed");
        }

        var stepCount = 0;

        while (number != 1)
        {
            if (number % 2 == 0)
            {
                number /= 2;
            }
            else
            {
                number = number * 3 + 1;
            }

            stepCount++;
        }

        return stepCount;
    }
}
```

#### Using recursion

```csharp
using System;

public static class CollatzConjecture
{
    public static int Steps(int number)
    {
        if (number <= 0)
        {
            throw new ArgumentException("Only positive numbers are allowed");
        }

        return Steps(number, 0);
    }
    
    private static int Steps(int remainder, int stepCount)
    {
        if (remainder == 1)
        {
            return stepCount;
        }

        if (remainder % 2 == 0)
        {
            return Steps(remainder / 2, stepCount + 1);
        }

        return Steps(remainder * 3 + 1, stepCount + 1);
    }
}
```

As an alternative, one could use a local function to define the helper method:

```csharp
using System;

public static class CollatzConjecture
{
    public static int Steps(int number)
    {
        if (number <= 0)
        {
            throw new ArgumentException("Only positive numbers are allowed");
        }

        return Steps(number, 0);

        int Steps(int remainder, int stepCount)
        {
            if (remainder == 1)
            {
                return stepCount;
            }

            if (remainder % 2 == 0)
            {
                return Steps(remainder / 2, stepCount + 1);
            }

            return Steps(remainder * 3 + 1, stepCount + 1);
        }
    }
}
```

Note that C# does not have [tail-call optimization](https://github.com/dotnet/roslyn/issues/1235), which could lead this implementation to throw a `StackOverflowException` when it loops too much.

### Common suggestions

- To divide the number by two, one can use `number /= 2` instead of `number = number / 2`.

### Talking points

