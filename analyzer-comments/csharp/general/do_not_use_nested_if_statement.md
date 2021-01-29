Try rewriting the if-statements to avoid deep nesting, as it can lead to code that is harder to follow. Consider the following two pieces of code:

```csharp
void PrintName(Person p)
{
    if (p != null)
    {
        if (p.Name != null)
        {
            if (p.Age >= 21)
            {
                Console.WriteLine(p.Name);
            }
        }
    }
}
```

Compare that to the following code:

```csharp
void PrintName(Person p)
{
  if (p == null || p.Name == null || p.Age < 21)
  {
      return;
  }

  Console.WriteLine(p.Name);
}
```

The second example has a very specific structure: all paths that are dealing with errors are dealt with in indented blocks, whereas the "happy path" is always leftmost aligned. This makes for very easy reading, as one can quickly see what is the most common, error-free path through the code.
