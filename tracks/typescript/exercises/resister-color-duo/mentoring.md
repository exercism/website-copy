
### Reasonable Solutions

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
      .reduce(
        (accumulator: string, current: string) =>
          `${accumulator}${this.Colors.indexOf(current)}`,
          ''
      );

    return parseInt(result);

  }

}
```

### Common suggestions

- The student should create an array containing the list of color strings. This should be `private` and `readonly`.

- Look for an opportunity to put the access modifier `private` keyword in the contructor for the shorthand way of assigning it to an instance variable.

- Ensure the student checks for the error case early on as to short-circuit the program as quickly as possible.

- If the student hardcodes numbers (such as _2)_, point out that rather than having this "magic number" it could be a constant or readonly instance variable.

- Ensure the student uses proper type annotations, but consider suggesting they omit the types in "obvious" cases (such as when immediately assigning the variable to concrete value).

- Any final comments on chosen names, formatting, unncessary code / comments / console.log's