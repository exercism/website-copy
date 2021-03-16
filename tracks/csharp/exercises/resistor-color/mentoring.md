# Mentoring

## Reasonable solutions
### Array Based
``` 
public static class ResistorColor
{
    private static readonly string[] resistorColors = { "black", "brown", "red", "orange", "yellow", "green", "blue", "violet", "grey", "white" };

    public static int ColorCode(string color) => System.Array.IndexOf(resistorColors, color);

    public static string[] Colors() => resistorColors;
}
```
### Dictionary Based
```
﻿using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
  
public static class ResistorColor
{
    private static ReadOnlyDictionary<string, int> colors = new ReadOnlyDictionary<string, int>(new Dictionary<string, int>
    {
        {"black", 0},
        {"brown", 1},
        {"red" , 2},
        {"orange", 3},
        {"yellow", 4},
        {"green", 5},
        {"blue", 6},
        {"violet", 7},
        {"grey", 8},
        {"white", 9}
    });
 
    public static int ColorCode(string color)
    {
        return colors[color];
    }
 
    public static string[] Colors()
    {
        return colors.Keys.ToArray();
    }
}
```
### Enum Based
```
using System;

public static class ResistorColor
{
    enum Color
    {
        black,
        brown,
        red,
        orange,
        yellow,
        green,
        blue,
        violet,
        grey,
        white
        
    }
    public static int ColorCode(string color)
    {
        return (int)Enum.Parse(typeof(Color), color);
    }

    public static string[] Colors()
    {
        return Enum.GetNames(typeof(Color));        
    }
}
```
### Common suggestions
* Enum version: If users are able to input or read out number values for the
resistors then it might be more expressive to assign the numbers to
the enums to show that the actual values are important. 
* Array version: consider cloning the array on return from `Colors()` as
a defensive measure. This will prevent a user of the class from
accidentally overwriting the values.
### Talking points
* This may or may not be the place to handle the letter case of the colors.
* Array version: students are frequently calling `Colors()` from
`ColorCode()` and recreating the array there each time. This does not 
give optimal performance. Discretion should be used as to whether to raise this point
as we don't want to overwhelm novices.
* Dictionary version: The returned dictionary should be `readonly` as 
a defensive measure. This will prevent a user of the class from
accidentally overwriting the values.
* Arguably the most maintainable solution would be a dictionary mapping
string color names to explicit enums. This would apply if both color names 
and color values are mapped outside of this code, for example in a 
design document or a spec. Implicit mappings are less maintainable. 
As a bonus it's easier to mentally map the dictionary to the spec file. 
