### Reasonable solutions

#### using Dictionary
    ```csharp
    using System.Collections.Generic;

    public class SpaceAge
    {
        private readonly double earthYear;

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
        };

        public SpaceAge(int seconds)
        {
            earthYear = seconds / 31557600.0;
        }
    
        public double OnEarth() => earthYear;
        public double OnMercury() => earthYear / conversionFactor["Mercury"];
        public double OnVenus() => earthYear / conversionFactor["Venus"];
        public double OnMars() => earthYear / conversionFactor["Mars"];
        public double OnJupiter() => earthYear / conversionFactor["Jupiter"];
        public double OnSaturn() => earthYear / conversionFactor["Saturn"];
        public double OnUranus() => earthYear / conversionFactor["Uranus"];
        public double OnNeptune() => earthYear / conversionFactor["Neptune"];
    }
    ```

- or const members
    ```csharp
    using System;

    public class SpaceAge
    {
        private double _seconds { get; }
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

- _In case_ values of each indivdual orbital period is defined in a variable, these should be defined either as _const_ (these are implicitly static) or _static readonly_.

- The internal parameter (storing the number of seconds) could be an auto-implemented property or a readonly member (with value initialized in the constructor)

    ```csharp 
        private double _seconds {get;}
    ```
    
- It needs to be done a conversion to double. Either by defining as a double  (in our case_ _seconds_ is a double), or making an explicit conversion _(double)_

- Suggest [expression bodied members](https://docs.microsoft.com/en-us/dotnet/csharp/language-reference/operators/lambda-operator#expression-body-definition) syntax. It makes code cleaner for short (one-line) methods.

### Talking Suggestions

- Not mentioned in the unit tests, should negative time periods be excluded ?
