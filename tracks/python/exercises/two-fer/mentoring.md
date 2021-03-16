# Mentoring

This is a great opportunity to prepare for the track with attention to style conventions.
This is currently the first reviewed problem on the Python track, and serves to
make sure the student understands unit testing and Test Driven Design.

## Reasonable Solutions

```python
def two_fer(name="you"):
    return "One for {}, one for me.".format(name)
```

```python
def two_fer(name='you'):
    return f'One for {name}, one for me.'
```

## Common Suggestions

- Suggest using a default value instead of any form of conditionals.
- If the student is using Python 3? Suggest [Literal String Interpolation introduced with Python 3.6](https://www.python.org/dev/peps/pep-0498/).
- If the student is using Python <= 3.5, suggest upgrading to Python 3.7 for additional language features.
- Some people need help with running the tests.
- Check indentation.
- Printing vs. returning

## Talking Points

- Default values
- String interpolation
- Style preferences. This exercise is a good opportunity to talk about style conventions like indentation, parameter parenthesis in method declarations and removing redundant comments.
  Given the place in the curriculum it may be worth not going too deep and to not address points that are controversial or personal preference.
- Unit Tests. For some students this will be an introduction to the notion of unit tests.
  Make the case that these allow them to be productive while engaging with the problem.

## Mentoring Notes

A friendly standard answer about how this can be done in one line, and a 'hint: use a different default value' to get rid of the conditionals, will be all you need for maybe 90% of the submissions.

For another 5% of the submissions you will need to go into detailed instructions.
You might start with some questions:

Do they know how to run the tests?
Some users may have trouble running pytest due to path issues.
They can still use

```python
     python two_fer_test.py
```

Do they understand what the tests tell them?
It may be helpful to take apart one of the assertions:
explaining what the test called and what it expected.

```python
    def test_no_name_given(self):
        self.assertEqual(two_fer(), 'One for you, one for me.')
```

When they can describe what is going wrong, you may wish to give
them the term 'Default Arguments' and let them search, or give
them a reference to your favorite article about default arguments.

### Editing the Tests

You will see students who modify the tests to get them to pass.
You should explain the function and importance of the tests.

### Test Driven Thinking

The submission below passes all the tests, but misses the point.
Ask what happens when Carol and Doug show up.

```python
def two_fer(name=None):
    if name == 'Alice':
        return 'One for Alice, one for me.'
    elif name == 'Bob':
        return 'One for Bob, one for me.'
    else:
        return 'One for you, one for me.'
```

### Variadic Argument List

We can use a variadic argument list to solve the problem

```python
def two_fer(*name):
    if name:
        return 'One for ' + name + ', one for me.'
    else:
        return 'One for you, one for me.'
```

This satisfies the tests but is more complex than needed.
Encourage the student to find a simpler solution,
perhaps suggest the term "default argument".
