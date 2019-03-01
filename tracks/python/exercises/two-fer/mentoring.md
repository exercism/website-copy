This is a great opportunity to prepare for the track with attention to style conventions. 

### Reasonable solutions

```python
def two_fer(name="you"):
    return "One for {}, one for me.".format(name)
```

```python
def two_fer(name='you'):
    return f'One for {name}, one for me.'
```

### Common suggestions
- Suggest using a default value instead of any form of conditionals.
- Suggest [Literal String Interpolation introduced with Python 3.6](https://www.python.org/dev/peps/pep-0498/).
- Some people need help with running the tests. 
- Check indentation.

### Talking points
- Default values
- String interpolation
- Style preferences. This exercise is a good opportunity to talk about style conventions like indentation, parameter parenthesis in method declarations and removing redundant comments. 
Given the place in the curriculum it may be worth not going too deep and to not address points that are controversial or personal preference. 

### Mentoring notes
- A friendly standard answer about how this can be done in one line, and a 'hint: use a different default value' to get rid of the conditionals, will be all you need for maybe 90% of the submissions. 
