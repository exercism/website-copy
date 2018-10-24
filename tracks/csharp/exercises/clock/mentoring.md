### Reasonable solutions
#### Struct based

```csharp
using System;

public struct Clock
{
    private const int HoursPerDay = 24;
    private const int MinutesPerHour = 60;

    public Clock(int hours, int minutes)
    {
        Hours = Mod((hours * MinutesPerHour + minutes) / (float)MinutesPerHour, HoursPerDay);
        Minutes = Mod(minutes, MinutesPerHour);
    }

    public int Hours { get; }

    public int Minutes { get; }

    public Clock Add(int minutesToAdd) => new Clock(Hours, Minutes + minutesToAdd);

    public Clock Subtract(int minutesToSubtract) => new Clock(Hours, Minutes - minutesToSubtract);

    public override string ToString() => $"{Hours:00}:{Minutes:00}";

    private static int Mod(double x, double y) => (int)(((x % y) + y) % y);
}
```

#### Class based
If you implement Clock as a class you have to handle the tricky rules of equality
```csharp
public class Clock
{
    private readonly int timeInMinutes;
    
    public Clock(int hours, int minutes)
    {
        timeInMinutes = AdjustClock(hours * 60 + minutes, 0);
    }

    public int Hours => timeInMinutes / 60;
    public int Minutes => timeInMinutes % 60;
    
    public Clock Add(int minutesToAdd) => new Clock(Hours, Minutes + minutesToAdd);

    public Clock Subtract(int minutesToSubtract) => Add(-minutesToSubtract);

    public override string ToString()
    {
        return $"{Hours:D2}:{Minutes:D2}";
    }

    private int AdjustClock(int minutesIn, int adjustmentMinutes)
    {
        return (24 * 60 + ( minutesIn + adjustmentMinutes) % (24 * 60)) % (24 * 60);
    }

    private bool Equals(Clock other)
    {
        return timeInMinutes == other.timeInMinutes;
    }

    public override bool Equals(object obj)
    {
        if (ReferenceEquals(null, obj)) return false;
        if (ReferenceEquals(this, obj)) return true;
        if (obj.GetType() != this.GetType()) return false;
        return Equals((Clock) obj);
    }

    public override int GetHashCode()
    {
        return timeInMinutes;
    }
}
```

### Common suggestions

- The clock can be implemented as a struct or a class.  The main practical advantage of the struct
 in this exercise is that equality is handled automatically for the struct
- To pad the string "00" and "D2" (where D stands for decimal) are equally valid

### Talking points

- The student may not be aware of the best way to handle the arithmetic involving negative hours and minutes,
coded in the above examples as `Mod()` and `AdjustClock()` respectively.
- The meaning in computing of modulo with regard to negative numbers varies from language to language per [Wikipedia](https://en.wikipedia.org/wiki/Modulo_operation).
For C# the `%` operator, referred to as remainder, is precisely defined in the [docs](https://docs.microsoft.com/en-us/dotnet/csharp/language-reference/operators/or-operator) as follows:
> For the integer operands, the result of `a % b` is the value produced by a - (a / b) * b. The sign of the non-zero remainder is the same as that of the first operand
- `private const`s are preferred to `readonly` fields as they are more idiomatic and, not that it matters
much here, more performant
- Converting the time to minutes simpifies processing.  Again, not a particularly C# point
- `IEquatable` does not buy you anything in this example.  IEquatable allows an object to signal
that callers such as a generic collection can use a typed implementation of `Equals()` to test
equality.  In the case of classes this simply saves a call through `Equals(object)'.  In the case of
structs there is also the issue of boxing