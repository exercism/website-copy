### Reasonable Solutions

There are other reasonable solutions not listed here.

```typescript
export class ResistorColor {
  
  private readonly Colors: string[] = ["black", "brown", "red", "orange", "yellow", "green", "blue", "violet", "grey", "white"]
  
  private readonly MINIMUM_ACCEPTABLE_COLORS = 2;

  constructor(private colors: string[]) {
    
    if (colors.length < this.MINIMUM_ACCEPTABLE_COLORS)
      throw "At least two colors need to be present";

  }

  value = (): number => {
    
    const result = this.colors
      .slice(0, this.MINIMUM_ACCEPTABLE_COLORS)
      .map((c) => this.Colors.indexOf(c))
      .join('')

    return Number(result);

  }

}
```

### Common Suggestions

- The student should create an array containing the list of color strings. This can be a top-level constant or a `private` and `readonly` member.

- Look for an opportunity to put the access modifier `private` keyword in the constructor for the shorthand way of assigning it to an instance variable.

- Ensure the student checks for the error case early on as to short-circuit the program as quickly as possible.

- If the student hardcodes numbers (such as _2)_, point out that rather than having this "magic number" it could be a constant or readonly instance variable.

- Any final comments on chosen names, formatting, unnecessary code / comments / console.log's

- If the student uses `parseInt(n)`, consider recommending the faster `Number(n)` syntax.