### Problem and Challenges

The solution must implement an object that stores
minutes and hours, and can add or subtract minutes.

#### Complications

The usual contraints apply: 0 <= hours < 24 and
0 <= minutes < 60.

### Reasonable solutions

```python
class Clock(object):
    def __init__(self, hour, minute):
        self.h, self.m = divmod((hour * 60 + minute) % (24 * 60), 60)

    def __repr__(self):
        return '%02d:%02d' % (self.h, self.m)

    def __eq__(self, other):
        return self.h == other.h and self.m == other.m

    def __add__(self, minutes):
        return self.__class__(self.h, self.m + minutes)

    def __sub__(self, minutes):
        return self.__class__(self.h, self.m - minutes)
```

The key to the simplicity of this solution is the constructor.
By taking the hours and minutes, transforming them into minutes
past midnight, reducing mod the number of minutes in a day,
and then finding the hours and minutes in the mix, they
deal with test cases such as Clock(25, 160)

Here is a working version of __init__ that shows how 
difficult we can make things:

```python
class Clock(object):
    def __init__(self, hour, minute):
        while minute >= 60:
            hour += 1
            minute -= 60
        while minute < 0:
            hour -= 1
            minute += 60
        self.minute = minute
        self.hour = hour % 24
```

#### Repetitive Injury and Failure to Launch

You will see solutions with a working constructor
which still repeat the logic in __add__ and __sub__.
Point out that they should solve each problem only 
once: repeated logic tends to drift apart.

```python
    def __add__(self, minutes):
        minute = self.minute + minutes
        hour = self.hour
        while minute >= 60:
            minute -= 60
            hour += 1
        hour = hour % 24
        return f'{hour:02d}:{minute:02d}'
```

This case passed the test while missing the point:
rathenr than returning an instance of Clock,
this returns a string.

This also incorrectly handles adding negative minutes.

#### Talking Points

##### Magic Methods

The student must figure out that the magic methods such
as __eq__ and __add__ are needed.
