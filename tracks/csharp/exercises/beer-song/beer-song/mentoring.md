## Mentoring

The student would normally go first using the if/else and if/else if statements. That's not wrong,
but the idea is guide him to an approach that will improve the readability and conciseness of the code.
Suggesting the use of case statements first will be optimal and instructive, since the number of cases
are bigger than a simple if/else.
When doing this, you can reference the learning material for the switch and highlight the usability of it.
Learning material: [Switch statements ](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/statements/selection-statements)

It's important to check if the student is also using clear names for the variables.

The verse string in the exercise is huge and it seems to repeat in every sentence, but as the exercise 
explains, it's not always equal and that's why we have more than just one or two cases for it.
With large strings inside the code, instructing the student to break them improves the readability.

Uncle Bob from the "Clean Code" Book recommends that every line should not contain more than 120 characters.
This can be challenging sometimes, but it's worthy. So in the exemplar solution we format the string 
using concatenation. 
```csharp
verse += "No more bottles of beer on the wall, no more bottles of beer.\n" +
         "Go to the store and buy some more, 99 bottles of beer on the wall.";
```
Show to the student the importance of formatting the code. It helps a lot with the comprehension
and when they went back to check older code, they won't be so confused with their own code.
Programmers spend more time reading than writing code.

If they still feel confused about formatting, this article dive deeper into it.
[Clean Code - Formatting](https://dev.to/caiocesar/clean-code-in-c-part-4-formatting-1b1h)

## The Exemplar Solution
Guide the student towards a solution closer to this. 

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
