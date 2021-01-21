### Reasonable solutions

#### using `Dictionary`

```csharp
using System.Collections.Generic;

public class SpaceAge
{
    private readonly double earthYear;
    private const double OrbitalPeriodEarth = 31_557_600.0;

    private static Dictionary<string, double> conversionFactor 
            = new Dictionary<string, double>()
    {
        {"Mercury", 0.2408467},
        {"Venus",   0.61519726},
        {"Mars",    1.8808158},
        {"Jupiter", 11.862615},
        {"Saturn",  29.447498},
        {"Uranus",  84.016846},
        {"Neptune", 164.79132},
        {"Earth",   1.0}
    };

    public SpaceAge(int seconds)
    {
        earthYear = seconds / OrbitalPeriodEarth;
    }

    private double GetOrbitalPeriodInEarthYears(string planetName) => earthYear / conversionFactor[planetName];

    public double OnEarth() => GetOrbitalPeriodInEarthYears("Earth");
    public double OnMercury() => GetOrbitalPeriodInEarthYears("Mercury");
    public double OnVenus() => GetOrbitalPeriodInEarthYears("Venus");
    public double OnMars() => GetOrbitalPeriodInEarthYears("Mars");
    public double OnJupiter() => GetOrbitalPeriodInEarthYears("Jupiter");
    public double OnSaturn() => GetOrbitalPeriodInEarthYears("Saturn");
    public double OnUranus() => GetOrbitalPeriodInEarthYears("Uranus");
    public double OnNeptune() => GetOrbitalPeriodInEarthYears("Neptune");
}
```

#### Using `constants`

```csharp
using System;

public class SpaceAge
{
    private readonly double earthYear;

    private const double OrbitalPeriodEarth = 31_557_600.0;
    private const double OrbitalPeriodMercuryInEarthYears = 0.2408467;
    private const double OrbitalPeriodVenusInEarthYears = 0.61519726;
    private const double OrbitalPeriodMarsInEarthYears = 1.8808158;
    private const double OrbitalPeriodJupiterInEarthYears = 11.862615;
    private const double OrbitalPeriodSaturnInEarthYears = 29.447498;
    private const double OrbitalPeriodUranusInEarthYears = 84.016846;
    private const double OrbitalPeriodNeptuneInEarthYears = 164.79132;

    public SpaceAge(int seconds) => earthYear = seconds / OrbitalPeriodEarth;

    public double OnEarth() => earthYear;
    public double OnMercury() => earthYear / OrbitalPeriodMercuryInEarthYears;
    public double OnVenus() => earthYear / OrbitalPeriodVenusInEarthYears;
    public double OnMars() => earthYear / OrbitalPeriodMarsInEarthYears;
    public double OnJupiter() => earthYear / OrbitalPeriodJupiterInEarthYears;
    public double OnSaturn() => earthYear / OrbitalPeriodSaturnInEarthYears;
    public double OnUranus() => earthYear / OrbitalPeriodUranusInEarthYears;
    public double OnNeptune() => earthYear / OrbitalPeriodNeptuneInEarthYears;
}
```

### Common suggestions

- _In case_ the values of each individual orbital period are defined in a variable, that variable should be defined as _const_.

- The internal variable (storing the number of seconds) should be a `readonly` field, initialized in the constructor.
    
- You may suggest writing the single-line methods as [expression-bodied methods](https://docs.microsoft.com/en-us/dotnet/csharp/language-reference/operators/lambda-operator#expression-body-definition), as it is perfect for these kinds of small methods.

### Talking points

- Not mentioned in the unit tests, negative time periods should be excluded
