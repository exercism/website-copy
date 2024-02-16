### Reasonable solutions: 


```csharp
public class Anagram
{
    private readonly string _word;
    
    public Anagram(string word) => _word = word;
    
    public IEnumerable<string> FindAnagrams(IEnumerable<string> candidates) =>
        candidates.Where(IsAnagram).ToArray();
        
    private bool IsAnagram(string candidate) =>
        SortedLowerCase(candidate) == SortedLowerCase(_word) && IsDifferentFromWord(candidate);
        
    private bool IsDifferentFromWord(string candidate) =>
        !string.Equals(candidate, _word, StringComparison.OrdinalIgnoreCase);
        
    private static string SortedLowerCase(string word) =>
        new(word.ToLower().OrderBy(c => c).ToArray()); 
}
```

### Common suggestions
  
- consider the cost of generating strings for comparison
  
