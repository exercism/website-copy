### Reasonable solutions: 

public class Anagram
{
  private readonly IEnumerable<char> orderedLetters;

  public Anagram(string word)
  {
    orderedLetters = word.ToLower().OrderBy(character => character);
  }
  
  public string[] FindAnagrams(string[] words)
    => words.Where(IsAnagram).ToArray(); 
  
  private bool IsAnagram(string candidate)
    => Enumerable.SequenceEqual(candidate.ToLower().OrderBy(c => c), orderedLetters);
}
  
### Common suggestions: Good suggestions specific to this exercise. Good lessons that emerge from it.
  
-- consider the cost of generating strings for comparison
  
### Talking points: Questions to challenge more advance learners with.
