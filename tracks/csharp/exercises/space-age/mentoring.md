### Reasonable solution

```csharp
using System;

public class SpaceAge
{
    private double _seconds {get;}
    private const int earthYearInSeconds = 31_557_600;
    private const double orbitalMercury = 0.2408467;
    private const double orbitalVenus = 0.61519726;
    private const double orbitalMars = 1.8808158;
    private const double orbitalJupiter = 11.862615;
    private const double orbitalSaturn = 29.447498;
    private const double orbitalUranus = 84.016846;
    private const double orbitalNeptune = 164.79132;
  
    public SpaceAge(int seconds) => _seconds = seconds;

    public double OnEarth() => _seconds / earthYearInSeconds;

    public double OnMercury() => _seconds / earthYearInSeconds / orbitalMercury;

    public double OnVenus() => _seconds / earthYearInSeconds / orbitalVenus;

    public double OnMars() => _seconds / earthYearInSeconds / orbitalMars;

    public double OnJupiter() => _seconds / earthYearInSeconds / orbitalJupiter;

    public double OnSaturn() => _seconds / earthYearInSeconds / orbitalSaturn;

    public double OnUranus() => _seconds / earthYearInSeconds / orbitalUranus;

    public double OnNeptune() => _seconds / earthYearInSeconds / orbitalNeptune;
}
```

### Common suggestions

- _In case_ values of the orbital periods are defined in variables, these should be defined either _const_ (these are implicitly static) or _static readonly_.

- The internal parameter (storing the number of seconds) could be an auto-implemented property or a readonly member (defined in the constructor)

    ```csharp
        private double _seconds {get;}
    ```
    
- It needs to be done a conversion to double. Either by defining as a double  (in our case_ _seconds_ is a double), or making an explicit conversion _(double)_

- Suggest [expression bodied members](https://docs.microsoft.com/en-us/dotnet/csharp/language-reference/operators/lambda-operator#expression-body-definition) syntax. It makes code cleaner for short (one-line) methods.

### Talking Suggestions

