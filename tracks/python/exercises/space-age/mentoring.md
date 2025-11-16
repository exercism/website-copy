# Mentoring

## Problem and Challenges

The problem asks you to write a SpaceAge class.
The constructor takes as input a number holding an age in seconds.
The problem asks you to implement methods on the class that gives the age
as years on various planets in our solar system.


## Reasonable Solution

```python
class SpaceAge:
    def __init__(self, seconds):
        self.seconds = seconds

    @property
    def years(self):
        return self.seconds / 31557600

    def on_venus(self):
        return round(self.years / 0.61519726, 2)

    def on_earth(self):
        return round(self.years / 1, 2)

    def on_mercury(self):
        return round(self.years / 0.2408467, 2)

    def on_mars(self):
        return round(self.years / 1.8808158, 2)

    def on_jupiter(self):
        return round(self.years / 11.862615, 2)

    def on_saturn(self):
        return round(self.years / 29.447498, 2)

    def on_uranus(self):
        return round(self.years / 84.016846, 2)

    def on_neptune(self):
        return round(self.years / 164.79132, 2)
```

## Compact solution

```python
from functools import partial


EARTH_SECONDS = 60 * 60 * 24 * 365.25
PLANET_RATIOS = {
    'mercury': 0.2408467,
    'venus': 0.61519726,
    'earth': 1.0,
    'mars': 1.8808158,
    'jupiter': 11.862615,
    'saturn': 29.447498,
    'uranus': 84.016846,
    'neptune': 164.79132
}


class SpaceAge:

    def __init__(self, seconds):
        self.seconds = seconds

    def _age_on(self, planet):
        return round(self.seconds / EARTH_SECONDS / PLANET_RATIOS[planet], 2)

    def __getattr__(self, name):
        assert name.startswith("on_"), name
        planet = name.removeprefix("on_")
        return partial(self._age_on, planet)
```

## Talking Points

### Module level constants and storing data separately from code.

The factors between Earth years and other planets can be embedded directly
into the various methods. Storing that data in a dictionary separates the logic
from the data and makes both the logic and data easier to read and maintain.

A module-level constant is ideal for storing the seconds-per-Earth-year and the
ratios between planet-years. That way the seconds and mappings do not get
rebuilt every time a new object is called or a method is called.

### Misc

- If you want to go the extra step, type annotation is worth adding to your code!
- Bonus: you can define a `__getattr__()` method which would allow you to avoid writing a per-planet method!
