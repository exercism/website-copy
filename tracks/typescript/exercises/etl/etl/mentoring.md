# Mentoring

## ETL

### Problem asks

Restructure grouped letters by point values into individual mappings. 
Transform the old format (point-value groups) into a new format (letter-score pairs) in TypeScript. 
Associate lowercase letters with their corresponding point values, transitioning from grouped data to individual letter scoring.

## Reasonable Solution

The code snippet provided in TypeScript represents a function named `transform`. 
This function takes in an object `oldData`, which has keys representing point values (as strings) and values as arrays of strings (letters associated with those point values).

The function iterates through the `oldData` object, assigning each letter (converted to lowercase) to its corresponding score in the `newData` object. 
The return value of the function is an object where keys are lowercase letters and values are the associated point values (as numbers).

```typescript
export function transform(oldData: { [key: string]: string[] }): { [key: string]: number } {
    const newData: { [key: string]: number } = {};

    for (const [score, letters] of Object.entries(oldData)) {
        letters.forEach((letter: string) => {
            newData[letter.toLowerCase()] = parseInt(score);
        });
    }

    return newData;
}
```


### Common Suggestions:

1. **Type Annotations:**
   - Encourage the use of explicit type annotations for parameters and return values to enhance code readability and maintainability.

   ```typescript
   export function transform(oldData: { [key: string]: string[] }): { [key: string]: number } {
   ```

2. **Data Validation:**
   - Discuss potential edge cases or invalid data scenarios. What happens if the input data is malformed or if a letter is associated with multiple scores?

### Talking Points:

- **ETL Concept:**
  - Briefly explain the ETL concept, emphasizing its role in transforming data from one format to another.

- **Type Safety:**
  - Emphasize the use of TypeScript for type safety. Ensure that the input and output types are clearly defined to catch potential runtime errors.

- **Functional Approach:**
  - Introduce a more functional approach using methods like `map` and `reduce` for constructing the new data object, making the code more concise.

