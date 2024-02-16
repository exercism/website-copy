# Mentoring

## Problems and Challenges

This problem requires the student to transform an integer (0 <= n < 1,000,000,000,000) into its full English equivalent, and raise an exception for values outside that range.
Take note of the tests - the use of 'and' as a separator is not required, and adding it will cause the tests to fail, but it is suggested as an extension exercise. 

## Reasonable Solution

```python
digits = [""] + "one two three four five six seven eight nine".split()
teens = "ten eleven twelve thirteen fourteen fifteen sixteen seventeen eighteen nineteen".split()
tens = ["", ""] + "twenty thirty forty fifty sixty seventy eighty ninety".split()
denominations = (9, "billion"), (6, "million"), (3, "thousand"), (2, "hundred")

def say(number):
    if 0 > number or number > 999999999999:
        raise ValueError("input out of range")
    if 10 <= number < 20:
        return teens[number % 10]
    if number < 100:
        if number // 10 and number % 10:
            return "-".join([tens[number // 10], digits[number % 10]])
        else:
            return tens[number // 10] or digits[number % 10] or "zero"
    for k, denomination in denominations:
        if number > 10**k - 1:
            result = [say(number // 10**k), denomination]
            if number % 10 ** k:
                result.append(say(number % 10**k))
            return " ".join(result)
```
Or without using recursion:

```python
denominations = (9, "billion"), (6, "million"), (3, "thousand"), (0, "")

def say_three_digits(number):
    hundreds_col, tens_col, ones_col = number // 100, number // 10 % 10, number % 10
    result = [str(digits[hundreds_col]) + " hundred"] if hundreds_col else []
    if tens_col == 1:
        result.append(teens[ones_col])
    elif tens_col and ones_col:
        result.append("-".join([tens[tens_col], digits[ones_col]]))
    else:
        result.append(tens[tens_col] or digits[ones_col])
    return result

def say(number):
    if 0 > number or number > 999999999999:
        raise ValueError("input out of range")
    result = []
    for k, denomination in denominations:
        if number > 10**k - 1:
            result += say_three_digits(number // 10**k)
            result += [denomination]
            number %= 10**k
    return " ".join(e for e in result if e) or "zero"
```

## Common Suggestions

### Defining the literals

Typically this problem will begin with defining the literals needed. 
These can be done as either lists or dictionaries; many students will find dictionaries easier to work with for this problem. 
Encourage the student to define these at the start rather than embedding them in their code.

### Values below 1000

Next, the instructions suggest beginning by creating a function which works for values of up to three digits.
The return value of this function will typically be a string, but it can also be a list of strings for later assembly.
Whether in this function or for the final return, encourage them to use a list and combine the elements using `str.join`.

The main challenges are ensuring that the 'hundred' denominator is conditionally included and that the tens and ones columns are joined with a hyphen if they are both present.
Simple `if` checks for each of these conditions is the most straightforward approach.

Another approach is to only handle values below 100, and instead handle the hundreds alongside the other denominators.
This typically requires the use of recursion. 

### Larger numbers

Encourage the student to use the first function they wrote for each set of three digits rather than duplicating code.
Each set of three can be checked individually and conditionally added along with the appropriate denominator, or alternatively the denominators can be stored in a list and iterated over.

### Zero or invalid input

Finally, the student must add a guard that returns a `ValueError` if the input is out of range. 
A guard is also the easiest way to handle the zero case, but this can also be handled through short circuit evaluation.

### Parsing the number

The number needs to be broken up into groups of three as well as isolating each digit. 
Two common approaches are to use the `//` and `%` operators or to cast the integer to a string and access the digits by indexing or iterating.

## Talking Points

List comprehensions are very useful for this exercise.

There are a wide variety of valid approaches to this problem, which gives students a lot of opportunity to experiment and encounter new ways of manipulating data.
Some useful techniques that students might not have encountered are listed below.
Students will not need or want to use all of these, but mentors should look for opportunities in the student's code to introduce one or more of them.
* Casting between numeric types and strings
* String indexing, iteration, formatting, or concatenation
* String methods such as `zfill`, `isnumeric`, `split`, or `join`
* List concatenation using the `+` operator
* List methods such as `append` or `extend`
* Iterator functions such as `zip`, `enumerate`, or `filter`
* Assignment operators
* Unpacking operator
* Short circuit evaluation and the use of `or`/`and` for control flow
* Ternary conditional operator
* Integer division and modulo operators, and the divmod function
* Recusion

Students who wish to extend the exercise can rewrite the function to include 'and' as a separator as well as handle negative or larger numbers.
This will require rewriting the tests, which might also serve as a learning opportunity for the student.

This problem is a good opportunity to practice writing concise code and balancing readability. 
It is also a good chance to code verbosely while the problem is solved, and then iterate on the solution to reduce length and complexity.
A terse solution which demonstrates some techniques:

```python
digits = [""] + "one two three four five six seven eight nine".split()
teens = "ten eleven twelve thir four fif six seven eigh nine".split()
tens = ["", ""] + "twenty thirty forty fifty sixty seventy eighty ninety".split()
denominations = (9, "billion"), (6, "million"), (3, "thousand"), (2, "hundred")

def say(n):
    if 0 > n or n > 999999999999:
        raise ValueError("input out of range")
    if 10 <= n < 20:
        return teens[n % 10] + "teen" if n % 10 > 2 else ""
    if n < 100:
        return "-".join(filter(bool, [tens[n // 10], digits[n % 10]])) or "zero"
    k, d = [t for t in denominations if n > 10**t[0] - 1][0]
    return " ".join([say(n // 10**k), d] + ([say(n % 10**k)] if n % 10**k else []))
```
