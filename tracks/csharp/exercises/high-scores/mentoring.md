### Reasonable solutions

#### using LINQ 
```csharp
using System.Collections.Generic;
using System.Linq;

public class HighScores
{
    // Fields
    private List<int> _scores; 

    // Constructor
    public HighScores(List<int> list)
    {
        _scores = list;
    }


    // Methods
    public List<int> Scores() => _scores.ToList(); 
    public int Latest() => _scores.Last();
    public int PersonalBest() => _scores.Max();
    public List<int> PersonalTopThree() => _scores.OrderByDescending(s => s).Take(3).ToList();
}
```

### Common suggestions
- The exercise focuses mainly on using two concepts: List collection, combined with basic LINQ methods. LINQ is especially helpful on creating method "PersonalTopThree". 
- Take(3) takes maximum three elements, and it does not raise an exception when there are less elements
- Field _scores should be private.
    
### Talking points
- While scores could be made readonly here, it may be not a general recommendation. We would expect the example to be further expanded.
