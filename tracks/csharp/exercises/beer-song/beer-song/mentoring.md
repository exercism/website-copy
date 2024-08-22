## Mentoring
The student would normally go first using the if/else and if/else if statements.
Suggesting the use of case statements first will be optimal and instructive. 
Learning material: [Switch statements ](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/statements/selection-statements)

## The Exemplar Solution
Try and guide the student towards this solution.
```csharp
public static class BeerSong
{
    public static string Recite(int bottles, int takeDown)
    {
        string verse = "";

        for (int i = takeDown; i > 0; i--)
        {
            switch (bottles)
            {
                case 0:
                    verse += "No more bottles of beer on the wall, no more bottles of beer.\n" +
                        "Go to the store and buy some more, 99 bottles of beer on the wall.";
                    break;
                case 1:
                    verse += "1 bottle of beer on the wall, 1 bottle of beer.\n" +
                        "Take it down and pass it around, no more bottles of beer on the wall.";
                    break;
                case 2:
                    verse += "2 bottles of beer on the wall, 2 bottles of beer.\n" +
                        "Take one down and pass it around, 1 bottle of beer on the wall.";
                    break;
                default:
                    verse += $"{bottles} bottles of beer on the wall, {bottles} bottles of beer.\n" +
                        $"Take one down and pass it around, {bottles - 1} bottles of beer on the wall.";
                    break;
            }
            if (i != 1)
                verse += "\n\n";

            bottles--;
        }
        return verse;
    }
}
```
