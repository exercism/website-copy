# Mentoring

### Reasonable solution

#### using LINQ 
The exercise aims to teach two concepts: `List<T>` as a generic collection, combined with basic LINQ methods. 

```csharp
using System.Collections.Generic;
using System.Linq;

public class HighScores
{
    private readonly List<int> _scores; 

    public HighScores(List<int> list)
    {
        _scores = list;
    }

    public List<int> Scores() => _scores.ToList(); 
    public int Latest() => _scores.Last();
    public int PersonalBest() => _scores.Max();
    public List<int> PersonalTopThree() => _scores.OrderByDescending(s => s).Take(3).ToList();
}
```

### Common suggestions
- LINQ is especially helpful in the `PersonalTopThree`  method, where a combination of `OrderByDescending` and `Take` provides a quick solution [with an example](https://docs.microsoft.com/en-us/dotnet/api/system.linq.enumerable.take?view=netcore-2.1). The `Take` method does not raise an exception when there are less elements than the specified count. 
- By design, field `_scores` should be `private`
    
### Talking points

- While scores could be made `readonly` here, it may be not a general recommendation. We might expect the class to be expanded further.
- Implementing the `Latest()` method using `Last()` is okay for the scope of this exercise. However, `LastOrDefault()` should be more frequent used, especially when we need to check whether there was an element or not. In other words, when it is legal for the sequence to be empty - and in our case it is. We should not rely on exception handling for the check, which is not a good practice and brings a performance penalty.
- It might be useful to suggest writing methods as [expression-bodied methods](https://docs.microsoft.com/en-us/dotnet/csharp/programming-guide/statements-expressions-operators/expression-bodied-members#methods), as they are perfect for these kinds of small methods.
