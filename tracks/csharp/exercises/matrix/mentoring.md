### Reasonable solutions: 

Solution without Linq:
```csharp
using System.Collections.Generic;

public class Matrix
{
  private readonly int[][] matrix;
  
  public Matrix(string input)
  {
    var output = new List<int[]>();
    
    foreach(var rowString in input.Split("\n")) {
      var row = new List<int>();
      foreach(var v in rowString.Split(" ")) {
        row.Add(int.Parse(v));
      }
      output.Add(row.ToArray());
    }

    matrix = output.ToArray();
  }

  public IEnumerable<int> Row(int row)
    => matrix[row-1];

  public IEnumerable<int> Column(int col)
  {
    foreach(var row in matrix) { 
      yield return row[col-1]; 
    }
  }
}
```

Solution with Linq:
```csharp
using System.Linq;
using System.Collections.Generic;

public class Matrix
{
    private readonly int[][] matrix;
    
    public Matrix(string input)
    {
        matrix = input
          .Split("\n")
          .Select(r => r.Split(" ").Select(x => int.Parse(x)).ToArray())
          .ToArray();
    }
	
    public IEnumerable<int> Row(int row)
      => matrix[row-1];
	
    public IEnumerable<int> Column(int col)
      => matrix.Select(x => x[col-1]);
}
```

### Common suggestions:
*Good suggestions specific to this exercise. Good lessons that emerge from it.*

- While it is possible to solve the problem using multidimensional arrays the jagged array is easier to work with.
This is because it is possible to return a single row simply as `matrix[r]`.  

### Talking points:
*Questions to challenge more advance learners with.*

- The differences between multidimensional and jagged arrays in general and in C#.
In this case the data is dense so there are no memory efficiencies to talk about. 
However, the choice influeces the type of code we can write. 
- There are two problems: parsing of input and responding to queries. 
Both are relatively simple and there is no need for input checking. 
- The problem can be solved with iteration using loops and using Linq. What's the difference? 
Both the parsing and access to column data change. 
The change in parsing is more obvious between very imperative use of two loops vs more declarative expression using linq. 
