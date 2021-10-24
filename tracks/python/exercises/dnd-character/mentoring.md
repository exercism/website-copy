# Mentoring

## Problem and Challenges

The problem asks you to write a D&D character generator.
The `modifier()` function needs to handle integer division.
The `Character.ability()` method needs to generate four random digits and sum the three largest values.

## Reasonable Solution

```python
def modifier(n):
    return (n - 10) // 2


class Character:

    def __init__(self):
        self.strength = self.ability()
        self.dexterity = self.ability()
        self.constitution = self.ability()
        self.intelligence = self.ability()
        self.wisdom = self.ability()
        self.charisma = self.ability()
        self.hitpoints = 10 + modifier(self.constitution)

    def ability(self):
        dice = sorted(random.randint(1, 6) for _ in range(4))
        return sum(dice[1:])
```

## Talking Points

### Using `setattr()`

If the `__init__()` code looks too repetitive, it can be reduced with a loop over the traits and a `setattr()`:

```python
TRAITS = ('strength', 'dexterity', 'constitution', 'intelligence', 'wisdom', 'charisma')


class Character:

    self.constitution: int

    def __init__(self):
        for trait in TRAITS:
            setattr(self, trait, self.ability())

        self.hitpoints = 10 + modifier(self.constitution)
```

Note the attribution declaration, `self.constitution: int`. Without this line, pylint will complain, `Instance of 'Character' has no 'constitution' member (no-member)`.

### Removing a min value

Rather than sorting and slicing the rolls, the values can be assigned to a list and then the min value can be dropped:

```python
    def ability(self):
        dice = [random.randint(1, 6) for _ in range(4)]
        return sum(dice[1:])
```
