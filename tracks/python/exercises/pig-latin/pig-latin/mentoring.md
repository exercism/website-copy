# Pig Latin


## Common Areas of Improvement
When mentoring students on the Pig Latin exercise, it's essential to focus on common areas where they might struggle. Here are some key points to keep in mind:

1. Understanding the Rules Clearly
    - Rule Comprehension: Ensure that students fully understand each of the Pig Latin translation rules before diving into coding. Misunderstanding the rules often leads to incorrect implementations.
    - Edge Cases: Highlight the importance of edge cases such as words starting with "xr" or "yt", and those containing "qu".
2. String Manipulation Skills
    - Splitting and Joining Strings: Students should be comfortable using functions to split sentences into words and join words back into sentences.
    - String Slicing: Emphasize the importance of correctly slicing strings to rearrange parts of the word as per the rules.
    - Prefix Checking: Encourage using built-in string functions like starts with to simplify rule checks.
3. Iterating Over Strings
    - Looping Over Characters: Ensure students understand how to iterate over characters in a string, especially when finding the first vowel or handling specific patterns.
    - Range-based Loops: Encourage using range-based loops or list comprehensions for readability and efficiency.
4. Condition Handling
    - Simplifying Conditions: Help students learn to simplify complex conditions using logical operators and short-circuit evaluation to make their code more readable.
    - Avoiding Nested Conditions: Suggest breaking down nested conditions into simpler, well-named functions to improve clarity.
5. Code Readability and Maintenance
    - Comments and Documentation: Reinforce the habit of writing meaningful comments and docstrings to explain their logic, especially for complex parts.
    - Function Decomposition: Guide students to decompose their solution into smaller, reusable functions, each handling a specific rule or task.
  
## Common suggestions:

    - Avoid complex, deeply nested logic.
    - Reduce the number of special cases by generalizing logic. For instance, the first vowel in the word can potentially be handled the same, regardless of whether it is at the start of the word or not.
    - Prefer if/else chains.
    - Add explanatory comments when the intent of the code might not be clear to the reader.

## Examples and Talking Points:
1. Clear Rule Application:
    - Before: Students might apply rules in a scattered way.
    - Improvement: Help them structure their code to apply rules in a clear, step-by-step manner.

2. Efficient String Handling:
    - Before: Using manual loops for operations that can be handled by built-in functions.
    - Improvement: Introduce functions like split, join, starts with, and slicing techniques to simplify their code.

3. Comprehensive Testing:
    - Before: Testing with only a few basic cases.
    - Improvement: Show them how to write tests that cover all rules, including edge cases like "yttria" or "squeal".
