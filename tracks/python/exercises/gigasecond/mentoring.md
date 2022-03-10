# Mentoring

## Problem and Challenges

The problem asks you to write a function which takes a `datetime.datetime` value and add a gigasecond to it.

## Reasonable Solution

```python
import datetime


def add(moment):
    return moment + datetime.timedelta(0, seconds=1e9)
```

## Talking Points

Given that the input value is a `datetime.datetime` object, it is reasonable to use other `datetime` objects to solve this exercise.
`datetime.timedelta` provides an object which can be used to add seconds to a `datetime.datetime` object.
